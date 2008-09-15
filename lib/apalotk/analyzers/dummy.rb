module ApaloTk
  module Analyzers
    class Dummy 

      def initialize
      end

      def do(line)
      end

      def print(view)
        view.render
      end

    end
    
    class DummyConsoleView
      def render(params={})
        puts "Dummy View"
      end
    end
    
    class DummyWebView
      def render(params={})
      end
    end

    class DummyPDFView
      def render(params={})
      end
    end

  end
end
