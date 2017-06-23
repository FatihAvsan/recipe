require 'test_helper'

class ReceiptsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "fatih", email:"fatihavsan@gmail.com")
    @receipt = Receipt.create(name: "tavuk şiş", description: "süper bir yemektir", chef: @chef)
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
    assert_match @receipt.name, response.body
    assert_match @receipt2.name, response.body
    
  end

end
