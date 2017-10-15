# получатель

require 'bunny'

def receive
	begin
		conn = Bunny.new(:automatically_recover => false, hostname: 'rabbitmq')
		conn.start

		puts "DEBUG"
		puts "DEBUG"
		puts "Создал экземпляр коннекта Bunny: #{conn.inspect}"
		puts "DEBUG"
		puts "DEBUG"

		ch   = conn.create_channel

		puts "DEBUG"
		puts "DEBUG"
		puts "Создал канал: #{ch.inspect}"
		puts "DEBUG"
		puts "DEBUG"

		q    = ch.queue('bunny.hello')

		puts "DEBUG"
		puts "DEBUG"
		puts "Создал очередь: #{q.inspect}"
		puts "DEBUG"
		puts "DEBUG"

		puts " [*] Waiting for messages. To exit press CTRL+C"
		q.subscribe(:block => true) do |delivery_info, properties, body|
			puts "DEBUG"
			puts "DEBUG"
			puts " [x] Received #{body}"
      File.open('/Users/anton/RubymineProjects/Rails/mkdev/rabbit/logs_rabbitmq.log', 'a') { |f| f.puts("[x]:#{body}\n") }
      puts "DEBUG"
			puts "DEBUG"
		end
	  
	rescue Bunny::TCPConnectionFailedForAllHosts => e
		puts "DEBUG"
		puts "DEBUG"
		puts "Error: Кролик упал("
		puts "DEBUG"
		puts "DEBUG"
		sleep 2
		receive
	end	
end

puts "DEBUG"
puts "DEBUG"
puts 'Попытка запуска кролика'
puts "DEBUG"
puts "DEBUG"
receive
