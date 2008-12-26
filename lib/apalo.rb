require 'time'
require 'zlib'
require File.dirname(__FILE__) + '/apalo/core'
require File.dirname(__FILE__) + '/apalo/cli'

module Apalo

  VERSION = '0.0.104'

  def self.logfile=(l)
    @logfile = l
  end

  def self.logfile
    @logfile
  end

  def self.parser
    @parser ||= Apalo::Core::LogParser.new
  end

  def self.parsing_errors
    @parsing_errors ||= []
  end

end

