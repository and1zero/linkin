root to: 'home#index'
# we only need the url show page because we are going
# to list all URLs in root
get '/url/:id', to: 'url#show', as: :url
get '/:hash', to: 'url#resolve'
