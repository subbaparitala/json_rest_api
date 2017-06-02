Rails.application.routes.draw do

  root to: "users#homepage"
  resources :users do
    resources :posts
  end
  
  scope :format => true, :constraints => { :format => 'json' } do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
  end
end
