# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column        | Type       | Options                        |
| ------------  | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| price         | integer    | null: false                    |
| category      | integer    | null: false, foreign_key: true |
| condition     | integer    | null: false, foreign_key: true |
| shipping_cost | integer    | null: false, foreign_key: true |
| prefecture    | integer    | null: false, foreign_key: true |
| shipping_days | integer    | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :payment

## payments テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| order          | references | null: false, foreign_key: true |
| post_code      | integer    | null: false                    |
| prefectures    | integer    | null: false, foreign_key: true |
| city           | string     | null: false                    |
| street_address | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |

### Association

- belongs_to :order