desc = 'reports hits, type of requests, bots request...'
Apalo::Cli.plugin('hit_counter', desc) do |args|
  size = File.size(Apalo.logfile)
  sizes = %w[KB MB GB]
  choosen_size = 0
  hits = 0
  posts = 0
  gets = 0
  options = 0
  heads = 0
  propfinds = 0
  start_date = nil
  end_date = nil
  puts = 0
  locks = 0
  bot_hits = 0
  visits = 0
  images = 0
  while size/1024.0 > 1000
    choosen_size += 1
    size = size/1024
  end

  puts "Log file size: #{sprintf('%-.2f', (size/1024.0).to_s)} #{sizes[choosen_size]}"

  Apalo.parser.each_line do |line|
    start_date = line.time.split[0].split(':')[0] if start_date.nil?
    end_date = line.time.split[0].split(':')[0] 
    hits  += 1
    if line.request.is_post?
      posts += 1
    elsif line.request.is_get?
      gets += 1
    elsif line.request.is_options?
      options += 1
    elsif line.request.is_head?
      heads += 1
    elsif line.request.is_propfind?
      propfinds += 1
    elsif line.request.is_put?
      puts += 1
    elsif line.request.is_lock?
      locks += 1
    else
      puts
    end
    bot_hits += 1 if  line.user_agent.is_a_bot?
    images += 1 if line.request.image?
    if not line.request.is_a_bot? and not line.request.image?
      visits += 1
    end
  end
  
  puts "First log date: ".ljust(30) + start_date
  puts "Las log date: ".ljust(30) + end_date
  puts "Total request: ".ljust(30) + hits.to_s
  puts "Visits received: ".ljust(30) + visits.to_s
  puts "Total POST request: ".ljust(30) + posts.to_s
  puts "Total GET requests: ".ljust(30) + gets.to_s
  puts "Total OPTION requests: ".ljust(30) + options.to_s
  puts "Total HEAD requests: ".ljust(30) + heads.to_s
  puts "Total PROPFIND requests: ".ljust(30) + propfinds.to_s
  puts "Total PUT requests: ".ljust(30) + puts.to_s
  puts "Total LOCK requests: ".ljust(30) + locks.to_s
  puts "Images served: ".ljust(30) + images.to_s
  puts "Bots Requests: ".ljust(30) + bot_hits.to_s
end
