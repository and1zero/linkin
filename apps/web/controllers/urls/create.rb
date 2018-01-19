module Web::Controllers::Urls
  class Index
    include Web::Action
    accept :json

    def call(params)
      UrlRepository.new.create(params)


    end
  end
end
