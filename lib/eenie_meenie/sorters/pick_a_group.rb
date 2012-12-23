module EenieMeenie
  module Sorters
    class PickAGroup < EenieMeenie::Base
      def initialize(*args, options)
        load_options(:groups, :population, options)
      end

      def sort
        results = {}
        @groups.each { |group| results.merge!(group => 0) }

        @population.times do |i|
          group = @groups.sample
          other_group = (@groups - [group]).first
          group = other_group if results.values.any? {|v| results[group] > v + rand(10) }
          results[group] += 1
        end
        groups = results
      end
    end
  end
end

