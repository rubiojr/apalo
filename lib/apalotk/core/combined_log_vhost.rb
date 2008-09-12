module ApaloTk
  module Core
    class CombinedLogVhost

      attr_reader :processed_lines, :errors
      
      def initialize(logfile)
        @logfile = logfile 
        @processed_lines = 0
        @errors = 0
      end

      def analyze(analyzer)
        invalid_lines = [] 
        regex = '^(([0-9]{1,3}\.){3}[0-9]{1,3}) (\w|-) (\w|-) +\[([/:0-9\+ a-zA-Z]+)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)" \[([0-9\-\.a-zA-Z]+)\]$'
        begin
          require 'oniguruma'
          matcher = Oniguruma::ORegexp.new(regex) 
        rescue Exception => e
          STDERR.puts \
            "WARNING: oniguruma gem not installed. Log analysis will be much slower."
          matcher = /#{regex}/
        end
        items = {}
        File.open(@logfile) do |f|
          f.each do |line|
            @processed_lines += 1
            if matcher.match(line)
              items[:ipaddr]     = $1
              items[:ident]      = $3
              items[:userid]     = $4
              items[:time]       = $5
              items[:request]    = $6
              items[:rcode]       = $7
              items[:rsize]       = $8
              items[:referer]    = $9
              items[:user_agent] = $10
              items[:vhost] = $11
              analyzer.do items
            else
              invalid_lines << "WARNING: line #{@processed_lines} format is invalid.\n#{line}"
              @errors += 1
            end
          end
        end
        return invalid_lines
      end

    end
  end
end
