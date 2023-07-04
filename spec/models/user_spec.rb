require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'saves successfully with matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user.save).to be true
    end

    it 'fails to save when password and password_confirmation do not match' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'different_password',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'validates uniqueness of email (not case-sensitive)' do
      User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      user = User.new(
        email: 'TEST@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Jane',
        last_name: 'Smith'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'validates presence of email' do
      user = User.new(
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'validates presence of first name' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: nil,
        last_name: 'Doe'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'validates presence of last name' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: nil
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
    end

    it 'returns user when email and password match' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns nil when email and password do not match' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'ignores leading/trailing whitespaces in email' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'ignores case sensitivity in email' do
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end
  end
end