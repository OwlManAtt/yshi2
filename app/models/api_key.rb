class ApiKey < ActiveRecord::Base
  self.inheritance_column = nil # I want to use +type+ for something else.
  attr_accessible :identifier, :verification_code

  belongs_to :user
  has_many :characters

  validates_presence_of :identifier, :verification_code
  validates_inclusion_of :type, :in => ['Corporation','Account','Character'], :allow_nil => true
  validates_numericality_of :identifier

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
end
