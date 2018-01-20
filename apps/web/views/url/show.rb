module Web::Views::Url
  class Show
    include Web::View

    def encoded_id
      Linkin::Url.encode(url.id)
    end
  end
end
