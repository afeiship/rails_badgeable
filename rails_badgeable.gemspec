require_relative "lib/rails_badgeable/version"

Gem::Specification.new do |spec|
  spec.name        = "rails_badgeable"
  spec.version     = RailsBadgeable::VERSION
  spec.authors     = [ "aric.zheng" ]
  spec.email       = [ "1290657123@qq.com" ]
  spec.homepage    = "https://github.com/afeiship/rails_badgeable"
  spec.summary     = "A Rails engine for polymorphic, reusable badges on any model."
  spec.description = "A lightweight Rails Engine that enables any ActiveRecord model to associate with predefined badges via polymorphic many-to-many relationships. Features database-level constraints, namespace isolation, and optional short aliases."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/afeiship/rails_badgeable/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/afeiship/rails_badgeable/blob/main/README.md"
  spec.metadata["ai_assistant_uri"] = "https://github.com/afeiship/rails_badgeable/blob/main/llms.txt"

  spec.required_ruby_version = ">= 3.0.0"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "llms.txt"]
  end

  spec.add_dependency "rails", ">= 6.0", "< 9.0"
end
