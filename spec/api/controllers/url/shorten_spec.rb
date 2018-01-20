require 'spec_helper'

describe Api::Controllers::Url::Shorten do
  let(:shortener) { Linkin::Url }
  let(:action) { Api::Controllers::Url::Shorten.new }
  let(:repository) { UrlRepository.new }

  describe 'without any params' do
    it 'should throw error message' do
      status, headers, body = action.call({})

      status.must_equal 422
    end
  end

  describe 'with invalid params' do
    [nil, '', 'somesample', 123, 'not-a-url'].each do |invalid_url|
      let(:params) do
        { url: invalid_url }
      end

      it 'should throw error message' do
        status, headers, body = action.call(params)
        parsed_body = JSON.parse(body[0])

        status.must_equal 422

        # check for the error message
        parsed_body['errors']['url'].must_equal 'Not a valid URL'
      end
    end
  end

  describe 'with valid params' do
    let(:params) do
      { url: 'https://placekitten.com' }
    end

    it 'should create the shortened URL' do
      status, headers, body = action.call(params)
      parsed_body = JSON.parse(body[0])

      status.must_equal 201

      # id must be returned
      id = parsed_body['id']

      # check if the generated URL is correct
      parsed_body['long_url'].must_equal 'https://placekitten.com'
      parsed_body['short_url'].must_equal "#{ENV['BASE_URL']}/my/#{shortener.encode(id)}"
    end
  end
end
