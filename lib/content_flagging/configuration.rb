module ContentFlagging
  class Configuration
    attr_accessor :flag_threshold

    def initialize
      @flag_threshold = 3
    end
  end
end