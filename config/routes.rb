Rails.application.routes.draw do

  root 'home#index'
  get 'msg',to: "home#msg"

  devise_for :users 

  resources :users do
    get 'msg',to: "home#msg"
    # collection do
    #   get 'provider_post_detail' 
    # end
  end
  
  resources :home do
    collection do
      get 'find_provider_for_city'
      get 'find_provider_by_category'
      get 'filter_for_cities'
    end
  end 

  resources :comments


  resources :categories
  
  resources :provider_details

end
