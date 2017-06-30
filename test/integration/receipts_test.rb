require 'test_helper'

class ReceiptsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "fatih", email: "fatihavsan@gmail.com",
                        password: "password", password_confirmation: "password")
    @receipt = Receipt.create(name: "tavuk", description: " bir yemektir", chef: @chef)
    @receipt2 = @chef.receipts.build(name: "sezar salata", description: "bir salata çeşitidir")
    @receipt2.save
  end

  test "should get receipts index" do
    get receipts_path
    assert_response :success
  end
  
  test "should get receipts listing" do
    get receipts_path
    assert_template 'receipts/index'
    assert_select "a[href=?]", receipt_path(@receipt), text: @receipt.name
    assert_select "a[href=?]", receipt_path(@receipt2), text: @receipt2.name

  end
  
  test "should get receipts show" do
    sign_in_as(@chef, "password")
    get receipt_path(@receipt)
    assert_template 'receipts/show'
    #assert_match @receipt.name, response.body
    assert_match @receipt.description, response.body
    assert_match @chef.chefname, response.body
    assert_select 'a[href=?]', edit_receipt_path(@receipt), text: "Edit this receipt"
    assert_select 'a[href=?]', receipt_path(@receipt), text: "Delete this receipt"
    assert_select 'a[href=?]', receipts_path, text: "Return to receipts listing"
  end
  
  test "create new valid receipt" do
    sign_in_as(@chef, "password")
    get new_receipt_path
    assert_template 'receipts/new'
    name_of_receipt = "tavuk ızgara"
    description_of_receipt = "add chicken, add sebze,10 dk pişir"
    assert_difference 'Receipt.count', 1 do
      post receipts_path, params: { receipt: { name: name_of_receipt, description: description_of_receipt } }
    end
    follow_redirect!
    assert_match name_of_receipt.capitalize, response.body
    assert_match description_of_receipt, response.body
  end
  
  test "reject invalid receipt submission" do
    sign_in_as(@chef, "password")
    get new_receipt_path
    assert_template 'receipts/new'
    assert_no_difference 'Receipt.count' do
      post receipts_path, params: { receipt: { name: " ", description: " "} }
    end
    assert_template 'receipts/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  

end
