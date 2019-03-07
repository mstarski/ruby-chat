#!/usr/bin/ruby
require 'socket'
require './server_utilities.rb'
require './client_utilities.rb'
load('./colorize.rb')

welcome_msg = <<EOM
*************************************
RUBY CHAT
*************************************

To create a room press [1]
To join a room press [2]

EOM

puts welcome_msg.red

entry_choice = gets.to_i

##Check if the choice is correct
loop {
    break if entry_choice == 1 or entry_choice == 2
    puts 'Please provide a valid option'.red
    entry_choice = gets.to_i
}

if entry_choice == 1
    server = ServerModule::Server.new
    server_creation = Thread.new{server.create_server()}
    server_creation.join
else 
    client = ClientModule::Client.new
    client.connect_as_client()
end
