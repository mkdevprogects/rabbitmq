# отправитель

require 'bunny'


def send(message, n)
  message = "#{message} #{n}"

  conn = Bunny.new(hostname: 'rabbitmq')
  conn.start

  ch = conn.create_channel

  q = ch.queue('bunny.hello')

  ch.default_exchange.publish(message, routing_key: q.name)
  puts " [x] Sent '#{message}'"

  conn.close
end

def start
  message = 'I sent message: '
  10.times { |n| send(message, n+1); sleep 2 }
end


begin
  start
rescue Bunny::TCPConnectionFailedForAllHosts => e
  start
end
