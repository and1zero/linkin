require 'features_helper'

describe 'List shortened URLs' do
  let(:base_url) { ENV['BASE_URL'] }
  let(:shortener) { Linkin::Url }
  let(:click_repository) { ClickRepository.new }
  let(:repository) { UrlRepository.new }
  let(:url1) { repository.create(href: 'https://google.com') }
  let(:url2) { repository.create(href: 'https://placekitten.com') }

  before do
    click_repository.clear
    repository.clear

    url1
    url2
  end

  it 'displays each shortened URLs' do
    visit '/'

    within '.urls-wrapper' do
      assert page.has_content?('https://google.com')
      assert page.has_content?("#{base_url}/my/#{shortener.encode(url1.id)}")
      assert page.has_content?('https://placekitten.com')
      assert page.has_content?("#{base_url}/my/#{shortener.encode(url2.id)}")
    end
  end
end
