import rethinkdb as r

def config():
        try:
            with open('mycert.pem', "r") as caFile:
                ca=caFile.read()
        except:
            print('No ca-cert.pem file found')
            exit(1)
        r.table('hypervisors_pools').update({"viewer": {"certificate": ca,"defaultMode": "Secure" 
,"domain": "localhost"}}).run()
            
r.connect(host='rethinkdb', db='isard').repl()
config()


