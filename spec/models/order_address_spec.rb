require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '注文情報の保存' do
    before do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.create(:user)
      item = FactoryBot.build(:item, user_id: another_user.id)
      item.save
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が必須であること' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @order_address.postal_code = "１２３ー１２３４"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号数字は半角入力、「-」を含めてください")
      end
      it '都道府県が必須であること' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が必須であること' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が必須であること' do
        @order_address.house_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が必須であること' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号は、-があると登録できない' do
        @order_address.phone_number = 123-1234-1234
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は半角入力、「-」は含めないでください")
      end
      it '電話番号は、全角だと登録できない' do
        @order_address.phone_number = "１２３ー１２３４ー１２３４"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は半角入力、「-」は含めないでください")
      end
      it '電話番号は、9桁以下だと登録できない' do
        @order_address.phone_number = 12345
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は半角入力、「-」は含めないでください")
      end

      it '電話番号は、12桁以上だと登録できない' do
        @order_address.phone_number = 1111111111111
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は半角入力、「-」は含めないでください")
      end
      it 'トークンが空では登録できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("カード情報を入力してください")
      end
      it 'user_idが空では登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空では登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
