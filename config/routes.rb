Liskov::Application.routes.draw do
  root to: 'dashboard#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure'            => 'sessions#failure'
  match '/logout'                  => 'sessions#destroy', as: 'logout'


  resources :courses do
    resources :tasks, :discussions
    resources :students do
      resource :plan, controller: "study_plans"
    end
  end
  resources :course_memberships
end
