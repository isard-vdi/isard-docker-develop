def config():
        try:
            with open('ca-cert.pem', "r") as caFile:
                ca=caFile.read()
        except:
            ca=''
		r.table('hypervisors_pools').update({"viewer": {"certificate": ca,"defaultMode": "Secure" ,"domain": "localhost"}}).run()
            
r.connect(host='rethinkdb', db='isard').repl()
config()
