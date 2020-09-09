require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  include JsonWebToken

  describe '#index' do
    context 'when unauthenticated' do
      it 'Not authenticated user is redirected' do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#show' do
    context 'when unauthenticated' do
      it 'Check if user Login' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to login_path
        expect(flash[:notice]).to eq 'Please Login'
      end
    end
  end

  describe '#create' do

    let(:user_params) do
      { name: Faker::Name.first_name,
        surname: Faker::Name.last_name,
        password: Faker::Internet.password(min_length: 10, max_length: 16, mix_case: true),
        email: Faker::Internet.email }
    end

    it 'create user' do
      expect { post :create, params: { user: user_params } }.to change(User, :count).by(1)
    end

    describe '.authenticate' do

      context 'when valid params' do
        it 'Check user sessions by email' do
          post :create, params: { user: user_params }
          token = @request.session[:token]
          user_id = JsonWebToken.decoded_token(token)[0]['user_id']
          user =  User.find(user_id)

          expect(user.email).to eq user_params[:email]
        end

        it 'Check user sessions by name' do
          post :create, params: { user: user_params }
          token = @request.session[:token]
          user_id = JsonWebToken.decoded_token(token)[0]['user_id']
          user =  User.find(user_id)

          expect(user.name).to eq user_params[:name]
        end

        it 'Check user sessions by surname' do
          post :create, params: { user: user_params }
          token = @request.session[:token]
          user_id = JsonWebToken.decoded_token(token)[0]['user_id']
          user =  User.find(user_id)

          expect(user.surname).to eq user_params[:surname]
        end
      end
    end
  end
end