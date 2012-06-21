Rails.application.config.middleware.use OmniAuth::Builder do
  YAML.load_file(Rails.root.join('config','openid_providers.yml')).each do |provider_name, options|
    provider provider_name.to_sym, options[:key], options[:secret]  
  end 
end
