Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root  'home#index'

  get   '/oauth/authorize', to: 'oauth#authorize'
  post  '/oauth/authorize', to: 'oauth#authorize'
  post  '/oauth/clear', to: 'oauth#clear'

  get   '/auth/:provider/callback', to: 'oauth#callback'
  get   '/auth/failure', to: 'oauth#failure'

end
