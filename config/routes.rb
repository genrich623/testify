Rails.application.routes.draw do
  devise_for :users, controllers: {
                     sessions: 'users/sessions',
                     registrations: 'users/registrations',
                     confirmations: 'users/confirmations',
                     passwords: 'users/passwords',
                     unlocks: 'users/unlocks',
                     omniauth_callbacks: 'users/omniauth_callbacks'
                   }
  # For redirect after sign in
  get 'case_studies' => 'backend/case_studies#index', as: :user_root

  resources :case_studies, controller: 'backend/case_studies'
  resources :templates, controller: 'backend/templates'


  get ':user_url' => 'frontend/case_studies#index', as: :public_case_studies
  get ':user_url/code' => 'frontend/case_studies#code', as: :code_case_studies
  get ':user_url/:url' => 'frontend/case_studies#show', as: :public_case_study

  root 'frontend/pages#root'
end
