# producer

require 'bunny'


def bunny_send(n)
  message = "I sent message: #{n}"

  conn = Bunny.new(hostname: ENV['RABBITMQ_HOSTNAME'])
  conn.start

  ch = conn.create_channel

  q = ch.queue('bunny.hello')

  ch.default_exchange.publish(message, routing_key: q.name)
  puts " [x] Sent '#{message}'"

  conn.close
end

def start
  begin
    10.times { |n| bunny_send(n+1); sleep 2 }
  rescue Bunny::TCPConnectionFailedForAllHosts => e
    sleep 2
    start
  end
end

start
