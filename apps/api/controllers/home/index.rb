module Api::Controllers::Home
  # Currently this class is doing nothing other than being the root URL
  # of API, but we can always repurpose this to be the healthcheck of our app
  class Index
    include Api::Action

    def call(params)
      # no content, just to indicate that the API is alive
      self.status = 204
    end
  end
end
