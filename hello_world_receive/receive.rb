# consumer

require 'bunny'

def receive
	begin
		conn = Bunny.new(:automatically_recover => false, hostname: 'rabbitmq')
		conn.start

		ch   = conn.create_channel

		q    = ch.queue('bunny.hello')

		puts " [*] Waiting for messages. To exit press CTRL+C"
		q.subscribe(:block => true) do |delivery_info, properties, body|
			puts " [x] Received #{body}"
      File.open('/Users/anton/RubymineProjects/Rails/mkdev/rabbit/logs_rabbitmq.log', 'a') { |f| f.puts("[x]:#{body}\n") }
		end
	  
	rescue Bunny::TCPConnectionFailedForAllHosts => e
		sleep 2
		receive
	end	
end

receive
