require 'rails_helper'

RSpec.describe "Books", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book)
  end
  context "読んだ本の感想が登録できる" do
    it "ログインしているユーザーは新規投稿できる" do
      # ログインする
      visit new_user_session_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      find("input[name='commit']").click
      # 自分の部屋に行くボタンがあることを確認する
      expect(current_path).to eq root_path
      expect(page).to have_content("自分の部屋に行く")
      # ユーザーページに行く
      visit user_path(@user.id)
      # 読んだ本の感想を登録するボタンがあることを確認する
      expect(page).to have_content("読んだ本を登録する")
      # 投稿ページに移動する
      visit new_book_path
      # フォームに入力する
      fill_in "book_title", with: @book.title
      attach_file "item-image", "#{Rails.root}/public/images/test_image2.png"
      fill_in "book_author", with: @book.author
      fill_in "book_impression", with: @book.impression
      # 登録ボタンを押すとbookモデルのカウントが1増えることを確認する
      expect{
        find("input[name='commit']").click
      }.to change { Book.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには投稿した本の情報が存在することを確認する（画像）
      expect(page).to have_selector('img[src$="test_image2.png"]')
      # トップページに投稿した本の情報が存在する（テキスト）
      expect(page).to have_content("#{@book.title}")
    end
  end
  context "読んだ本の感想が登録できない" do
    it "ログインしていないユーザーは登録できない" do
      # ログインしていない状態でトップページに行く
      visit root_path
      # 自分の部屋にいくボタンがないことを確認する
      expect(page).to have_no_content("自分の部屋に行く")
    end
    it "ログインしていても正確に入力しないと新規投稿できない" do
      # ログインする
      visit new_user_session_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      find("input[name='commit']").click
      # 自分の部屋にいくボタンがあることを確認する
      expect(page).to have_content("自分の部屋に行く")
      # ユーザーのページにいく
      visit user_path(@user.id)
      # 本の感想を登録するボタンがあることを確認する
      expect(page).to have_content("読んだ本を登録する")
      # 投稿ページに移動する
      visit new_book_path
      # フォームに誤った情報を入力する
      fill_in "book_title", with: ""
      fill_in "book_author", with: ""
      fill_in "book_impression", with: ""
      # 登録ボタンを押してもbookモデルのカウントが増えないことを確認する
      find("input[name='commit']").click
      # 投稿ページに戻されることを確認する
      expect(current_path).to eq books_path
    end
  end
end
