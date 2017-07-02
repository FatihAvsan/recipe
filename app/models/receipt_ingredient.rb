class ReceiptIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :receipt

end