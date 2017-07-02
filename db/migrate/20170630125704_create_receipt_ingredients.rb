class CreateReceiptIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :receipt_ingredients do |t|
      t.integer :receipt_id
      t.integer :ingredient_id
    end
  end
end
