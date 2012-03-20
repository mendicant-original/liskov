Liskov::Application.routes.draw do
  root to: 'dashboard#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure'            => 'sessions#failure'
  match '/logout'                  => 'sessions#destroy', as: 'logout'


  resources :courses do
    resources :tasks, :discussions
  end
  resources :course_memberships
end