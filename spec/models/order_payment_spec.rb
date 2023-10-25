require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user_id: user.id)
      @order_payment = FactoryBot.build(:order_payment, user_id: user.id, item_id: item.id)
      sleep 0.1
    end
    context '商品の購入ができる場合' do
      it 'すべての項目に入力があれば保存ができること' do
        expect(@order_payment).to be_valid
      end
      it '建物名以外の必須項目の入力が存在すれば登録できる' do
        @order_payment.building = ''
        expect(@order_payment).to be_valid
      end
    end
    context '商品の購入ができない場合' do
      it 'tokenが空では登録できないこと' do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Token can't be blank"
      end
      it '郵便番号が空では登録できない' do
        @order_payment.post_code = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Post code can't be blank"
      end
      it '郵便番号が「3桁-4桁」の半角文字列以外では登録できない' do
        @order_payment.post_code = '0000-000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Post code is invalid. Include hyphen(-)'
      end
      it '都道府県が---では登録できない' do
        @order_payment.prefecture_id = '1'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市町村が空では登録できない' do
        @order_payment.city = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空では登録できない' do
        @order_payment.street_address = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Street address can't be blank"
      end
      it '電話番号が空では登録できない' do
        @order_payment.phone_number = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Phone number can't be blank"
      end
      it '電話番号が10桁または11桁以外では登録できない' do
        @order_payment.phone_number = '090123456789'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号が10桁以上11桁以内でも半角数値以外では登録できない' do
        @order_payment.phone_number = '０９０１２３４５６７８'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include 'Phone number is invalid'
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "User can't be blank"
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
