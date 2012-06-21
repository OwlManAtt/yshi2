require 'machinist/active_record'

User.blueprint do
  name { "user-#{sn}@gmail.com" }
  deleted { false }
#  corporation
#  characters(2)
end

Corporation.blueprint do
  name { "Test Corp #{sn}" }
  ticker { "TC" }
  deleted { false }
  portal_access { false }
  manager { false }
#  users(2)
#  characters(2)
end

Character.blueprint do
  name { "Chribba #{sn}" }
  api_user_id { 123456 }
  api_character_id { 456 }
  api_key { "D82H82HAH881A" }
  director { false }
  deleted { false }
#  corporation
#  user
end
