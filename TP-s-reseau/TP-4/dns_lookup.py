from scapy.all import *
src_ip = "10.33.75.254"
dst_ip = "8.8.8.8"
dst_port = 53
dns_request = Ether(src="c8:89:f3:ac:3b:d4")/IP(src=src_ip, dst=dst_ip) / UDP(dport=dst_port) / DNS(rd=1, qd=DNSQR(qname=sys.argv[1]))
ans, unans = srp(dns_request, timeout=2)

print ("dns reçu ! adresse ip : ", ans[0][1][DNSRR].rdata)
