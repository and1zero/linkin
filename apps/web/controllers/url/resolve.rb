module Web::Controllers::Url
  class Resolve
    include Web::Action

    attr_reader :click_repository, :url_repository

    params do
      required(:encoded).filled(:str?)
    end

    def initialize
      @click_repository = ClickRepository.new
      @url_repository = UrlRepository.new
    end

    def call(params)
      key = Linkin::Url.decode(params.get(:encoded))
      url = url_repository.find(key)

      if url
        # If URL is found, perform a redirect and record user's request info
        record_clicks(url)
        # Using Moved Permanently status
        redirect_to url.href, status: 301
      else
        self.status = 404
        self.body = "Not Found"
      end
    end

    private

    def record_clicks(url)
      # TODO we can enrich the clicks with user's geolocation
      # and call this as an indempotent background worker to avoid delay
      # when redirecting users

      # this is most likely the most important stats we can record
      # we can get user's location from IP
      ip = request.ip
      # we can extract browser and operating system from user agent
      user_agent = request.user_agent
      # we can check if the click's origin
      # maybe in the future we can skip counting any clicks from blacklisted domains
      referer = request.referer

      click = Click.new(
        url_id: url.id,
        ip: ip,
        user_agent: user_agent,
        referer: referer,
      )

      # save it to database
      click_repository.create(click)
    end
  end
end
