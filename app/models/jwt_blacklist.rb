class JwtBlacklist < ActiveRecord::Base
  include Devise::JWT::RevocationStrategies::Blacklist

  self.table_name = 'jwt_blacklists'
end
