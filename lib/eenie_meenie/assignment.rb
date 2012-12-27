module EenieMeenie
  class Assignment < ::EenieMeenie::Base
    def initialize(options)
      load_options(:groups, :member_class, options)
      raise ArgumentError unless @member_class.respond_to?(:group)
    end

    def execute!
      group = assign
    end

    private

    def assign
      coercion_threshold_reached? ? assign_with_coercion : assign_without_coercion

      return group
    end

    def count_for_group(group)
      @member_class.where(group: group).count
    end

    def assign_without_coercion
      selected_group = @groups.sample
      if rand(expected_population) >= (expected_population / 2)
        group = selected_group
      else
        group = the_other_group(selected_group)
      end
    end

    def assign_with_coercion
      group = @groups.sample
      group_tally = count_for_group(group)
      other_group = (@groups - [group]).first
      group = other_group if group_tally > count_for_group(other_group) + rand(leeway)
    end

    def expected_population
      60000.to_f
    end

    def current_population
      @member_class.count.to_f
    end

    def leeway
      ((current_population / 2 ) * 0.01).round
    end

    def the_other_group group
      (@groups - [group]).first
    end

    def coercion_threshold_reached?
      (current_population / expected_population) >= 0.9
    end
  end
end
