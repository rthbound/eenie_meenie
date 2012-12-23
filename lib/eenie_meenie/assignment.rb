module EenieMeenie
  class Assignment < ::EenieMeenie::Base
    def initialize(options)
      load_options(:groups, :member_class, options)
      raise ArgumentError unless @member_class.respond_to?(:group)
    end

    def execute!
      groups = @sorter.new(groups: @groups, population: @population).sort
      return EenieMeenie::Result.new(groups: groups, population: @population)
    end

    private

    def assign
      group = @groups.sample
      group_tally = count_for_group(group)
      other_group = (@groups - [group]).first
      group = other_group if group_tally > count_for_group(other_group) + rand(7)
    end

    def count_for_group(group)
      @member_class.where(group: group).count
    end
  end
end
