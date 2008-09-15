module Apalo
  module Analyzers
    class Factory

      def self.create(name)
        object = case name
          when "basic": Basic.new
          when "vhost_stats": VHostStats.new
          else Dummy.new
        end
      end

      def self.create_console_view(name)
        object = case name
          when "basic": BasicConsoleView.new
          when "vhost_stats": VHostStatsConsoleView.new
          else DummyConsoleView.new
        end

      end

    end

  end
end
