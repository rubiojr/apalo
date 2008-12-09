Apalo::Cli.plugin('monthly_stats', 'Stats for the current month') do
  #year, month = Time.now.year, Time.now.month
  #months = { 
  #  1 => 'Jan',
  #  2 => 'Feb',
  #  3 => 'Mar',
  #  4 => 'Apr',
  #  5 => 'May',
  #  6 => 'Jun',
  #  7 => 'Jul',
  #  8 => 'Aug',
  #  9 => 'Sep',
  #  10 => 'Oct',
  #  11 => 'Nov',
  #  12 => 'Dec',
  #}
  #hits = 0
  ts = Time.now
  Apalo.parser.each_line do |line|
  #  if not line.nil?
  #    if line.time =~ /#{months[month]}\/#{year}/
  #      hits += 1 
  #    end
  #  end
  end
  te = Time.now
  puts "#{te - ts} secs"
end
