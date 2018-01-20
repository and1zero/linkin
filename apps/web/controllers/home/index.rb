module Web::Controllers::Home
  class Index
    include Web::Action

    expose :urls

    def call(params)
      @urls = UrlRepository.new.recent
    end
  end
end
