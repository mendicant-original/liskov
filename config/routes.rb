Liskov::Application.routes.draw do
  match '/login' => 'sessions#new'
  match '/test'  => 'sessions#test'
end
