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
  p.extra_deps << [ "ptools",">= 1.1.6" ]
  p.extra_deps << ["term-ansicolor",">= 1.0"]
  p.extra_deps << ["cmdparse", ">= 0.6.5"]
end

task :publish_gem do
  `scp pkg/*.gem root@slmirror.csic.es:/espejo/rubygems/gems/`
  `ssh slmirror gem generate_index -d /espejo/rubygems/`
end
