import socket

udp_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
udp_sock.connect((('localhost', 11111)))

udp_sock.send(input('Uzenet: ').encode())
data = udp_sock.recv(1024)
print(data.decode())
udp_sock.close()