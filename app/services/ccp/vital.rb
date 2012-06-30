module CCP
  class Vital < Base
    
    def fetch_info
      @api.scope = 'account'

      begin
        key_info = @api.APIKeyInfo.key
      rescue Exception => e
        raise e 
      ensure
        after_api_access(e) # Yes, `e' is in scope. 
      end

      begin
        save_key_info(:access_mask => key_info.accessMask, :expires_at => key_info.expires, :type => key_info.type)

        @key.characters = key_info.characters.map do |char| 
          char_attr = {:eve_id => char.characterID, :name => char.characterName}
          corp_attr = {:eve_id => char.corporationID, :name => char.corporationName}

          char = Character.find_or_create(char_attr)
          char.corporation = Corporation.find_or_create(corp_attr)

          char
        end 
      end
    end # fetch_info

    protected
    def save_key_info(info)
      @key.assign_attributes(info, :without_protection => true)
    end # save_key_info

  end # Vital
end
