require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should create a new user" do
      user = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
      user.validate
      expect(user.errors.full_messages).to be_empty
    end
    it "should give an error when there is no first name" do
      user = User.new(last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
      user.validate
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
    it "should give an error when there is no last name" do
      user = User.new(first_name: "Artem", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
      user.validate
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
    it "should give an error when there is no email" do
      user = User.new(first_name: "Artem", last_name: "Iefymenko", password: "lhl_rails", password_confirmation: "lhl_rails")
      user.validate
      expect(user.errors.full_messages).to include("Email can't be blank")
  end
  it "should give an error when there are 2 users with the same email" do
    user = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
    user2 = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
    user.save
    user2.save
    expect(user2.errors.full_messages).to include("Email has already been taken")
  end
  it "should give an error when password is less than 6 symbols" do
    user = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl", password_confirmation: "lhl")
    user.validate
    expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end
end


  describe '.authenticate_with_credentials' do
    it "should be nil with invalid credentials" do
      user = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
      user.save
      user = User.authenticate_with_credentials("lhl_god@gmail.com", "la-la-la")
      expect(user).to be(nil)
end
it "should successfully log in if user entered whitespace before email" do
  user = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
  user.save
  user = User.authenticate_with_credentials(" lhl_god@gmail.com", "lhl_rails")
  expect(user).not_to be(nil)
end
it "should be nil with invalid credentials" do
  user = User.new(first_name: "Artem", last_name: "Iefymenko", email: "lhl_god@gmail.com", password: "lhl_rails", password_confirmation: "lhl_rails")
  user.save
  user = User.authenticate_with_credentials("lHL_goD@gmAil.com", "lhl_rails")
  expect(user).not_to be(nil)
end
end
end
