Apalo::Cli.plugin 'user_agents' do |args|
  args = [] if args.empty?
  agents = []
  Apalo.parser.each_line do |line|
    next if line.nil?
    if args.empty? 
      agents << line.user_agent if not agents.include?(line.user_agent)
    else
      if args.include?(line.vhost) and not agents.include?(line.user_agent)
        agents << line.user_agent
      end
    end
  end
  puts agents
  puts
  puts "Unique User-Agents found: #{agents.size}"
end
