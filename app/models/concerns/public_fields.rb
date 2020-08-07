module PublicFields
  extend ActiveSupport::Concern
  included do
    def public_fields(user)
      { id: user.id, email: user.email, name: user.name, surname: user.surname }
    end
  end
end