#!/usr/bin/ruby
require 'socket'
def create_server()
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
    puts "New user connected: #{client}"
    client.write('Connection successful')
end

def recv_from_client(client) 
    loop {
        puts "#{client} [#{Time.now}]: #{client.recv(255)}"
    }
end

def connect_as_client
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

def client_recv_message(socket_var)
    puts socket_var.recv(255)
end

def client_send_message(socket_var)
    msg = '' 
    loop {
        msg = gets.to_s
        socket_var.write(msg)
    }
end


puts <<EOM
*************************************
RUBY CHAT
*************************************

To create a room press [1]
To join a room press [2]
EOM

entry_choice = gets.to_i

##Check if the choice is correct
loop {
    break if entry_choice == 1 or entry_choice == 2
    puts 'Please provide a valid option'
    entry_choice = gets.to_i
}

if entry_choice == 1
    server_creation = Thread.new{create_server()}
    server_creation.join
else 
    connect_as_client()
end
