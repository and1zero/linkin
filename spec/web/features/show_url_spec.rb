require 'features_helper'

describe 'Show a shortened URL' do
  let(:click_repository) { ClickRepository.new }
  let(:repository) { UrlRepository.new }
  let(:url) { repository.create(href: 'https://placekitten.com') }

  before do
    click_repository.clear
    repository.clear

    click_repository.create(
      url_id: url.id,
      ip: '0.0.0.0',
      user_agent: 'Minitest',
      referer: nil,
    )
  end

  it 'displays each shortened URLs' do
    visit "/urls/#{url.id}"

    within '.breadcrumb' do
      # navigation must be present
      assert page.has_content?('Home')
    end

    # ensure URL details are stored
    assert page.has_content?('https://placekitten.com')

    # ensure chart is present
    assert page.has_css?('#chart_canvas')

    # ensure timeline is present
    assert page.has_css?('.timeline')
  end
end
