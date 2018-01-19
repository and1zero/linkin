module Api::Operations
  class Shortening
    attr_reader :url, :repository

    def initialize(params)
      @url = params[:url]
      @repository = UrlRepository.new
    end

    def run!
      # this is our implementation of Rails' first_or_initialize
      existing_record || create_new_record
    end

    private

    def existing_record
      repository.with_href(url).first
    end

    def create_new_record
      entity = Url.new(href: url)
      repository.create(entity)
    end
  end
end
