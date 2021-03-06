Gem::Specification.new do |s|
  s.name        = 'RubyLitDep'
  s.version     = '1.0'
  s.executables << 'rubylitdep'
  s.date        = '2015-02-22'
  s.summary     = "Literate Deployment Scripting!"
  s.description = "A program for executing literate deployment scripts"
  s.authors     = ["Marcel Heinz","Philipp Helsper","Tobias M. Schmidt"]
  s.email       = 'tmschmidt@uni-koblenz.de'
  s.files       = %w(LICENSE README.md Rakefile Gemfile) + Dir.glob("{bin,lib,spec,showcases}/**/*")
  s.homepage    = 'https://github.com/tms-91/RubyLitDep'
  s.add_runtime_dependency 'qtbindings', '~>4.8'
  s.license       = 'GPL'
end