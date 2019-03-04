module Client
    def self.connect_as_client
        puts 'Please provide a valid domain'
        domain = gets.to_s
        puts 'Please provide a valid port'
        port = gets.to_i
        socket = TCPSocket.new(domain.chomp, port)
        t1 = Thread.new{client_recv_message(socket)}
        t2 = Thread.new{client_send_message(socket)}
    
        t1.join
        t2.join
    
        socket.close
    end
    
    def self.client_recv_message(socket_var)
        puts socket_var.recv(255)
    end
    
    def self.client_send_message(socket_var)
        msg = '' 
        loop {
            msg = gets.to_s
            socket_var.write(msg)
        }
    end
end
