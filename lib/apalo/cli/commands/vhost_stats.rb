Apalo::Cli.plugin 'vhost_stats' do |args|
  vhost = args[0].strip.chomp
  if vhost.nil? or vhost !~ /^([a-z0-9A-Z]+\.)+([a-z0-9A-Z])+$/
    puts "invalid hostname #{vhost}"
    exit 1
  end
  hits = 0
  image_hits = 0
  visits = 0
  bot_hits = 0
  bytes_transferred = 0
  Apalo.parser.each_line do |line|
    next if line.nil? or line.vhost != vhost
    hits += 1
    bot_hits +=1 if line.user_agent.is_a_bot?
    image_hits += 1 if line.request.image? 
    bytes_transferred += line.rsize.to_i if line.rsize != '-'
  end

  puts "Virtual Host: ".ljust(40) + vhost
  puts "Total Hits: ".ljust(40) + hits.to_s
  puts "Images Served: ".ljust(40) + image_hits.to_s
  puts "Bot Hits: ".ljust(40) + bot_hits.to_s
  puts "Visits: ".ljust(40) + (hits - image_hits - bot_hits).to_s
  puts "Bytes Transfered: ".ljust(40) + bytes_transferred.to_s
end
