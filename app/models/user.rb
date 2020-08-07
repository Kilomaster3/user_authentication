class User < ApplicationRecord
  has_secure_password
  include UserStaff
  include PublicFields
end
