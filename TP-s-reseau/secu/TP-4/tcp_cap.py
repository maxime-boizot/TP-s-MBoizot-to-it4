from scapy.all import *

def print_it_please(packet):
    print("TCP SYN ACK reçu !")
    print("- Adresse IP src :", packet[IP].src)
    print("- Adresse IP dst :", packet[IP].dst)
    print("- Port TCP src :", packet[TCP].sport)
    print("- Port TCP src :", packet[TCP].dport)
sniff(filter="tcp[tcpflags] == tcp-syn|tcp-ack", prn=print_it_please, count=1)