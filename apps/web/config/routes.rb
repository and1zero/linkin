root to: 'home#index'
# we only need the url show page because we are going
# to list all URLs in root
get '/urls/:id', to: 'url#show', as: :url
# additional routing scope for the shortened URL
# just in case if the encoded string would resolve to
# something like "urls" or any generic strings used for routing
get '/my/:encoded', to: 'url#resolve', as: :short_url
