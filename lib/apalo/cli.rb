module Apalo
  module Cli
    def self.init(version)
      @cmd = CmdParse::CommandParser.new( true, true )
      @cmd.program_name = "knocked"
      @cmd.program_version = version.split('.')
      @cmd.options = CmdParse::OptionParserWrapper.new do |opt|
            opt.separator "Global options:"
                  opt.on("--verbose", "Be verbose when outputting info") {|t| $verbose = true }
      end
      @cmd.options = CmdParse::OptionParserWrapper.new do |opt|
        opt.on("-l FILE", "--logfile FILE", "Log file to analyze") { |f| Apalo.logfile = f }
      end
      @cmd.add_command( CmdParse::HelpCommand.new )
      @cmd.add_command( CmdParse::VersionCommand.new )
      #puts "## loading built in commands ##"
      Dir["#{File.dirname(__FILE__)}/cli/commands/*.rb"].each do |f|
        #puts "#{f}"
        load f
      end
      load_plugins
    end

    def self.plugin(cmd, description = 'test')
      c = CmdParse::Command.new( cmd, false, false )
      c.short_desc = description
      c.set_execution_block do |args|
        yield args
      end
      @cmd.add_command c
    end

    def self.run
      @cmd.parse
    end

    private
    def self.load_plugins
      if File.directory?("#{ENV['HOME']}/.apalo/commands")
        #puts '### loading  custom plugins ###'
        Dir["#{ENV['HOME']}/.apalo/commands/*.rb"].each do |p|
          begin
            #puts p
            load p
          rescue SyntaxError
            puts "Error loading plugin #{p}"
          end
        end
      end
    end
  end
end

