# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{riot_rails}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin 'Gus' Knowlden"]
  s.date = %q{2009-10-11}
  s.description = %q{Riot specific test support for Rails apps. Protest the slow app.}
  s.email = %q{gus@gusg.us}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "lib/riot/active_record/macros.rb",
     "lib/riot/rails.rb",
     "rails/init.rb",
     "test/rails_root/db/schema.rb",
     "test/should_allow_values_for_test.rb",
     "test/should_validate_presence_of_test.rb",
     "test/should_validate_uniqueness_of_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/thumblemonks/riot_rails}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Riot specific test support for Rails apps}
  s.test_files = [
    "test/rails_root/db/schema.rb",
     "test/should_allow_values_for_test.rb",
     "test/should_validate_presence_of_test.rb",
     "test/should_validate_uniqueness_of_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<riot>, [">= 0.9.7"])
      s.add_development_dependency(%q<activerecord>, [">= 2.3.2"])
    else
      s.add_dependency(%q<riot>, [">= 0.9.7"])
      s.add_dependency(%q<activerecord>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<riot>, [">= 0.9.7"])
    s.add_dependency(%q<activerecord>, [">= 2.3.2"])
  end
end
