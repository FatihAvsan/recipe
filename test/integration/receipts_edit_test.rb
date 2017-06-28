require 'test_helper'

class ReceiptsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "fatih", email:"fatihavsan@gmail.com")
    @receipt = Receipt.create(name: "tavuk", description: " bir yemektir", chef: @chef)
  end
  
  test "reject invalid receipt update" do
    get edit_receipt_path(@receipt)
    assert_template 'receipts/edit'
    patch receipt_path(@receipt), params: { receipt: { name: " ", description: "some description" }}
    assert_template 'receipts/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    
  end
  
  test "successfuly edit a receipt" do
    get edit_receipt_path(@receipt)
    assert_template 'receipts/edit'
    updated_name = "updated receipt name"
    updated_description = "updated receipt description"
    patch receipt_path(@receipt), params: { receipt: {name: updated_name, description: updated_description}}
    assert_redirected_to @receipt
    #follow_redirect!
    assert_not flash.empty?
    @receipt.reload
    assert_match updated_name, @receipt.name
    assert_match updated_description, @receipt.description
  end

end
