require "minitest_helper"

describe EenieMeenie::Assignment do
  describe ".execute!" do
    before do
      # Mock dependencies
      @member       = MiniTest::Mock.new
      @member_class = MiniTest::Mock.new
      @relation     = MiniTest::Mock.new
      @groups       = ["Experimental", "Control"]
      @group_rules  = {
        "Experimental" => { threshold: 0.5 },
        "Control"      => { threshold: 0.5 }
      }

      @minimum_dependencies = {
        member: @member,
        groups: @groups,
        group_rules: @group_rules
      }

      @member.expect       :class, @member_class
      @member_class.expect :where, @relation, [{}]
      @relation.expect     :where, @relation, [{:experimental_group=>"Control"}]
      @relation.expect     :count, 42
      @relation.expect     :count, 42
      @subject = EenieMeenie::Assignment
    end

    it "initializes when minimum dependencies are provided" do
      proc {
        @subject.new(@minimum_dependencies)
      }.must_be_silent
    end

    it "fails to initialize without required options" do
      @minimum_dependencies.each_key do |key|
        begin
          @subject.new(@minimum_dependencies.reject {|k| k == key })
        rescue => e
          e.must_be_kind_of RuntimeError
        end
      end
    end

    it "produces an expected result" do
      result = @subject.new(@minimum_dependencies.merge({
        groups: ["Control"],
        group_rules: {
          "Control"      => { threshold: 1.0 }
        }
      })).execute!

      assert_equal result, "Control"
    end
  end
end
