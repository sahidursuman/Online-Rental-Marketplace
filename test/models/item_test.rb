require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @item = @user.items.build(item_name: "Hunting Rifle", lending_price: "12", category: "rifles", user_id: @user.id)
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "user id should be present" do
    @item.user_id = nil
    assert_not @item.valid?
  end

  test "item name and category should be present" do
    @item.item_name = "   "
    @item.category = "  "
    assert_not @item.valid?
  end

  test "lending price should be present and non-zero" do
  	@item.lending_price = " "
  	assert_not @item.valid?
	end

	test "lending price should be non-zero" do
		@item.lending_price = "0"
		assert_not @item.valid?
	end

	test "lending price cannot be negative" do
		@item.lending_price = "-2"
		assert_not @item.valid?
	end

  test "order should be most recent first" do
    assert_equal items(:most_recent), Item.first
  end
end
