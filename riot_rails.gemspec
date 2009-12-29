# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{riot_rails}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin 'Gus' Knowlden"]
  s.date = %q{2009-12-18}
  s.description = %q{Riot specific test support for Rails apps. Protest the slow app.}
  s.email = %q{gus@gusg.us}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/riot/action_controller.rb",
     "lib/riot/action_controller/assertion_macros.rb",
     "lib/riot/action_controller/context_macros.rb",
     "lib/riot/action_controller/situation_macros.rb",
     "lib/riot/active_record.rb",
     "lib/riot/active_record/assertion_macros.rb",
     "lib/riot/rails.rb",
     "rails/init.rb",
     "riot_rails.gemspec",
     "test/action_controller/controller_context_test.rb",
     "test/action_controller/redirected_to_test.rb",
     "test/action_controller/renders_template_test.rb",
     "test/action_controller/renders_test.rb",
     "test/action_controller/response_status_test.rb",
     "test/active_record/allowing_values_test.rb",
     "test/active_record/has_many_test.rb",
     "test/active_record/validates_presence_of_test.rb",
     "test/active_record/validates_uniqueness_of_test.rb",
     "test/rails_root/app/views/rendered_templates/foo_bar.html.erb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/schema.rb",
     "test/teststrap.rb"
  ]
  s.homepage = %q{http://github.com/thumblemonks/riot_rails}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Riot specific test support for Rails apps}
  s.test_files = [
    "test/action_controller/controller_context_test.rb",
     "test/action_controller/redirected_to_test.rb",
     "test/action_controller/renders_template_test.rb",
     "test/action_controller/renders_test.rb",
     "test/action_controller/response_status_test.rb",
     "test/active_record/allowing_values_test.rb",
     "test/active_record/has_many_test.rb",
     "test/active_record/validates_presence_of_test.rb",
     "test/active_record/validates_uniqueness_of_test.rb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/schema.rb",
     "test/teststrap.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<riot>, [">= 0.10.2"])
      s.add_development_dependency(%q<activerecord>, [">= 2.3.2"])
    else
      s.add_dependency(%q<riot>, [">= 0.10.2"])
      s.add_dependency(%q<activerecord>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<riot>, [">= 0.10.2"])
    s.add_dependency(%q<activerecord>, [">= 2.3.2"])
  end
end

