class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.short_url = SecureRandom.hex(3) # Generate a short URL

    if @link.save
      redirect_to @link
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @link = Link.find(params[:id])
    @clicks = @link.clicks
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

    if @link.update(link_params)
      redirect_to @link
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path, notice: "Link was successfully deleted."
  end

  def redirect
    @link = Link.find_by(short_url: params[:short_url])
    if !(@link.original_url =~ URI::DEFAULT_PARSER.make_regexp(%w[http https])).nil?
      original_url = URI.parse(@link.original_url)
    else
      original_url = nil
    end
    respond_to do |format|
      format.html do
        record_click(@link)
        redirect_to original_url, allow_other_host: true
      end
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def record_click(link)
    click = link.clicks.new(
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referer: request.referer,
      clicked_at: Time.current
    )
    click.save
  end
end
