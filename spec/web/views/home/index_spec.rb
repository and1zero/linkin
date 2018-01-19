require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[urls: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #urls' do
    view.urls.must_equal exposures.fetch(:urls)
  end

  describe 'when there is no urls' do
    it 'shows a placeholder message' do
      rendered.must_include("There are no shorten URLs yet.")
    end
  end

  describe 'when there are urls' do
    let(:url1) { Url.new(href: 'https://google.com') }
    let(:url2) { Url.new(href: 'https://placekitten.com') }

    let(:exposures) { Hash[urls: [:url1, :url2]] }

    it 'lists the URLs' do
      rendered.must_include('https://google.com')
      rendered.must_include('https://placekitten.com')
    end

    it 'hides the placeholder message' do
      rendered.wont_include("There are no shorten URLs yet.")
    end
  end
end
