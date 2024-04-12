class Address < ApplicationRecord

  validates :postcode, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :block, presence: true
  validates :phone_number, presence: true

  belongs_to :order
end