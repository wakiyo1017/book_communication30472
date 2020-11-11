require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "コメント機能" do
    before do
      @comment = FactoryBot.create(:comment)
    end
    context "コメントが投稿できる" do
      it "コメントを入力してあればコメントが投稿できる" do
        expect(@comment).to be_valid
      end
    end
    
    context "コメントが投稿できない" do
      it "コメントが入力されていないと投稿できない" do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end
