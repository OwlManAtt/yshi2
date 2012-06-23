require 'machinist/active_record'

User.blueprint do
  name { "user-#{sn}" }
  provider { "google" }
  uid { "user-#{sn}@gmail.com" }
  deleted { false }
end

Corporation.blueprint do
  name { "Test Corp #{sn}" }
  ticker { "TC" }
  deleted { false }
  portal_access { false }
  manager { false }
end

Character.blueprint do
  name { "Chribba #{sn}" }
  api_user_id { 123456 }
  api_character_id { 456 }
  api_key { "D82H82HAH881A" }
  director { false }
  deleted { false }
end
