module Apalo
  module Core
    class LogLine
      attr_accessor :ipaddr, :ident,  :userid, :time
      attr_accessor :request, :rcode, :rsize, :referer, :user_agent
      attr_accessor :vhost, :raw
    end
  end
end
