require 'test_helper'

class ReceiptsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "fatih", email:"fatihavsan@gmail.com")
    @receipt = Receipt.create(name: "tavuk", description: " bir yemektir", chef: @chef)
  end
  
  test "successfuly delete a receipt" do
    get receipt_path(@receipt)
    assert_template 'receipts/show'
    assert_select 'a[href=?]', receipt_path(@receipt), text: "Delete this receipt"
    assert_difference 'Receipt.count', -1 do
      delete receipt_path(@receipt)
    end
    assert_redirected_to receipts_path
    assert_not flash.empty?
    
  end
end