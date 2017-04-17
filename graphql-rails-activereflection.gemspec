$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'graphql/rails/active_reflection'

Gem::Specification.new do |s|
  s.name        = 'graphql-rails-activereflection'
  s.version     = GraphQL::Rails::ActiveReflection::VERSION
  s.date        = Date.today.to_s
  s.summary = "Reflection over GraphQL for ActiveRecord models and validators"
  s.description = "Reflection over GraphQL for ActiveRecord models and validators"
  s.authors     = ["Cole Turner"]
  s.email       = 'turner.cole@gmail.com'
  s.files       = Dir["{lib}/**/*", "LICENSE", "README.md", "CHANGELOG.md"]
  s.homepage    = 'http://rubygems.org/gems/graphql-rails-activereflection'
  s.license     = 'MIT'

  s.add_runtime_dependency "graphql", ['>= 1.5.0', '< 2.0']
  s.add_development_dependency "activerecord"
  s.required_ruby_version = '>= 2.3.0'
end
