require 'spec_helper'

describe Api::Controllers::Url::Show do
  let(:action) { Api::Controllers::Url::Show.new }
  let(:click_repository) { ClickRepository.new }
  let(:repository) { UrlRepository.new }

  before do
    click_repository.clear
    repository.clear
  end

  describe 'with invalid ID' do
    let(:params) { { id: 'invalid' } }

    it 'will return 404' do
      status, headers, body = action.call(params)

      status.must_equal 404
    end
  end

  describe 'with valid ID' do
    let(:url) { repository.create(Url.new(href: 'http://placekitten.com')) }
    let(:params) { { id: url.id } }

    before do
      click_repository.create(
        Click.new(
          url_id: url.id,
          ip: 'testing',
          user_agent: 'Minitest'
        )
      )
    end

    it 'returns the URL and clicks' do
      status, headers, body = action.call(params)
      parsed_body = JSON.parse(body[0])

      status.must_equal 200
      parsed_body['long_url'].must_equal 'http://placekitten.com'
      parsed_body['clicks'][0]['ip'].must_equal 'testing'
    end
  end
end
