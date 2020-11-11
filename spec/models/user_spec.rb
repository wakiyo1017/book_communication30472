require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    it "ユーザーが空だと新規登録できない" do
      user = User.new(name: "", email: "tttt@gmail.com", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it "Eメールが空だと新規登録できない" do
      user = User.new(name: "abe", email: "", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "パスワードが空だと新規登録できない" do
      user = User.new(name: "abe", email: "kkkk@gmeil.com", password: "", password_confirmation: "00000000")
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
    end
    it "パスワード確認用が空だと新規登録できない" do
      user = User.new(name: "abe", email: "kkkk@gmail.com", password: "00000000", password_confirmation: "")
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
