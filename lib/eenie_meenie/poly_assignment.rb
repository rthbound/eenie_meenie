module EenieMeenie
  class PolyAssignment < ::EenieMeenie::Base
    def initialize(options)
      options = {
        class_rules: {}
      }.merge(options)

      load_options(:group_rules, :class_rules, :groups, :member, options)
    end

    def execute!
      set_group_counts
      return random_group
    end

    private

    # Total population
    def population
      @members ||= @member.class.where(@class_rules)
    end

    # Current population in each group
    def set_group_counts
      @group_rules.each do |k,v|
        v[:count] = population.where(experimental_group: k.to_s).count
      end
    end

    # Groups not over threshold
    def group_candidates
      @group_candidates ||= @group_rules.reject { |k,v|
        v[:threshold] && (v[:count] / @members.count.to_f) >= v[:threshold]
      }.keys.map(&:to_s)

      @group_candidates.select {|cand| @groups.include?(cand) }
    end

    def random_group
      group_candidates.sample || @groups.sample
    end
  end
end
