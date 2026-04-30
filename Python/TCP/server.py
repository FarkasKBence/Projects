import socket
import struct
import select

packer = struct.Struct('>12s 1i')

serv_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serv_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
serv_sock.bind(('0.0.0.0', 12345))
serv_sock.listen(1) #egyszerre egy kliennsel foglalkozunk

sock_list = [serv_sock]
balances = {}

while True:
    readable, _, _ = select.select(sock_list, [], [])
    for r in readable:
        if r == serv_sock:
            cli_sock, cli_addr = r.accept()
            print(cli_addr)
            sock_list.append(cli_sock)
            balances[cli_sock] = 10000
        else:
            msg = r.recv(1024) #4 bájt receive
            if msg:
                """
                print(msg)
                packer = struct.Struct('1i')
                string_len = packer.unpack(msg)[0]

                msg = r.recv(1024)
                packer = struct.Struct(str(string_len)+'s 1i')
                print(msg)
                msg, multi = packer.unpack(msg)
                print(msg.decode() + " - " + str(multi))
                answ = ""
                for i in range(multi):
                    answ = answ + msg.decode()
                r.send(answ.encode())
                """
                #"""
                balances[r] += int(msg.decode())
                r.send(('UJ EGYENLEG: ' + str(balances[r])).encode())
                #"""
            else:
                print("Kilépett egy user")
                r.close()
                sock_list.remove(r)
                del(balances[r])
serv_sock.close()