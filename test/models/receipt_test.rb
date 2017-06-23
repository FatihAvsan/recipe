require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase

  def setup
    @receipt = Receipt.new(name: "vegetable", description: "great vegetable recipe")
  end
  
  test "recipe should be valid" do
    assert @receipt.valid?
  end
  
  test "name should be present" do
    @receipt.name = " "
    assert_not @receipt.valid?
  end
  
  test "description should be present" do
    @receipt.description = " "
    assert_not @receipt.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @receipt.description = "a" * 3
    assert_not @receipt.valid?
  end
  
  test "description shouldn't be more than 500 characters" do
    @receipt.description = "a" * 501
    assert_not @receipt.valid?
  end
  
end