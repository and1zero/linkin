class UrlRepository < Hanami::Repository
  def with_href(href)
    urls.where(href: href)
  end

  def recent
    urls.order { created_at.desc }
  end
end
