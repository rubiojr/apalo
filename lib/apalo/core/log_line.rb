module Apalo
  module Core
    class LogLine
      attr_accessor :ipaddr, :ident,  :userid, :time
      attr_accessor :request, :rcode, :rsize, :referer, :user_agent
      attr_accessor :vhost, :raw

      def to_s
        @raw
      end
    end
  end
end
