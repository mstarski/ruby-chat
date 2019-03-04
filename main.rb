#!/usr/bin/ruby
require 'socket'
require './server_utilities.rb'
require './client_utilities.rb'

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
    server_creation = Thread.new{Server::create_server()}
    server_creation.join
else 
    Client::connect_as_client()
end
