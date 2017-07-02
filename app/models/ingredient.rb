class Ingredient < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  has_many :receipt_ingredients
  has_many :receipts, through: :receipt_ingredients
end