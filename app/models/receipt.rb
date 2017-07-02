class Receipt < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 } 
  
  belongs_to :chef
  validates :chef_id, presence: true
  default_scope -> { order(updated_at: :desc)}
  has_many :receipt_ingredients
  has_many :ingredients, through: :receipt_ingredients
  has_many :comments, dependent: :destroy
end
