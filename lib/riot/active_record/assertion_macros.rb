module RiotRails
  module ActiveRecord

    class AssertionMacro < ::Riot::AssertionMacro
      def error_from_writing_value(model, attribute, value)
        model.write_attribute(attribute, value)
        model.valid?
        model.errors.on(attribute)
      end
    end

    # An ActiveRecord assertion that expects to fail when a given attribute is validated after a nil value
    # is provided to it.
    #
    #    context "a User" do
    #      setup { User.new }
    #      topic.validates_presence_of(:name)
    #    end
    class ValidatesPresenceOfMacro < AssertionMacro
      register :validates_presence_of

      def evaluate(actual, attribute)
        if error_from_writing_value(actual, attribute, nil)
          pass("validates presence of #{attribute.inspect}")
        else
          fail("expected to validate presence of #{attribute.inspect}")
        end
      end
    end

    # An ActiveRecord assertion that expects to pass with a given value or set of values for a given
    # attribute.
    #
    #    context "a User" do
    #      setup { User.new }
    #      topic.allows_values_for :email, "a@b.cd"
    #      topic.allows_values_for :email, "a@b.cd", "e@f.gh"
    #    end
    class AllowsValuesForMacro < AssertionMacro
      register :allows_values_for

      def evaluate(actual, attribute, *values)
        bad_values = []
        values.each do |value|
          bad_values << value if error_from_writing_value(actual, attribute, value)
        end
        failure_msg = "expected %s to allow value(s) %s"
        bad_values.empty? ? pass : fail(failure_msg % [attribute.inspect, bad_values.inspect])
      end
    end

    # An ActiveRecord assertion that expects to fail with a given value or set of values for a given
    # attribute.
    #
    #    context "a User" do
    #      setup { User.new }
    #      topic.does_not_allow_values_for :email, "a"
    #      topic.does_not_allow_values_for :email, "a@b", "e f@g.h"
    #    end
    class DoesNotAllowValuesForMacro < AssertionMacro
      register :does_not_allow_values_for
      def evaluate(actual, attribute, *values)
        good_values = []
        values.each do |value|
          good_values << value unless error_from_writing_value(actual, attribute, value)
        end
        failure_msg = "expected %s not to allow value(s) %s"
        good_values.empty? ? pass : fail(failure_msg % [attribute.inspect, good_values.inspect])
      end
    end

    # An ActiveRecord assertion that expects to fail with invalid value for an attribute. Optionally, the 
    # error message can be provided as the exact string or as regular expression.
    #
    #    context "a User" do
    #      setup { User.new }
    #      topic.is_invalid_when :email, "fake", "is invalid"
    #      topic.is_invalid_when :email, "another fake", /invalid/
    #    end
    class IsInvalidWhenMacro < AssertionMacro
      register :is_invalid_when

      def evaluate(actual, attribute, value, expected_error=nil)
        actual_errors = Array(error_from_writing_value(actual, attribute, value))
        if actual_errors.empty?
          fail("expected #{attribute.inspect} to be invalid when value is #{value.inspect}")
        elsif expected_error && !has_error_message?(expected_error, actual_errors)
          message = "expected %s to be invalid with error message %s"
          fail(message % [attribute.inspect, expected_error.inspect])
        else
          pass("attribute #{attribute.inspect} is invalid")
        end
      end
    private
      def has_error_message?(expected, errors)
        return true unless expected
        expected.kind_of?(Regexp) ? errors.any? {|e| e =~ expected } : errors.any? {|e| e == expected }
      end
    end

    # An ActiveRecord assertion that expects to fail with an attribute is not valid for record because the
    # value of the attribute is not unique. Requires the topic of the context to be a created record; one
    # that returns false for a call to +new_record?+.
    #
    #    context "a User" do
    #      setup { User.create(:email => "a@b.cde", ... ) }
    #      topic.validates_uniqueness_of :email
    #    end
    class ValidatesUniquenessOfMacro < AssertionMacro
      register :validates_uniqueness_of
      
      def evaluate(actual, attribute)
        actual_record = actual
        if actual_record.new_record?
          fail("topic is not a new record when testing uniqueness of #{attribute.inspect}")
        else
          copied_model = actual_record.class.new
          actual_record.attributes.each do |dup_attribute, dup_value|
            copied_model.write_attribute(dup_attribute, dup_value)
          end
          copied_value = actual_record.read_attribute(attribute)
          if error_from_writing_value(copied_model, attribute, copied_value)
            pass("#{attribute.inspect} is unique")
          else
            fail("expected to fail because #{attribute.inspect} is not unique")
          end
        end
      end
    end

    # An ActiveRecord assertion macro that expects to pass when a given attribute is defined as +has_many+
    # association. Will fail if an association is not defined for the attribute and if the association is
    # not +has_many.jekyll
    #
    #   context "a Room" do
    #     setup { Room.new }
    #
    #     topic.has_many(:doors)
    #     topic.has_many(:floors) # should probably fail given our current universe :)
    #   end
    class HasManyMacro < AssertionMacro
      register :has_many
      
      def evaluate(actual, attribute)
        reflection = actual.class.reflect_on_association(attribute)
        static_msg = "expected #{attribute.inspect} to be a has_many association, but was "
        if reflection.nil?
          fail(static_msg + "not")
        elsif "has_many" != reflection.macro.to_s
          fail(static_msg + "a #{reflection.macro} instead")
        else
          pass("has many #{attribute.inspect}")
        end
      end
    end

  end # ActiveRecord
end # RiotRails
