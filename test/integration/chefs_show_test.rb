require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "fatih", email: "fatihavsan@gmail.com",
                        password: "password", password_confirmation: "password")
    @receipt = Receipt.create(name: "tavuk", description: " bir yemektir", chef: @chef)
    @receipt2 = @chef.receipts.build(name: "sezar salata", description: "bir salata çeşitidir")
    @receipt2.save
  end
  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", receipt_path(@receipt), text: @receipt.name
    assert_select "a[href=?]", receipt_path(@receipt2), text: @receipt2.name
    assert_match @receipt.description, response.body
    assert_match @receipt2.description, response.body
  end

end
