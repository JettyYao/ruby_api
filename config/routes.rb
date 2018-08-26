Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tags do
    resources :posts do
      resources :comments do
        resources :replies
      end
    end
  end

  resources :emails
  post '/eStatus/:id', to: 'emails#change_status'

  resources :news
  resources :abouts
end
