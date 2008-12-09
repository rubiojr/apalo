def find_top10(hash)
  if hash.values.size > 10
    top10 = hash.values.sort[-10..-1]
  else
    top10 = hash.values.sort
  end
  return \
    hash.find_all { |key,val| top10.include?(val) }.sort{ |a,b| a[1] <=> b[1] }
end


Apalo::Cli.plugin 'basic' do
        user_agents = {}
        response_codes = {}
        hits_per_ip = {}
        methods = {}
        requested_files = {}
        hits_per_hour = {}

      Apalo.parser.each_line do |line|
        next if line.nil? 
        ua = line.user_agent
        if not user_agents[ua].nil?
          user_agents[ua] += 1
        else
          user_agents[ua] = 1
        end

        rc = line.rcode
        if not response_codes[rc].nil?
          response_codes[rc] += 1
        else
          response_codes[rc] = 1
        end
        
        req = line.request.split()[1]
        if not requested_files[req].nil?
          requested_files[req] += 1
        else
          requested_files[req] = 1
        end

        addr = line.ipaddr
        if hits_per_ip[addr].nil?
          hits_per_ip[addr] = 1
        else
          hits_per_ip[addr] += 1
        end

        i = line.time.index(':')
        day,month,year = line.time[0..i-1].split("/")
        t = line.time[i+1..-1].split[0]
        time = Time.parse("#{year}-#{Time.parse(month).month}-#{day} #{t}").strftime('%Y-%m-%d %H (%A)')
        if hits_per_hour[time].nil?
          hits_per_hour[time] = 1
        else
          hits_per_hour[time] += 1
        end
      end
  ua = user_agents
  find_top10(ua).each do |key,val|
    puts "#{val}: ".ljust(10, " ") + "#{key}"
  end

  puts "\n** TOP 10 Response Codes **".bold
  rc = params[:response_codes]
  find_top10(rc).each do |key,val|
    puts "#{val}: ".ljust(10, " ") + "#{key}"
  end
  
  puts "\n** TOP 10 Requested File".bold
  rf = params[:requested_files]
  find_top10(rf).each do |key,val|
    puts "#{val}: ".ljust(10, " ") + "#{key}"
  end
  
  puts "\n** TOP 10 IP Addresses".bold
  rf = hits_per_ip
  find_top10(rf).each do |key,val|
    puts "#{val}: ".ljust(10, " ") + "#{key}"
  end
  
  puts "\n** TOP 10 Hours (Busiest)".bold
  rf = hits_per_hour
  find_top10(rf).each do |key,val|
    puts "#{val}: ".ljust(10, " ") + "#{key}"
  end
end
