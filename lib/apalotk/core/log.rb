module ApaloTk
  module Core
    class Log

      attr_reader :processed_lines, :errors, :filtered_lines
      
      def initialize(logfile, filter = nil)
        @logfile = logfile 
        @processed_lines = 0
        @filtered_lines = 0
        @errors = 0
        @parser = RegexLogParser.new
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

      def parser=(parser)
        @parser = parser
      end
      
      def analyze(analyzer)
        invalid_lines = [] 
        File.open(@logfile) do |f|
          f.each do |line|
            @processed_lines += 1
            if not @filter.nil? and @filter.match(line)
              @filtered_lines += 1
              next
            end
            items = @parser.parse_line(line)
            if items.nil?
              @errors += 1
              invalid_lines << line
            else
              analyzer.do items
            end
          end
        end
        return invalid_lines
      end

    end
  end
end
