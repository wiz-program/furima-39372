## users テーブル

| Column              | Type   | Options                  |
| ------------------  | ------ | ------------------------ |
| nickname            | string | null: false              |
| email               | string | null: false,unique: true |
| encrypted_password  | string | null: false              |
| last_name           | string | null: false              |
| first_name          | string | null: false              |
| last_name_katakana  | string | null: false              |
| first_name_katakana | string | null: false              |
| birthday            | date   | null: false              |


### Association
has_many :items
has_many :orders

## items テーブル

| Column        | Type       | Options                        |
| ------------- |----------- | ------------------------------ |
| name          | string     | null: false                    |
| price         | integer    | null: false                    |
| content       | text       | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| fee_id        | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| ship_day_id   | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |


### Association
belong_to :user
has_one :order
belongs_to_active_hash :category
belongs_to_active_hash :condition
belongs_to_active_hash :fee
belongs_to_active_hash :ship_days

## orders テーブル

| Column  | Type       | Options                         |
| ------- |----------- | ------------------------------- |
| item    | references | null: false  foreign_key: true  |
| user    | references | null: false, foreign_key: true  |


### Association
has_one :address
belongs_to :user
belongs_to :item

## addresses テーブル

| Column        | Type       | Options                        |
|-------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| street        | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |


### Association
belongs_to :order
belongs_to_active_hash :prefecture