module EenieMeenie
  module Sorters
    class PureRandom < EenieMeenie::Base
      def initialize(*args, options)
        load_options(:groups, :population, options)
      end

      def sort
        results = {}
        @groups.each { |group| results.merge!(group => 0) }

        @population.times do |i|
          results[(rand(@population) >= (@population / 2) ? @groups.first : @groups.last)] += 1
        end
        groups = results
      end
    end
  end
end

