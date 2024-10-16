#dbworkload run -w ulta_beauty.py --uri 'postgres://root:ultabeauty@10.0.1.85:26257/defaultdb?sslmode=require' -l debug -d 60 -c 20
#dbworkload run -w ulta_beauty.py --uri 'postgres://root:Fr1sbees!@10.0.1.85:26257/defaultdb?sslmode=require' -l debug -c 10 -d 1
dbworkload run -w ulta_beauty.py --uri 'postgres://root@10.0.1.85:26257/defaultdb?sslmode=verify-full&sslrootcert=certs-new/certs/ca.crt&sslcert=certs-new/certs/client.root.crt&sslkey=certs-new/certs/client.root.key' -l debug -c 10 -d 1

