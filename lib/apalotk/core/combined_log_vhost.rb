module ApaloTk
  module Core
    class CombinedLogVhost < Log

      attr_reader :processed_lines, :errors
      
      def initialize(logfile)
        super(logfile)
      end

      def regex
        return '^(([0-9]{1,3}\.){3}[0-9]{1,3}) (\w|-) (\w|-) +\[([/:0-9\+ a-zA-Z]+)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)" \[([0-9\-\.a-zA-Z]+)\]$'
      end

    end
  end
end
