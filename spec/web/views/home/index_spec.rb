require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:url) { Url.new(href: 'https://placekitten.com') }
  let(:exposures) { Hash[urls: [url]] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #urls' do
    view.urls.must_equal exposures.fetch(:urls)
  end
end
