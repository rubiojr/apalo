require 'rubygems'
require 'time'
  
module Apalo

  require 'term/ansicolor'

  class Color
    class << self
      include Term::ANSIColor
    end
  end

  class CombinedLog

    attr_reader :processed_lines, :errors
    
    def initialize(logfile)
      @logfile = logfile 
      @processed_lines = 0
      @errors = 0
    end

    def analyze(analyzer)
      invalid_lines = [] 
      regex = '^(([0-9]{1,3}\.){3}[0-9]{1,3}) (\w|-) (\w|-) +\[([/:0-9\+ a-zA-Z]+)\] "(.*?)" (\d{3}|-) (-|\d{1,20}) "(.*?)" "(.*?)"$'
      begin
        require 'oniguruma'
        matcher = Oniguruma::ORegexp.new(regex) 
      rescue Exception => e
        STDERR.puts \
          "WARNING: oniguruma gem not installed. Log analysis will be much slower."
        matcher = /#{regex}/
      end
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
            analyzer.do items
          else
            invalid_lines << "WARNING: line #{@processed_lines} format is invalid.\n#{line}"
            @errors += 1
          end
        end
      end
      return invalid_lines
    end

  end

  class BasicAnalyzer

    def initialize
      @user_agents = {}
      @response_codes = {}
      @hits_per_ip = {}
      @methods = {}
      @requested_files = {}
      @hits_per_hour = {}
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

      addr = line[:ipaddr]
      if @hits_per_ip[addr].nil?
        @hits_per_ip[addr] = 1
      else
        @hits_per_ip[addr] += 1
      end

      i = line[:time].index(':')
      d = line[:time][0..i-1] 
      t = line[:time][i+1..-1].split[0]
      time = Time.parse("#{d} #{t}").strftime('%Y-%m-%d %H (%A)')
      if @hits_per_hour[time].nil?
        @hits_per_hour[time] = 1
      else
        @hits_per_hour[time] += 1
      end
    end

    def print(view)
      view.render(:user_agents => @user_agents,
                  :response_codes => @response_codes,
                  :hits_per_ip => @hits_per_ip,
                  :methods => @methods,
                  :requested_files => @requested_files,
                  :hits_per_hour => @hits_per_hour)
    end

  end

  class BasicAnalyzerView
    def render(params)
      puts Color.bold("\n** TOP 10 User Agents")
      ua = params[:user_agents]
      find_top10(ua).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end

      puts Color.bold("\n** TOP 10 Response Codes **")
      rc = params[:response_codes]
      find_top10(rc).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end
      
      puts Color.bold("\n** TOP 10 Requested File")
      rf = params[:requested_files]
      find_top10(rf).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end
      
      puts Color.bold("\n** TOP 10 IP Addresses")
      rf = params[:hits_per_ip]
      find_top10(rf).each do |key,val|
        puts "#{val}: ".ljust(10, " ") + "#{key}"
      end
      
      puts Color.bold("\n** TOP 10 Hours (Busiest)")
      rf = params[:hits_per_hour]
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
  tstart = Time.now
  errors = cl.analyze(ba)
  tend = Time.now - tstart
  ba.print(BasicAnalyzerView.new)
  puts
  puts Color.bold("Processed lines: ") + "#{cl.processed_lines}"
  puts Color.bold("Errors:          ") + "#{cl.errors}"
  puts Color.bold("Analisys time:   ") + "#{tend} secs."
end
