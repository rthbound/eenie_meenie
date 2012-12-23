require "minitest_helper"

describe EenieMeenie::MinyMoe do
  describe ".execute!" do
    before do
      @options = { population: 100, groups: ["Experimental", "Control"] }
      @subject = EenieMeenie::MinyMoe
    end
    it "returns a result" do
      @subject.new(@options.merge(sorter: EenieMeenie::Sorters::RoundRobin)).execute!.must_be_kind_of(EenieMeenie::Result)
    end
  end
end
