module EenieMeenie
  class Result
    def initialize(options)
      @groups = options[:groups]
      @population = options[:population]
      @imbalance = @groups.values.inject(:-).abs
      @relative_imbalance = (@imbalance / @population).to_f
    end

    def groups
      @groups
    end

    def imbalance
      @imbalance
    end

    def relative_imbalance
      @relative_imbalance
    end
  end
end
