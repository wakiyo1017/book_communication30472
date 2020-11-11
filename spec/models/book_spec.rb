require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "book情報登録機能" do
    before do
      @book = FactoryBot.create(:book)
      sleep(1)
    end
    context "book情報の新規登録ができる" do
      it "bookの情報が正しく入力されていれば新規登録ができる" do
        expect(@book).to be_valid
      end
    end
    context "book情報が登録できない" do
      it "titleが空だと登録できない" do
        @book.title = ""
        @book.valid?
        expect(@book.errors.full_messages).to include("Title can't be blank")
      end
      it "impressionが空だと登録できない" do
        @book.impression = ""
        @book.valid?
        expect(@book.errors.full_messages).to include("Impression can't be blank")
      end
      it "authorが空だと登録できない" do
        @book.author = ""
        @book.valid?
        expect(@book.errors.full_messages).to include("Author can't be blank")
      end
      it "imageが空だと登録できない" do
        @book.image = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
