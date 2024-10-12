require "test_helper"

class LinkTest < ActiveSupport::TestCase
  test "should validate original_url presence" do
    link = Link.new
    assert_not link.save, "Saved link without original_url"
  end

  test "should validate original_url format" do
    link = Link.new
    link.original_url = "abx"
    assert_not link.save, "Saved link without proper original_url format"
  end
end
