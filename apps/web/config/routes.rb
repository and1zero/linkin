root to: 'home#index'
# we only need the url show page because we are going
# to list all URLs in root
get '/urls/:id', to: 'url#show', as: :url
get '/:encoded', to: 'url#resolve', as: :short_url
