module EenieMeenie
  class MinyMoe < ::EenieMeenie::Base
    def initialize(options)
      load_options(:groups, :population, :sorter, options)
    end

    def execute!
      groups = @sorter.new(groups: @groups, population: @population).sort
      return EenieMeenie::Result.new(groups: groups, population: @population)
    end

    private
  end
end
