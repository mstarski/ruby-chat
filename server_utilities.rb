module Server
    def self.create_server
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

    def self.handle_client_connection(client)
        puts "New user connected: #{client}"
        client.write('Connection successful')
    end

    def self.recv_from_client(client) 
        loop {
            puts "#{client} [#{Time.now}]: #{client.recv(255)}"
        }
    end
end
