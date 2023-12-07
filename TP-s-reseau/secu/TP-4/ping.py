from scapy.all import *
ping = ICMP(type=8)
packet = IP(src="192.168.0.24", dst="192.168.0.254")
frame = Ether(src="c8:89:f3:ac:3b:d4", dst="34:27:92:67:1e:1e")
final_frame = frame/packet/ping 
answers, unanswered_packets = srp(final_frame, timeout=10)
if answers:
    print(f"Pong reçu : {answers[0]}")
else:
    print("Pas de pong reçu")
print(answers)