module Api::Controllers::Url
  # Let's expose the statistics as an API calls so we can render something nice
  class Show
    include Api::Action

    params do
      required(:id).filled(:int?)
    end

    def initialize
      @click_repository = ClickRepository.new
      @url_repository = UrlRepository.new
    end

    def call(params)
      url = params.valid? && url_repository.find(params.get(:id))
      if url
        clicks = click_repository.for_url(url).to_a.map do |click|
          {
            timestamp: click.created_at,
            ip: click.ip,
            user_agent: click.user_agent,
            referer: click.referer,
          }
        end

        self.status = 200
        self.body = {
          id: url.id,
          long_url: url.href,
          short_url: "#{ENV['BASE_URL']}/my/#{Linkin::Url.encode(url.id)}",
          clicks: clicks,
        }.to_json
      else
        self.status = 404
        self.body = {
          errors: "Could not find the URL"
        }.to_json
      end
    end

    private

    attr_reader :click_repository, :url_repository
  end
end
