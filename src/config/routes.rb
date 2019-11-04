Rails.application.routes.draw do
  # Inserts listing 'Id' into url so that each listings order has a unique URL.
  # Controller then uses this unique URL to figure out which listing is being ordered so it can find the order.

  devise_for :users
  resources :listings do
    resources :orders
  end

  root "listings#index"

  get "pages/about"
  get "pages/contact"
  get "seller", to: "listings#seller"
end
