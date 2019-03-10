module ServerModule
    class Server
        def initialize
            @clients = Array.new
        end

        def create_server
            puts 'Please provide a valid domain'.green
            domain = gets.to_s
            puts 'Please provide a valid port'.green
            port = gets.to_i
            puts 'Starting a server ...'
            server = TCPServer.open(domain.chomp, port)
            loop {
                Thread.start(server.accept) do |client|
                    @clients.push(client)
                    t1 = Thread.new{handle_client_connection(client)}
                    t2 = Thread.new{recv_from_client(client)}
                end
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
                client_message = client.recv(255)
                break if client_message.chomp == ""
                @clients.each do |c, index|
                    begin
                        if c != client
                            c.write("#{remote_ip}:#{remote_port} [#{Time.now}]: #{client_message}")
                        end
                    rescue
                        @clients.delete_at(index.to_i)
                    end
                end
                puts "#{remote_ip}:#{remote_port} [#{Time.now}]: #{client_message}"
            }
            client.close
        end
    end
end
