module Api::Controllers::Url
  class Shorten
    include Api::Action

    params do
      # Hanami has an embedded params validator
      # Instead of calling all the validations on the model level,
      # we can isolate the params validations here
      required(:url).filled(:str?, format?: URI.regexp)
    end

    def initialize(repository: UrlRepository.new, url: Url.new)
      @repository = repository
      @url = url
    end

    def call(params)
      if params.valid?
        operation = Api::Operations::Shortening.new(params)
        url = operation.run!

        self.status = 201
        self.body = {
          id: url.id,
          long_url: url.href,
          short_url: "#{request.base_url}/#{Linkin::Url.encode(url.id)}"
        }.to_json
      else
        self.status = 422
        self.body = {
          errors: {
            url: "Not a valid URL"
          }
        }.to_json
      end
    end
  end
end
