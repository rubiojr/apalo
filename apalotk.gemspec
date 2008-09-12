Gem::Specification.new do |s|
  s.name = %q{apalotk}
  s.version = "0.0.10"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sergio Rubio <sergio@rubio.name"]
  s.date = %q{2008-09-12}
  #s.default_executable = %q{foo}
  s.description = %q{Apache Logs Toolkit}
  s.summary = %q{Library and utilities to analyse Apache logs}
  s.email = %q{sergio@rubio.name}
  s.executables = [ "atk" ]
  #s.extra_rdoc_files = ["README", "COPYING"]
  #s.has_rdoc = true
  s.homepage = %q{http://www.github.com/rubiojr/apalo}
  #s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Foo", "--main", "README"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.4")
  #s.rubyforge_project = %q{mongrel}
  #s.rubygems_version = %q{1.2}
  s.test_files = Dir["test/test_*.rb"]
  s.add_dependency(%q<ptools>, [">= 1.1.6"])
  s.add_dependency(%q<term-ansicolor>, [">= 1.0"])
  s.add_dependency(%q<optiflag>, [">= 0.6.5"])
  s.add_dependency(%q<oniguruma>, [">= 1.0"])
  s.files = Dir["lib/**/*.rb"] #+ Dir["examples/*"]
end
