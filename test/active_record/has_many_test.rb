require 'teststrap'

context "The has_many assertion macro" do
  setup_test_context
  setup { topic.asserts("room") { Room.new } }

  should("pass when record has a has_many association defined for attribute") do
    topic.has_many(:doors).run(Riot::Situation.new)
  end.equals([:pass, ":doors is a has_many association"])

  should("fail when record does not have a has_many association defined for attribute") do
    topic.has_many(:windows).run(Riot::Situation.new)
  end.equals([:fail, ":windows is not a has_many association"])

  should("fail when attribute is not a has_many, but is a has_one association") do
    topic.has_many(:floor).run(Riot::Situation.new)
  end.equals([:fail, ":floor is not a has_many association"])
end # The has_many assertion macro
