# frozen_string_literal: true

Hanami.application.routes do
  mount :admin_api, at: '/admin' do
    resources :talks, only: [:update] do
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
  end

  mount :user_api, at: '/' do
    resources :talks, only: %i[show create index] # only symbols allowed; no error with strings
    resources :speakers, only: %i[show index]
    resources :events, only: %i[show index]
  end
end
