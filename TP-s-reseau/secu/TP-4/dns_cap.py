from scapy.all import *

def print_ip_from_dns(packet):
    if DNS in packet and packet[DNS].opcode == 0 and packet.haslayer(DNSRR):
        answers = packet[DNSRR].rdata
        print(f"Adresse IP de la réponse DNS : {answers}")
sniff(filter="udp port 53", prn=print_ip_from_dns, count=1)
