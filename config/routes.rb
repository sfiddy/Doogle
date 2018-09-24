Rails.application.routes.draw do
  root 'words#new'
  resources :words
end
