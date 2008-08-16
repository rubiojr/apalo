require 'rubygems'
module Apalo
  class CombinedLog

    attr_reader :processed_lines, :errors
    
    def initialize(logfile)
      @logfile = logfile 
      @processed_lines = 0
      @errors = 0
    end

    def analyze(analyzer)
        regex = '^(([0-9]{1,3}\.){3}[0-9]{1,3}) (\w|-) (\w|-) +\[([/:0-9\+ a-zA-Z]+)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)"$'
      begin
        require 'oniguruma'
        matcher = Oniguruma::ORegexp.new(regex) 
      rescue Exception => e
        STDERR.puts \
          "WARNING: oniguruma gem not installed. Log analysis will be much slower."
        matcher = /#{regex}/
      end
      #re = /^(([0-9]{1,3}\.){3}[0-9]{1,3}) (-|\w) (-|w) +\[(.*?)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)"$/
      items = {}
      File.open(@logfile) do |f|
        f.each do |line|
          @processed_lines += 1
          if matcher.match(line)
            items[:ipaddr]     = $1
            items[:ident]      = $3
            items[:userid]     = $4
            items[:time]       = $5
            items[:request]    = $6
            items[:rcode]       = $7
            items[:rsize]       = $8
            items[:referer]    = $9
            items[:user_agent] = $10
            #yield Logline.new(items)
            analyzer.do items
          else
            STDERR.puts "WARNING: line does not match.\n#{line}"
            @errors += 1
          end
        end
      end
    end

  end

  #
  # model
  #
  class Logline
    def initialize(items)
      @items = items
    end
    def method_missing(m)
      @items[m.to_sym]
    end

    def to_s
      @items.values.join(" ")
    end
  end


  #
  # Controller
  #
  class BasicAnalyzer

    def initialize
      @user_agents = {}
      @response_codes = {}
      @hits_per_ip = {}
      @methods = {}
      @requested_files = {}
    end

    def do(line)
      ua = line[:user_agent]
      if not @user_agents[ua].nil?
        @user_agents[ua] += 1
      else
        @user_agents[ua] = 1
      end
      rc = line[:rcode]
      if not @response_codes[rc].nil?
        @response_codes[rc] += 1
      else
        @response_codes[rc] = 1
      end
      
      req = line[:request].split()[1]
      if not @requested_files[req].nil?
        @requested_files[req] += 1
      else
        @requested_files[req] = 1
      end
    end

    def print(view)
      view.render(:user_agents => @user_agents,
                  :response_codes => @response_codes,
                  :hits_per_ip => @hits_per_ip,
                  :methods => @methods,
                  :requested_files => @requested_files)
    end
  end

  class BasicAnalyzerView
    def render(params)
      puts "\n** TOP 10 User Agents" 
      ua = params[:user_agents]
      find_top10(ua).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end

      puts "\n** TOP 10 Response Codes"
      rc = params[:response_codes]
      find_top10(rc).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end
      
      puts "\n** TOP 10 Requested File"
      rf = params[:requested_files]
      find_top10(rf).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end
    end

    def find_top10(hash)
      if hash.values.size > 10
        top10 = hash.values.sort[-10..-1]
      else
        top10 = hash.values.sort
      end
      return \
        hash.find_all { |key,val| top10.include?(val) }.sort{ |a,b| a[1] <=> b[1] }
    end

  end

end

if $0.eql? __FILE__
  include Apalo
  cl = CombinedLog.new("logs/combined")
  ba = BasicAnalyzer.new
  cl.analyze(ba)
  ba.print(BasicAnalyzerView.new)
  puts
  puts "Processed lines: #{cl.processed_lines}"
  puts "Errors:          #{cl.errors}"
end
