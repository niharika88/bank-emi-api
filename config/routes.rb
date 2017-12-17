Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bank do
    resources :tenure
  end
  get "emi-schemes-info", to: "emi#create_emi_schemes"
  get "emi-schemes", to: "emi#emi_schemes"
end
