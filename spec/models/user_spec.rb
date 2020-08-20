require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.create(:user) }

  describe User do
    context 'email' do
      let(:email) { FactoryBot.create(:user, email: 'test@example.com') }

      it 'reject duplicate email addresses' do
        expect(email).to be_valid
      end

      context 'invalid' do
        let(:user) { User.new }

        it 'without params' do
          expect(user).to be_invalid
        end
      end
    end

    context 'up to case' do
      let(:email) { FactoryBot.create(:user, email: 'TEST@EXAMPLE.ORG') }

      it 'reject email addresses identical up to case' do
        expect(email).to be_valid
      end

      it 'accept valid email addresses' do
        addresses = %w[member@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = FactoryBot.build(:user, email: address)
          expect(valid_email_user).to be_valid
        end
      end
    end

    context 'valid' do
      it 'with email and password' do
        expect(user).to be_valid
      end
    end

    context 'invalid' do
      it 'require a matching password confirmation' do
        expect(FactoryBot.build(:user, password_confirmation: 'invalid')). not_to be_valid
      end
    end

    it 'reject short passwords' do
      short = 'a' * 5
      expect(FactoryBot.build(:user, password: short, password_confirmation: short)). not_to be_valid
    end
  end

  context 'factory' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end
end
