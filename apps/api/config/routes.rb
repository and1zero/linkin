root to: 'home#index'

get '/urls/:id', to: 'url#show'
post '/shorten', to: 'url#shorten'
