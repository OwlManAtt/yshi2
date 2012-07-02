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
  eve_id { sn }
end

Character.blueprint do
  name { "Chribba #{sn}" }
  director { false }
  deleted { false }
  eve_id { sn }
end

ApiKey.blueprint do
  identifier { sn }
  verification_code { "random gibberish" }
  access_mask { 268435455 }
  type { 'Account' }
  expires_at { Date.today + 3.months }
  last_polled_at { Time.now }
  last_polled_result_code { 200 }
  last_polled_result_message { 'OK' }
  permanent_failure { false }
  user { User.make! }
end

ApiKey.blueprint(:virgin) do
  identifier { sn }
  verification_code { "random gibberish" }
  access_mask { nil }
  type { nil }
  expires_at { nil } 
  last_polled_at { nil } 
  last_polled_result_code { nil }
  last_polled_result_message { nil }
  permanent_failure { false }
  user { User.make! }
end

Item::Type.blueprint do
  name { "Test Item" }
  description { "cool item bro" }
  radius { 1.0 }
  mass { 1.0 }
  volume { 1.0 }
  capacity { 1.0 }
  units_per_run { 300 }
  npc_price { 1000.00 }
  blueprint { false }
  group 
end

Item::Group.blueprint do
  name { "Test Group" }
  description { "cool group bro" }
  manufacturable { true } 
  recyclable { true }
  category 
end

Item::Category.blueprint do
  name { "Test Category" }
  description { "cool category bro" }
end
