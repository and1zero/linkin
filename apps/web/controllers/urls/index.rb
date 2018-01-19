module Web::Controllers::Urls
  class Index
    include Web::Action
    accept :json

    expose :urls

    def call(params)
      @urls = UrlRepository.new.all
    end
  end
end
