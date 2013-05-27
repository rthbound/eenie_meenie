module EenieMeenie
  class Assignment < PayDirt::Base
    def initialize(options)
      options = {
        class_rules: {}
      }.merge(options)

      load_options(:member, :class_rules, :groups, :group_rules, options)
    end

    def execute!
      set_group_counts and return random_group
    end

    private
    # eenie_meenie users can specify the population
    # using the :members option, e.g.
    #   EenieMeenie::Assignment.new({
    #     member:  @some_member,
    #     members: MemberClass.where(something).joins(another),
    #     groups:  ["Experimental", "Control"],
    #     group_rules: {
    #       "Experimental" => { threshold: 0.51 },
    #       "Control"      => { threshold: 0.51 }
    #     }
    #   }).execute!
    #
    # By default, eenie_meenie will consider all records
    # in the provided `:member`s class to be the population.
    #
    # If the :class_rules option is given, eenie_meenie will pass
    # its value on to #where
    def population
      @members ||= @member.class.where(@class_rules)
    end

    # Add some data to the hash before processing
    def set_group_counts
      @group_rules.each do |k,v|
        v[:count] = population.where(experimental_group: k.to_s).count
      end
    end

    # Pick from options whose thresholds have not been reached
    def candidates
      @group_rules.select { |k,v|
        @groups.include?(k) && !busts_threshold?(k)
      }.keys
    end

    # Does the group's representation exceed the provided threshold?
    def busts_threshold?(group_key)
      group = @group_rules[group_key]
      group[:count] / @members.count.to_f >= (group[:threshold] || 1)
    end

    # Fallback on provided group options
    def random_group
      candidates.sample || @groups.sample
    end
  end
end
