Gem::Specification.new do |s|
  s.name = %q{apalo}
  s.version = "0.0.102"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sergio RubioSergio Rubio"]
  s.date = %q{2008-12-09}
  s.default_executable = %q{atk}
  s.description = %q{Library and utilities to analyse Apache logs}
  s.email = %q{sergio@rubio.namesergio@rubio.name}
  s.executables = ["atk"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "THANKS", "bin/atk", "lib/apalo.rb", "lib/apalo/cli.rb", "lib/apalo/cli/commands/basic.rb", "lib/apalo/cli/commands/hit_counter.rb", "lib/apalo/cli/commands/monthly_stats.rb", "lib/apalo/cli/commands/user_agents.rb", "lib/apalo/cli/commands/vhost_stats.rb", "lib/apalo/cli/commands/vhosts_overview.rb", "lib/apalo/core.rb", "lib/apalo/core/log_line.rb", "lib/apalo/core/log_parser.rb", "lib/apalo/core/log_string.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rubiojr/apalo}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{apalo}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Apache Logs Toolkit}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ptools>, [">= 1.1.6"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0"])
      s.add_runtime_dependency(%q<cmdparse>, [">= 0.6.5"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<ptools>, [">= 1.1.6"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0"])
      s.add_dependency(%q<cmdparse>, [">= 0.6.5"])
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<ptools>, [">= 1.1.6"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0"])
    s.add_dependency(%q<cmdparse>, [">= 0.6.5"])
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
