module CCP
  class AccessObserver
    PROTOCOL_FAILURE_EXCEPTIONS = [
      EAAL::Exception::APINotFoundError, 
      EAAL::Exception::HTTPError,
    ]
    
    # Yes, this is silly. See comment block below.
    PERMANENT_FAILURE_EXCEPTIONS = [
      'EveAPIException201',
      'EveAPIException202',
      'EveAPIException203',
      'EveAPIException204',
      'EveAPIException205', 
    ]

    def initialize(api_consumer_class)
      @api_consumer = api_consumer_class
      @api_consumer.add_observer(self)  
    end # initialize

    def update(error=nil)
      key = @api_consumer.key

      key.last_polled_at = Time.now
      key.permanent_failure = false
      
      # TODO: This section requires some EAAL enhancements before it's done.
      # None of the EAAL::Exception classes implement a way to get the underlying
      # issue code, which I want to log.
      #
      # APINotFoundError = 404
      # HTTPError = non-404 protocol-level failure
      # EveAPIExceptionXXX = EVE API failure, where XXX is the error code.
      #
      # Also: Since the EVEAPIExceptionXXX classes are generated lazily, you can't
      # actually check the exception.class against a list of classess ... because
      # there's no guarantee the class exists yet, so referencing it can generate an 
      # undefined constant error.
      if error == nil
        key.last_polled_result_code = 0 
        key.last_polled_result_message = 'SUCCESS'
      elsif PROTOCOL_FAILURE_EXCEPTIONS.include?(error.class)
        key.last_polled_result_code = 404
        key.last_polled_result_message = error.message 
      elsif PERMANENT_FAILURE_EXCEPTIONS.include?(error.class.to_s)
        key.last_polled_result_code = 666
        key.last_polled_result_message = error.message 
        key.permanent_failure = true
      elsif error.class.ancestors.include? EAAL::Exception::EveAPIException 
        key.last_polled_result_code = 667
        key.last_polled_result_message = error.message 
      else
        key.last_polled_result_code = 999 
        key.last_polled_result_message = "Unknown error: #{error.message}" 
      end
      
      key.save
    end # update

  end
end
