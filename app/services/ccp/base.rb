require 'observer'

module CCP
  class Base
    attr_reader :key

    include Observable

    def initialize(key)
      raise PollingError, 'Unusable key given.' unless key.pollable?
      @key = key
     
      # TODO: Does setting up the observer here violate the design pattern's 
      # tender asshole or something?
      AccessObserver.new(self)
    end
  
    def after_api_access(error=nil)
      changed
      notify_observers(error)
    end # after_api_access 

  end
end
