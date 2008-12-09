require 'time'
require File.dirname(__FILE__) + '/apalo/core'
require File.dirname(__FILE__) + '/apalo/cli'
require 'xmlsimple'

module Apalo
  def self.logfile=(l)
    @logfile = l
  end

  def self.logfile
    @logfile
  end

  def self.parser
    @parser ||= LogParser.new
  end

  def self.parsing_errors
    @parsing_errors ||= []
  end

end

