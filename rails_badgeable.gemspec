require_relative "lib/rails_badgeable/version"

Gem::Specification.new do |spec|
  spec.name        = "rails_badgeable"
  spec.version     = RailsBadgeable::VERSION
  spec.authors     = [ "aric.zheng" ]
  spec.email       = [ "1290657123@qq.com" ]
  spec.homepage    = "https://github.com/afeiship/rails_badgeable"
  spec.summary     = "Add limited, reusable badges to multiple models via polymorphic associations."
  spec.description = "A Rails engine that allows you to add limited, reusable badges to any model through polymorphic associations. Badge counts can be constrained per model instance."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/afeiship/rails_badgeable"
  spec.metadata["changelog_uri"] = "https://github.com/afeiship/rails_badgeable/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0.0"
end
