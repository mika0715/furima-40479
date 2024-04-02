# DB 設計

## users table

| Column             | Type          | Options                      |
|--------------------|---------------|------------------------------|
| nickname           | string        | null: false                  |
| email              | string        | null: false, unique: true    |
| encrypted_password | string        | null: false                  |
| last_name          | string        | null: false                  |
| first_name         | string        | null: false                  |
| last_name_kana     | string        | null: false                  |
| first_name_kana    | string        | null: false                  |
| birthday           | date          | null: false                  |

### Association 

* has_many :items
* has_many :orders


## items table

| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| product             | string     | null: false                    |
| product_description | text       | null: false                    |
| product_category    | string     | null: false                    |
| product_status      | string     | null: false                    |
| shipping_cost       | string     | null: false                    |
| shipping_region     | string     | null: false                    |
| shipping_time       | string     | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

* belongs_to :user
* belongs_to :order


## orders table

| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| user                | references | null: false, foreign_key: true |
| item                | references | null: false, foreign_key: true |

### Association

* belongs_to :user
* belongs_to :item
* belongs_to :address


## address table

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| postcode           | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| block              | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

* belongs_to :order