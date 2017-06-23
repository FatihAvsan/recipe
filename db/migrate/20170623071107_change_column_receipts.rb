class ChangeColumnReceipts < ActiveRecord::Migration[5.0]
  def change
    rename_column :receipts, :email, :description
    change_column :receipts, :description, :text
  end
end
