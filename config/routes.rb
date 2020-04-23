Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/parking", to: "parking#create"
  put "/parking/:id/out", to: "parking#out"
  put "/parking/:id/pay", to: "parking#pay"
end
