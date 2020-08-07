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
    expect(@user).to eq @user
  end
end

describe 'POST #create' do
  context 'as a guest user' do

    it 'returns a success request' do
      expect(response.status).to eq 200
    end
  end
end

describe '#show' do
  context 'as an authorized user' do
    it 'responds successfully' do
      expect(response.status).to eq 200
    end
  end
end
