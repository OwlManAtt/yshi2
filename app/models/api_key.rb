class ApiKey < ActiveRecord::Base
  self.inheritance_column = nil # I want to use +type+ for something else.
  attr_accessible :identifier, :verification_code

  belongs_to :user
  has_many :characters

  validates_presence_of :identifier, :verification_code
  validates_inclusion_of :type, :in => ['Corporation','Account','Character'], :allow_nil => true
  validates_numericality_of :identifier

  after_create :poll, :if => :pollable?

  def expired?
    return false unless expires_at
    expires_at < Date.today
  end

  def pollable?
    return false if deleted?
    return false if expired?
    return false unless last_polled_result == 'OK' or !last_polled_result  
    
    true
  end

  # FIXME: ghetto as fuck
  def fetch_key_details 
    eve = EAAL::API.new(identifier, verification_code)
    eve.scope = 'account'
    
    # FIXME: Handle exceptions.
    info = eve.APIKeyInfo
    
    self.type = info.key.type
    self.access_mask = info.key.accessMask
    self.last_polled_at = Time.now
    self.last_polled_result = 'OK' 
    self.save
  end
  
  private
  def poll()
    CCP::Vital.new(self).delay.fetch_info 
  end

end
