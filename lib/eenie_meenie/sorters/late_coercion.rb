module EenieMeenie
  module Sorters
    class LateCoercion < EenieMeenie::Base
      def initialize(*args, options)
        load_options(:groups, :population, options)
      end

      def sort
        @results = {}
        @groups.each { |group| @results.merge!(group => 0) }

        @population.times do |i|
          @results[assign] += 1
        end
        groups = @results
      end

      def assign
        coercion_threshold_reached? ? assign_with_coercion : assign_without_coercion
      end

      def assign_without_coercion
        selected_group = @groups.sample
        if rand(@population) >= (@population / 2)
          group = selected_group
        else
          group = the_other_group(selected_group)
        end
      end

      def the_other_group group
        (@groups - [group]).first
      end

      def assign_with_coercion
        group = @groups.sample
        group_tally = count_for_group(group)
        other_group = (@groups - [group]).first
        group = other_group if group_tally > count_for_group(other_group) + rand(leeway)

        group
      end

      def count_for_group(group)
        @results[group].to_f
      end

      def leeway
        ((current_population / 2 ) * 0.01).round
      end

      def current_population
        @results.values.inject(&:+).to_f
      end

      def coercion_threshold_reached?
        (current_population / @population) >= 0.9
      end
    end
  end
end
