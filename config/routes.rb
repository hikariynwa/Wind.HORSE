Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get "course_layouts/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"
  get "static_pages/terms" => "static_pages#terms"
  get "static_pages/privacy" => "static_pages#privacy"

  # 風の情報を取得するルーティング
  resources :winds, only: [ :show ]

  # コースのレイアウトの情報を取得するルーティング
  get "courses/show", to: "courses#show", as: "courses_show"

  # 風のデータのルーティング
  resources :search_datas do
    collection do
      get "select"
    end
  end

  # 開発環境でのメール確認用
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
