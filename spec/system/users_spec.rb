require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context "ユーザーが新規登録できる時" do
    it "正しい情報を入力するとユーザー新規登録ができて、トップページに移動する" do
      # トップページに移動する
      visit root_path
      # トップページに新規登録のボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を記入する
      fill_in "user_name", with: @user.name
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      fill_in "user_password_confirmation", with: @user.password_confirmation
      # 登録するボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find("input[name='commit']").click
      }.to change { User.count }.by(1)
      # トップページに移動したことを確認する
      expect(current_path).to eq root_path
      # 自分の部屋に行くボタンや、ログアウトのボタンが表示されていることを確認する
      expect(page).to have_content("自分の部屋に行く")
      expect(page).to have_content("ログアウト")
      # ログインボタンや新規登録ボタンがないことを確認する
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end
  context "ユーザーの新規登録ができない" do
    it "ユーザー情報が正しく入力されていないと、新規登録されず、登録ページに戻される。" do
      # トップページに移動する
      visit root_path
      # トップページに新規登録のボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "user_name", with: ""
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      fill_in "user_password_confirmation", with: ""
      # サインアップボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{
        find("input[name='commit']").click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end
