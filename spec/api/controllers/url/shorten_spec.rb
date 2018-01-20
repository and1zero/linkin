require 'spec_helper'

describe Api::Controllers::Url::Shorten do
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

        status.must_equal 422
      end
    end
  end

  describe 'with valid params' do
    let(:params) do
      { url: 'https://placekitten.com' }
    end

    it 'should create the shortened URL' do
      status, headers, body = action.call(params)

      status.must_equal 201
    end
  end
end
