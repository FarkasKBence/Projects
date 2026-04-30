import socket

tcp_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
udp_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

tcp_sock.bind(('0.0.0.0', 11111))
tcp_sock.listen(1)

while True:
    c_sock, addr = tcp_sock.accept()
    data = c_sock.recvfrom(1024)
    print(data[0].decode() + str(addr))
    udp_sock.sendto((data[0].decode() + "MODOSITOTTAM").encode(), ('localhost', 12345))
    data, _ = udp_sock.recvfrom(1024)
    print("Válasz: " + data.decode())
    c_sock.send(data)
    c_sock.close()
udp_sock.close()