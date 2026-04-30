import socket

tcp_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
tcp_sock.bind(('localhost', 12345))

while True:
    data, addr = tcp_sock.recvfrom(1024)
    print(data[0].decode(), str(addr))
    tcp_sock.sendto("OK".encode(), addr)