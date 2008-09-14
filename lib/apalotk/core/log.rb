module ApaloTk
  module Core
    class Log

      attr_reader :processed_lines, :errors
      
      def initialize(logfile, filters={})
        @logfile = logfile 
        @processed_lines = 0
        @errors = 0
        @parser = RegexLogParser.new
      end

      def parser=(parser)
        @parser = parser
      end
      
      def analyze(analyzer)
        invalid_lines = [] 
        File.open(@logfile) do |f|
          f.each do |line|
            @processed_lines += 1
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
