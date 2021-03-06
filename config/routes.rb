Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'shelters#index'
  root to: 'shelters#index'
  get "/shelters", to: 'shelters#index'
  get "/shelters/new", to: 'shelters#new'
  get "/shelters/:shelter_id", to: 'shelters#show'
  get "/shelters/:shelter_id/edit", to: 'shelters#edit'
  get "/shelters/:shelter_id/pets/new", to: 'pets#new'
  get "/shelters/:shelter_id/pets", to: 'shelters#pets'

  post "/shelters", to: 'shelters#create'
  patch "/shelters/:shelter_id", to: 'shelters#update'
  patch "/pets/:pet_id", to: 'pets#update'
  post "/shelters/:shelter_id/pets", to: 'pets#create'

  delete "/shelters/:shelter_id", to: 'shelters#destroy'
  delete "/pets/:pet_id", to: 'pets#destroy'

  get "/pets", to: 'pets#index'
  get "/pets/:pet_id", to: 'pets#show'
  get "/pets/:pet_id/edit", to: 'pets#edit'

  patch "/pets/:pet_id/adoptible", to: 'pets#adoptible'

  get "/shelters/reviews/:review_id/edit", to: 'reviews#edit'
  patch "/shelters/reviews/:review_id", to: 'reviews#update'
  delete "/shelters/reviews/:review_id", to: 'reviews#destroy'

  post "/pets/:pet_id/favorite", to: 'favorites#create'

  get "/favorites", to: 'favorites#index'

  get '/shelters/:shelter_id/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'

  delete "/pets/:pet_id/favorite", to: 'favorites#destroy'

  delete "/favorites/:pet_id", to: 'favorites#remove'

  delete "/favorites", to: 'favorites#remove_all'

  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'

  get '/applications/:id', to: 'applications#show'

  get '/pets/:pet_id/applications', to: 'pet_applications#index'
  patch '/pets/:pet_id/applications/approval', to: 'pet_applications#update'
  patch '/pets/:pet_id/applications/unapproval', to: 'pet_applications#unapprove'

  patch '/pets/:pet_id/applications/approve_all', to: 'pet_applications#approve_all'
end
