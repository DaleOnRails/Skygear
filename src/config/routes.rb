Rails.application.routes.draw do

  # Inserts listing 'Id' into the orders url so that each listings order has a unique URL.
  # Controller then uses this unique URL to figure out which listing is being ordered so it can find the order.
  devise_for :users
  resources :listings do
    resources :orders, only: [:new, :create]
  end

  get "pages/about"
  get "pages/contact"

  # 'Manage Listings' page. Displays all current listings the logged in user is selling.
  get "seller", to: "listings#seller"

  # Displays order history pages (the 'orders' database) for users purchased and sold items
  get "sales", to: "orders#sales"
  get "purchases", to: "orders#purchases"

  # Homepage
  root "listings#index"
end
