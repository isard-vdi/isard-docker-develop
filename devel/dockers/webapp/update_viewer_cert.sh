import rethinkdb as r

r.connect("rethinkdb-container", 28015).repl()

try:
    with open('/etc/pki/libvirt-spice/ca-cert.pem', "r") as caFile:
        ca=caFile.read()
    with open('/etc/pki/libvirt-spice/domain_name', "r") as dnFile:
        dn=dnFile.read()
except Exception as e:
    print(e)
    exit(0)
if r.db('isard').table('hypervisors_pools').get('default').run() is not None:

    r.db('isard').table('hypervisors_pools').get('default').update({
                                        'viewer':{'defaultMode':'Secure',
                                        'certificate': ca,
                                        'domain':dn}}).run()
print("Updated viewer cert from hypervisor")
