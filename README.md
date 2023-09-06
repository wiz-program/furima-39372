## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |


### Association
has_many :items
has_many :orders

## items テーブル

| Column   | Type       | Options                       |
|----------|---------- |--------------------------------|
| name     | string    | null: false                    |
| category | integer   | null: false                    |
| price    | string    | null: false                    |
| content  | text      | null: false                    |
| user     | reference | null: false, foreign_key: true |


### Association
belong_to :user
has_one :order
belongs_to_active_hash :category

## orders テーブル

| Column  | Type      | Options                         |
|---------|-----------|---------------------------------|
| address | reference | null: false   foreign_key: true |
| item    | reference | null: false  foreign_key: true  |
| user    | reference | null: false, foreign_key: true  |


### Association
has_one :address
belongs_to :user
belongs_to :item

## addresses テーブル

| Column        | Type      | Options                        |
|-------------- |-----------|--------------------------------|
| postal_code   | integer   | null: false                    |
| prefecture    | integer   | null: false                    |
| house_number  | integer   | null: false                    |
| building_name | string    |                                |
| first_name    | string    | null: false                    |
| last_name     | string    | null: false                    |
| order         | reference | null: false, foreign_key: true |


### Association
belongs_to :order
belongs_to_active_hash :prefecture