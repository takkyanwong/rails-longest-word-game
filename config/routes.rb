Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
  get 'reset_score', to: 'games#reset_score'
  get 'reshuffle', to: 'games#reshuffle'
  # get 'method', to: 'contrName#method_name'
end
