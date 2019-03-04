module ServerModule
    class Server
        def create_server
            puts 'Please provide a valid domain'
            domain = gets.to_s
            puts 'Please provide a valid port'
            port = gets.to_i
            puts 'Starting a server ...'
            server = TCPServer.open(domain.chomp, port)
            loop {
                client = server.accept
                t1 = Thread.new{handle_client_connection(client)}
                t2 = Thread.new{recv_from_client(client)}
            }
            server.close
        end

        def handle_client_connection(client)
        sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr
            puts "New user connected: #{remote_hostname}:#{remote_port}"
            client.write("Connection successful\n To exit simply type 'exit'")
        end

        def recv_from_client(client) 
            sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr
            loop {
                puts "#{remote_ip}:#{remote_port} [#{Time.now}]: #{client.recv(255)}"
            }
        end
    end
end
