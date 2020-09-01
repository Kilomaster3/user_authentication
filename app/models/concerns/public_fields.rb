module PublicFields
  extend ActiveSupport::Concern
  included do
    def public_fields
      { id: id, email: email, name: name, surname: surname }
    end
  end
end
