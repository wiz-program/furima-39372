class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々]+\z/
         KATAKANA_REGEX = /\A[ｧ-ﾝﾞﾟァ-ヶー－]+\z/


         validates :password, format: { with: /\A[a-z0-9]+\z/i }
         validates :nickname, presence: true
         validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'Full-width characters.' }
         validates :first_name, presence: true,format: { with: VALID_NAME_REGEX, message: 'Full-width characters.' }
         validates :last_name_katakana, presence: true, format: { with: KATAKANA_REGEX, message: 'Full-width characters.'}
         validates :first_name_katakana, presence: true, format: { with: KATAKANA_REGEX, message: 'Full-width characters.'}
         validates :birthday, presence: true
end
