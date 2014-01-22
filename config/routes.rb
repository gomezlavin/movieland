Movies::Application.routes.draw do

  root :to => 'movies#index'
  resources :movies
  post "/results", :to => "movies#results"
  post "/movies/:id", :to => "movies#update"

end
