if Clearance.configuration.routes_enabled?
  Rails.application.routes.draw do
    resources :password_resets,
      controller: 'clearance/password_resets',
      only: [:create, :new]

    resource :session,
      controller: 'clearance/sessions',
      only: [:create]

    resources :users,
      controller: 'clearance/users',
      only: Clearance.configuration.user_actions do
        resource :password_reset,
          controller: 'clearance/password_resets',
          only: [:create, :edit, :update]
      end

    get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
    delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'

    if Clearance.configuration.allow_sign_up?
      get '/sign_up' => 'clearance/users#new', as: 'sign_up'
    end
  end
end
