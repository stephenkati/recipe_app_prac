Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#public_recipes"
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy, :public_recipes] do
    member do
      patch :toggle_public
    end
    resources :recipe_foods, only: [:new, :create, :edit, :update,  :destroy]
  end
end
