require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'user'
    it 'has 200 status code if logged in' do
      expect(response.status).to eq 200
    end
  end

  it 'find right user' do
    get :index
    expect(user).to eq user
  end

  describe 'POST #create' do
    let(:user_params) do
      { name: 'Carl',
        surname: 'Johnson',
        password: 'aF234567%',
        password_confirmation: 'aF234567%',
        email: 'cj@test.com'}
    end

    it 'returns a 200 request' do
      post :create, params: { user: user_params }
      expect(response.status).to eq 200
    end

    it 'create user' do
      expect { post :create, params: { user: user_params } }.to change(User, :count).by(1)
    end

    context 'as an authorized user' do
      it 'Adds a new User' do
        expect do
          post :create, params: {
            name: 'Alex',
            surname: 'Hrom',
            password: 'aF234277%',
            password_confirmation: 'aF234277%',
            email: 'cjshqnzq2@test.com'
          }
          expect(user).to be_valid
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not add a new TodoList' do

        expect do
          post :create, params: {
            name: 'Alex',
            surname: 'Hrom',
            password: 'aF23427%',
            password_confirmation: 'aF23427%',
            email: 'cjshqnzq2@test.com'
          }
          expect(user).not_to be_valid
        end
      end
    end

    context 'when logged_in' do
      it 'create session cookies' do
        @request.cookies[:email] = 'email'
      end

      it 'check if session existed' do
        post :create, params: { user: user_params }
        allow(user).to receive(:email).and_return user
      end
    end
  end

  describe '#show' do
  context 'as an authorized user' do

    it 'returns a 200 response' do
      get :show, params: { id: user.id }
      expect(response.status).to eq 200
    end

    it 'does not respond successfully' do
      get :show, params: { id: user.id }
      expect(response).to_not redirect_to '/users/id'
    end
  end
end

  describe 'DELETE #destroy' do
    context 'as an authorized user' do
      it 'delete an user' do

        expect do
          delete :destroy, params: { id: user.id }
          expect(user).to be_valid
        end
      end
    end
  end
end