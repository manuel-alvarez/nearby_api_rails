Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cities
  get '/cities/:id/nearby', to: 'cities#nearby', as: 'nearby'
  get '/cities/near/:latlon', to: 'cities#near', as: 'near', constraints: { latlon: /[\-0-9\.]+,[\-0-9\.]+/ }
end
