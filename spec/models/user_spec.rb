require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録できるとき' do
      it "バリデーションを回避していれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "emailに@がないと登録できない" do
        @user.email = "kkkgmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it "重複したemailが存在すれば登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it "英字のみのパスワードでは登録できない登録できない" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力してください")
      end
      it "数字のみのパスワードでは登録できない" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力してください")
      end
      it "全角文字を含むパスワードでは登録できない" do
        @user.password = "aaaaa１"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力してください")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "名字が空だと登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it "名前が空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "名字は全角（漢字・ひらがな・カタカナ）でなければ登録できない" do
        @user.last_name = "kana"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角で入力してください")
      end
      it "名前は全角（漢字・ひらがな・カタカナ）でなければ登録できない" do
        @user.first_name = "kana"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角で入力してください")
      end
      it "フリガナ（名字）が空だと登録できない" do
        @user.last_name_katakana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カタカナ)を入力してください")
      end
      it "フリガナ（名前）が空だと登録できない" do
        @user.first_name_katakana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カタカナ)を入力してください")
      end
      it "名字のフリガナは全角（カタカナ）でなければ登録できない" do
        @user.last_name_katakana = "かな"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カタカナ)は全角で入力してください")
      end
      it "名前のフリガナは全角（カタカナ）でなければ登録できない" do
        @user.first_name_katakana = "かな"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カタカナ)は全角で入力してください")
      end
      it "生年月日が空だと登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
