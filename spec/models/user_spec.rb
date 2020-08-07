require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.create(:user) }

  describe User do
    context 'when valid email' do
      let(:user) { FactoryBot.build(:user, email: 'test@example.com') }

      it 'build user with valid email address' do
        expect(user).to be_valid
      end

      context 'when email upto case' do
        let(:user) { FactoryBot.create(:user, email: 'TEST@EXAMPLE.ORG') }

        it 'create user with up o case email' do
          expect(user).to be_valid
        end

        context 'when valid address' do
          let(:user) { FactoryBot.create(:user, email: 'first.last@foo.jp') }

          it 'accept valid email addresses' do
            expect(user).to be_valid
          end
        end
      end
    end

    context 'when valid params' do
      let(:user) { FactoryBot.create(:user) }

      it 'correct email and password' do
        expect(user).to be_valid
      end

      it 'accept long password' do
        long = 'Aa1' * 10
        expect(FactoryBot.build(:user, password: long, password_confirmation: long)).to be_valid
      end
    end

    context 'when invalid params' do
      it 'require a matching password confirmation' do
        expect(FactoryBot.build(:user, password_confirmation: 'invalid')).not_to be_valid
      end
    end

    it 'reject short passwords' do
      short = 'a' * 5
      expect(FactoryBot.build(:user, password: short, password_confirmation: short)).not_to be_valid
    end
  end
end