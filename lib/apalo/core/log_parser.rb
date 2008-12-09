module Apalo
  module Core
    class LogParser

      attr_reader :processed_lines, :errors, :filtered_lines
      
      def initialize(filter = nil)
        @processed_lines = 0
        @filtered_lines = 0
        @errors = 0
        if filter
          begin
            require 'oniguruma'
            @filter = Oniguruma::ORegexp.new(filter) 
          rescue Exception => e
            STDERR.puts \
              "WARNING: oniguruma gem not installed. Log analysis will be much slower."
            @filter  = /#{filter}/
          end
        end
      end

      def each_line
        @regex = nil
        @logline = LogLine.new
        r = [
        '(\d+\.\d+\.\d+\.\d+)',    # ip
        '(.*?)',                   # foo
        '(.*?)',                   # bar
        '\[(.*?)\]',             # datetime
        '"(.*?)"',                 # request
        '(\d+)',                 # code
        '(-|\d+)',               # size
        '"(.*?)"',                 # referer
        '"(.*?)"',               # user-agent 
        '\[(.*?)\]'              # vhost
        ]
        logr = "^#{r.join('\s+')}$"
        begin
          require 'oniguruma'
          @regex = Oniguruma::ORegexp.new(logr) 
        rescue Exception => e
          puts e.message
          STDERR.puts \
            "WARNING: oniguruma gem not installed. Log analysis will be much slower."
          @regex  = /#{r}/
        end
        File.open(Apalo.logfile) do |f|
          f.each_line do |line|
            @processed_lines += 1
            if @regex.match(line)
              @logline.ipaddr      = $1
              @logline.ident       = $2
              @logline.userid      = $3
              @logline.time        = $4
              @logline.request     = $5
              @logline.rcode       = $6
              @logline.rsize       = $7
              @logline.referer     = $8
              @logline.user_agent  = $9
              @logline.vhost       = $10
              @logline.raw         = line
              yield @logline
            end
          end
        end
      end

    end
  end # module Core
end # module Apalo
