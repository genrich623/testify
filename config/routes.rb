Rails.application.routes.draw do
  devise_for :users, controllers: {
                     sessions: 'users/sessions',
                     registrations: 'users/registrations',
                     confirmations: 'users/confirmations',
                     passwords: 'users/passwords',
                     unlocks: 'users/unlocks',
                     omniauth_callbacks: 'users/omniauth_callbacks'
                   }
  # Subdomains are currently not available on heroku
  #constraints(subdomain: /.+/) do
    #get '/:url', to: 'frontend/case_studies#show', by_domain: true
    #get '*path' => redirect('/')
  #end

  # For redirect after sign in
  get 'case_studies' => 'backend/case_studies#index', as: :user_root

  resources :case_studies, controller: 'backend/case_studies' do
    collection do
      post :add_image, :add_template
    end
  end
  resources :templates, controller: 'backend/templates'

  match '/render_tile/:id' => 'frontend/case_studies#tile', via: [:get, :options]
  get ':user_url' => 'frontend/case_studies#index', as: :public_case_studies
  get ':user_url/code' => 'frontend/case_studies#code', as: :code_case_studies
  get ':user_url/:url' => 'frontend/case_studies#show', as: :public_case_study

  root 'frontend/pages#root'
end
