class JwtBlacklist < ActiveRecord::Base
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'jwt_blacklists'
end
