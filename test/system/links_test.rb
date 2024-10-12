require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit links_url

    assert_selector ".navbar-item", text: "Linkin"
    # create button is present
    assert_selector "a.button.is-success", text: "New"
  end

  test "creating new shortened link" do
    visit links_url

    click_on "New"

    fill_in "Original url", with: "https://google.com"

    click_on "Shorten"

    assert_text "Shortened URL"
    assert_text "https://google.com"
  end

  test "updating shortened link" do
    visit links_url

    click_on "New"

    fill_in "Original url", with: "https://google.com"

    click_on "Shorten"

    assert_text "Shortened URL"
    assert_text "https://google.com"

    click_on "Edit"

    fill_in "Original url", with: "https://bing.com"

    click_on "Shorten"

    assert_text "Shortened URL"
    assert_text "https://bing.com"
  end
end
