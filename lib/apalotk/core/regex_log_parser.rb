module ApaloTk
  module Core
    class RegexLogParser

      def initialize
        @regex = nil
        @items = {
          :ipaddr     => nil,
          :ident      => nil,
          :userid     => nil,
          :time       => nil,
          :request    => nil,
          :rcode      => nil,
          :rsize      => nil,
          :referer    => nil,
          :user_agent => nil,
          :vhost      => nil
        }
      end
      
      def choose_regex(line)
        if @regex.nil?
          combined = '^(([0-9]{1,3}\.){3}[0-9]{1,3}) (\w|-) (\w|-) +\[([/:0-9\+ a-zA-Z]+)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)"$'
          combinedv = '^(([0-9]{1,3}\.){3}[0-9]{1,3}) (\w|-) (\w|-) +\[([/:0-9\+ a-zA-Z]+)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)" \[([0-9\-\.a-zA-Z]+)\]$'
          if line =~ /#{combined}/
            regex = combined
          else
            regex = combinedv
          end
          begin
            require 'oniguruma'
            @regex = Oniguruma::ORegexp.new(regex) 
          rescue Exception => e
            STDERR.puts \
              "WARNING: oniguruma gem not installed. Log analysis will be much slower."
            @regex  = /#{regex}/
          end
        end
        @regex
      end

      def parse_line(line)
        if choose_regex(line).match(line)
          @items[:ipaddr]      = $1
          @items[:ident]       = $3
          @items[:userid]      = $4
          @items[:time]        = $5
          @items[:request]     = $6
          @items[:rcode]       = $7
          @items[:rsize]       = $8
          @items[:referer]     = $9
          @items[:user_agent]  = $10
          @items[:vhost]       = $11
          return @items 
        end
        return nil
      end

    end
  end
end
