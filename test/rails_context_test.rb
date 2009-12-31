require 'teststrap'

context "The basic RailsContext" do
  setup do
    RiotRails::RailsContext.new("Ya Ya") { }
  end

  asserts_topic.kind_of(Riot::Context)
  asserts(:transactional?).not!
  asserts(:transaction_helper).equals(::ActiveRecord::Base)
end # The basic RailsContext

context "The transactional RailsContext" do
  setup do
    helper = Class.new { def self.transaction(&block) yield; end }
    RiotRails::RailsContext.new("Ya Ya", :transactional => true, :transaction_helper => helper) { }
  end

  asserts(:transactional?)

  asserts("calling local run") do
    topic.local_run(Riot::SilentReporter.new, Riot::Situation.new)
  end.raises(::ActiveRecord::Rollback)

  context "with a child context" do
    setup do
      topic.context("call me submarine") {}
    end
    asserts(:transactional?)
  end
end # The transactional RailsContext

context "The rails_context macro" do
  setup_test_context

  asserts("Object") { Object }.respond_to(:rails_context)

  asserts("a new Riot::Context") do
    Riot::Context.new("foo") {}
  end.respond_to(:rails_context)

  asserts("its description") do
    Riot::Context.new("foo") {}.rails_context(Room) {}.description
  end.equals("foo Room")

  context "for an ActiveRecord object" do
    setup do
      situation = Riot::Situation.new
      (topic.rails_context(Room) {}).local_run(Riot::SilentReporter.new, situation)
      situation
    end
  
    context "with situational topic" do
      setup { topic.topic }
      asserts_topic.kind_of(Room)
      asserts(:new_record?)
    end # the situational topic

  end # for an ActiveRecord object

  context "defined from the root" do
    setup do
      new_riot = Class.new do
        def self.defined_contexts; @contexts ||= []; end
        def self.context(description, context_class=Context, &definition)
          (defined_contexts << Riot::Context.new(description, &definition)).last
        end

        extend RiotRails::Root
      end
      new_riot.rails_context(Room) {}
      new_riot
    end

    asserts(:defined_contexts).size(1)
  end # defined from the root

end # The rails_context macro