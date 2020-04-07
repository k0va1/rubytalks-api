# frozen_string_literal: true

Hanami.application.routes do
  cors_handler = lambda { |_env|
    [
      204,
      { 'Access-Control-Allow-Origin' => ENV.fetch('ALLOW_ORIGIN'),
        'Access-Control-Allow-Methods' => %w[GET POST PUT PATCH OPTIONS DELETE].join(','),
        'Access-Control-Allow-Headers' => %w[Content-Type Accept Auth-Token].join(',') },
      []
    ]
  }
  options '*match', to: cors_handler

  mount :admin_api, at: '/admin' do
    resources :talks, only: %i[show update] do
      collection do
        get :unpublished
      end

      member do
        post :approve
        post :decline
      end
    end

    resources :speakers, only: [:update]
    resources :events, only: [:update]
    resources :tags, only: [:create]

    post '/login', to: 'sessions#create'
  end

  mount :user_api, at: '/' do
    resources :talks, only: %i[show create index] # only symbols allowed; no error with strings
    resources :speakers, only: %i[show index]
    resources :events, only: %i[show index]
  end
end
