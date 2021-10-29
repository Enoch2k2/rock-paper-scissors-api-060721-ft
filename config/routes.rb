Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/get-current-user' => 'users#get_current_user'
      post '/signup' => 'users#create'
      post '/login' => 'sessions#create'
    end
  end


  mount ActionCable.server => '/cable/:user_id'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
