module CCP
  class Base

    def initialize(key)
      raise PollingError 'Unusable key given.' unless key.pollable?

      @key = key
    end

  end
end
