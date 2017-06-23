class AddChefIdToReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :chef_id, :integer
  end
end
