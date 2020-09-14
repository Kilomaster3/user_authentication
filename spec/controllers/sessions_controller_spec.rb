require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe SessionsController, type: :controller do
  let(:password) { Faker::Internet.password(min_length: 10, max_length: 16, mix_case: true) }
  let(:user) { FactoryBot.create(:user, password: password) }
  include JsonWebToken

  describe '#new' do
    it 'response success' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    before { post :create, params: params }

    let(:params) do
      { session: { password: password, email: email } }
    end

    context 'when valid params' do
      let(:email) { user.email }
      let(:user_password) { password }

      it 'login user' do
        token = @request.session[:token]
        user_id = JsonWebToken.decoded_token(token)[0]['user_id']
        decoded_user = User.find(user_id)

        expect(@request.session['token']).to be_present
        expect(decoded_user).to eq user
      end
    end
  end

  describe '#destroy' do
    context 'when valid params' do
      it 'logout user' do
        login_user(user)

        delete :destroy, params: { user_id: user.id }
        expect(@request.session['token']).not_to be_present
      end
    end
  end
end