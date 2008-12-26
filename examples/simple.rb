require 'rubygems'
require 'apalo'

Apalo::logfile = '/data/logs/httpd/access_log'
Apalo.parser.each_line do |l|
    puts l.ipaddr
      puts l.user_agent
end
