module CCP
  class AccessObserver

    def initialize(api_consumer_class)
      @api_consumer = api_consumer_class
      @api_consumer.add_observer(self)  
    end # initialize

    def update(error=nil)
      key = @api_consumer.key

      key.last_polled_at = Time.now
      
      # TODO Imbue some intelligence into this so it knows about 
      # temp fail vs. perm fail
      if error == nil
        key.last_polled_result = 'OK'
      else
        key.last_polled_result = 'ERROR'
      end
      
      key.save
    end # update

  end
end
