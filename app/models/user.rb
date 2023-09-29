class User < ApplicationRecord

  has_many :items
  has_many :orders
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
         VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
         KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/


         validates :password, format: { with: VALID_PASSWORD_REGEX, message: "は半角英数字で入力してください"}
         
         validates :nickname, presence: true
         validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
         validates :first_name, presence: true,format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
         validates :last_name_katakana, presence: true, format: { with: KATAKANA_REGEX, message: 'は全角で入力してください'}
         validates :first_name_katakana, presence: true, format: { with: KATAKANA_REGEX, message: 'は全角で入力してください'}
         validates :birthday, presence: true
end
