import sys,requests,pprint
import threading
import os, time
import rethinkdb as r
from rethinkdb.errors import RqlRuntimeError, RqlDriverError

RDB_HOST =  os.environ.get('RDB_HOST') or 'rethinkdb-container'
RDB_PORT = os.environ.get('RDB_PORT') or 28015
TODO_DB = 'isard'
dbonline=False
while not dbonline:
    try:
        rdb_conn = r.connect(host=RDB_HOST, port=RDB_PORT, db=TODO_DB)
        dbonline=True
    except:
        time.sleep(2)

code=False
while not code:
    try:        
        cfg=r.table('config').get(1).pluck('resources').run(rdb_conn)['resources']
        url=cfg['url']
        code=cfg['code']
    except:
        None
    time.sleep(2)
#~ rdb_conn.close()

print('Starting download updates threads')
class DownloadThread(threading.Thread,object):
    def __init__(self,table,path,id):
        self.table=table
        self.path=path
        self.id=id
        self.conn = r.connect(host=RDB_HOST, port=RDB_PORT, db=TODO_DB)
        threading.Thread.__init__(self)
        self.stop=False
        
    def run(self):
        global url,code, RDB_HOST, RDB_PORT, TODO_DB
        rdb_conn = r.connect(host=RDB_HOST, port=RDB_PORT, db=TODO_DB)
        try:
            os.makedirs(self.path.rsplit('/',1)[0], exist_ok=True)
            with open(self.path, "wb") as f:
                response = requests.get(url+'/storage/'+self.table+'/'+self.path.split('/')[-1], headers={'Authorization':code}, stream=True)
                total_length = response.headers.get('content-length')
                
                r.table(self.table).get(self.id).update({'status':'DownloadInProgress'}).run(rdb_conn)
                if total_length is None: # no content length header
                    f.write(response.content)
                else:
                    dl = 0
                    total_length = int(total_length)
                    print('Start: '+self.path)
                    predl=0
                    for data in response.iter_content(chunk_size=4096):
                        dl += len(data)
                        f.write(data)
                        done=int(dl*100/total_length)
                        if done>predl:
                            r.table(self.table).get(self.id).update({'percentage':done}).run(rdb_conn)
                        predl=done
                    print('Finish: '+self.path)
                    r.table(self.table).get(self.id).update({'status':'Stopped'}).run(rdb_conn)
                    time.sleep(2)
                    r.table(self.table).get(self.id).update({'status':'Updating'}).run(rdb_conn)
        except Exception as e:
            print('Download exception: '+str(e))
        rdb_conn.close()

        
def run():
            downloadThreads={}
            global rdb_conn
            for c in r.table('media').get_all(r.args(['DownloadStarting','Downloading']),index='status').pluck('id','path','isard-web','status').merge({'table':'media'}).changes(include_initial=True).union(
                    r.table('domains').get_all(r.args(['DownloadStarting','Downloading']),index='status').pluck('id','create_dict','isard-web','status').merge({"table": "domains"}).changes(include_initial=True)).run(rdb_conn):
                try:
                    if 'old_val' not in c:
                        # Initial status
                        print('INITIAL STATUS')
                        pprint.pprint(c)
                        path=c['new_val']['table']+'/'+c['new_val']['path'] if c['new_val']['table']=='media' else c['new_val']['create_dict']['hardware']['disks'][0]['file']
                        downloadThreads[c['new_val']['id']]=DownloadThread(c['new_val']['table'],'/isard/'+path,c['new_val']['id'])
                        downloadThreads[c['new_val']['id']].daemon = True
                        downloadThreads[c['new_val']['id']].start()
                        pprint.pprint(downloadThreads)
                        continue
                except Exception as e:
                    print('DomainsStatusThread error:'+str(e))

run()

