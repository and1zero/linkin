module Web::Controllers::Url
  class Show
    include Web::Action

    expose :url, :clicks, :encoded

    params do
      required(:id).filled(:int?)
    end

    def call(params)
      @url = params.valid? && url_repository.find(params.get(:id))

      if @url
        @clicks = click_repository.for_url(url)
        @encoded = Linkin::Url.encode(url.id)
      else
        self.status = 404
        self.body = "Not found"
      end
    end

    private

    def click_repository
      @click_repository ||= ClickRepository.new
    end

    def url_repository
      @url_repository ||= UrlRepository.new
    end
  end
end
