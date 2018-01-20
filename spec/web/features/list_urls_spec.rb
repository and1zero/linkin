require 'features_helper'

describe 'List shortened URLs' do
  let(:click_repository) { ClickRepository.new }
  let(:repository) { UrlRepository.new }
  before do
    click_repository.clear
    repository.clear

    repository.create(href: 'https://google.com')
    repository.create(href: 'https://placekitten.com')
  end

  it 'displays each shortened URLs' do
    visit '/'

    within '.table' do
      assert page.has_content?('https://google.com')
      assert page.has_content?('https://placekitten.com')
    end
  end
end
