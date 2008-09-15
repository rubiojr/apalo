module ApaloTk
  module Analyzers
    class VHostStats

      def initialize
        @vtable = {}
      end

      def do(line)
        vhost = line[:vhost]
        return if vhost.nil?
        if @vtable[vhost].nil?
          @vtable[vhost] = {
            :hits => 1,
          }
        else
          @vtable[vhost][:hits] += 1
          rcode = line[:rcode].to_i
          @vtable[vhost][rcode] = 0 if @vtable[vhost][rcode].nil?
          @vtable[vhost][rcode] += 1
        end
      end

      def print(view)
        view.render(:vtable =>  @vtable)
      end

    end

    class VHostStatsConsoleView


      def render_top10(hash, title)
        puts title
        puts 
        if hash.values.size > 10
          top10 = hash.values.sort[-10..-1]
        else
          top10 = hash.values.sort
        end
        hash.find_all { |key,val| top10.include?(val) }.sort{ |a,b| a[1] <=> b[1] }.each do |key,val|
          puts "#{val}: ".ljust(10, " ") + "#{key}" if val != 0
        end
        puts
      end

      def render(params={})
        vtable = params[:vtable]
        hits = {}
        vtable.each do |key,val|
          hits[key] = val[:hits]
        end
        render_top10 hits, "*** Top10 Hits per Virtual Host ***"

        serrors = {}
        vtable.each do |key,val|
          serrors[key] = 0
          [500,501,502,503,504,505].each do |c|
            serrors[key] += val[c] || 0
          end
        end
        render_top10 serrors, "*** Top10 Virtual Host by Server Errors (5xx) ***"
        
        unauth = {}
        vtable.each do |key,val|
          unauth[key] = val[401] || 0
        end
        render_top10 unauth, "*** Top10 Unauthorized Requests by VHost (401) ***"
        forb = {}
        vtable.each do |key,val|
          forb[key] = val[403] || 0
        end
        render_top10 forb, "*** Top10 Forbidden Requests by VHost (403) ***"
      end
    end
  end
end
