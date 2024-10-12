require "test_helper"

class ClickTest < ActiveSupport::TestCase
  test "should be able to save click event" do
    link = links(:one)
    click = link.clicks.new(
      ip_address: "192.168.0.1",
      user_agent: "Mozilla",
      referer: nil
    )
    assert click.save, "Unable to save click event"
  end
end
