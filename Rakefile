require 'rake'
$:.unshift(File.dirname(__FILE__) + "/lib")
require 'apalo'
require 'hoe'

Hoe.new('Apalo', Apalo::VERSION) do |p|
  p.name = "apalo"
  p.author = "Sergio Rubio"
  p.description = %q{Library and utilities to analyse Apache logs}
  p.email = 'sergio@rubio.name'
  p.summary = "Apache Logs Toolkit"
  p.url = "http://github.com/rubiojr/apalo"
  #p.clean_globs = ['test/output/*.png']
  #p.changes = p.paragraphs_of('CHANGELOG', 0..1).join("\n\n")
  p.remote_rdoc_dir = '' # Release to root
  p.developer('Sergio Rubio', 'sergio@rubio.name')
  p.extra_deps = [ 
    "ptools >= 1.1.6",
    "term-ansicolor >= 1.0",
    "cmdparse >= 0.6.5"
  ]
end

