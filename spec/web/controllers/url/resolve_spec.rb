require 'spec_helper'

describe Web::Controllers::Url::Resolve do
  let(:action) { Web::Controllers::Url::Resolve.new }
  let(:shortener) { Linkin::Url }
  let(:repository) { UrlRepository.new }
  let(:url) { repository.create(href: 'https://google.com') }

  before do
    repository.clear
  end

  describe 'with valid shortened URL' do
    let(:params) { Hash[encoded: shortener.encode(url.id)] }

    it 'redirects to original URL' do
      response = action.call(params)

      response[0].must_equal 301
      response[1]['Location'].must_equal 'https://google.com'
    end
  end

  describe 'with invalid shortened URL' do
    let(:params) { Hash[encoded: 'asd'] }

    it 'shows 404 page' do
      response = action.call(params)

      response[0].must_equal 404
    end
  end
end
