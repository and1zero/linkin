class ClickRepository < Hanami::Repository
  def for_url(url)
    clicks.where(url_id: url.id).order { created_at.desc }
  end
end
