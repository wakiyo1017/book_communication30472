require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
    @comment = FactoryBot.create(:comment)
  end

  context "コメントすることができる" do
    it "ログインしている状態で自分が投稿したbookでなければコメントすることができる" do
      # book1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "user_email", with: @book1.user.email
      fill_in "user_password", with: @book1.user.password
      find("input[name='commit']").click
      # 自分以外が投稿したbookの詳細ページに行く
      visit book_path(@book2.id)
      # コメントを入力する
      fill_in "comment_text", with: @comment.text
      # 送信ボタンを押すと本の詳細ページに止まることを確認する
      find("input[name='commit']").click
      expect(current_path).to eq book_path(@book2.id)
      # 先ほど投稿したコメントが存在することを確認する
      expect(page).to have_content("#{@comment.text}")
    end
  end

  context "コメントすることができない" do
    it "ログインしていなければコメントすることができない" do
      # ログインしていない状態でトップページに行く
      visit root_path
      # 本の詳細ページに遷移する
      visit book_path(@book1.id)
      # コメント入力欄・コメント送信ボタンがないことを確認する
      expect(page).to have_no_content("コメント入力欄")
      expect(page).to have_no_content("送信")
    end
    it "自分が投稿したbookにはコメントすることができない" do
      # book1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "user_email", with: @book1.user.email
      fill_in "user_password", with: @book1.user.password
      find("input[name='commit']").click
      # 自分が投稿した本book1の詳細ページに行く
      visit book_path(@book1.id)
      # コメント入力欄・コメント送信ボタンがないことを確認する
      expect(page).to have_no_content("コメント入力欄")
      expect(page).to have_no_content("送信")
    end
  end
end
