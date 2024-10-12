require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @link = links(:one)
  end

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
  end

  test "index" do
    get links_url
    assert_response :success
  end

  test "should create shortened link" do
    assert_difference("Link.count") do
      post links_url, params: { link: { original_url: "https://duckduckgo.com" } }
    end
    assert_redirected_to link_path(Link.last)
  end

  test "should update shortened link" do
    patch link_url(@link), params: { link: { original_url: "https://blibli.com" } }
    @link.reload
    assert_redirected_to link_path(@link)
    assert_equal "https://blibli.com", @link.original_url
  end

  test "should delete shortened link" do
    assert_difference("Link.count", -1) do
      delete link_url(@link)
    end
    assert_redirected_to links_path
  end

  test "should be able to redirect from short_url" do
    get "/my/#{@link.short_url}"
    assert_redirected_to @link.original_url
  end
end
