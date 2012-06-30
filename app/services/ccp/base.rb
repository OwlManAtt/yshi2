require 'observer'

module CCP
  class Base
    attr_accessor :api
    attr_reader :key

    include Observable

    def initialize(key)
      raise PollingError, 'Unusable key given.' unless key.pollable?
      @key = key
      @api = EAAL::API.new(@key.identifier, @key.verification_code)
     
      AccessObserver.new(self)
    end
  
    def after_api_access(error=nil)
      changed
      notify_observers(error)
    end # after_api_access 

  end
end
