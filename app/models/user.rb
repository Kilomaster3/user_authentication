class User < ApplicationRecord
  has_secure_password
  include UserValidatable
  include PublicFields
end
