Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :line, controller: :line, only: [] do
    collection do
      get :login
      get :callback
    end
  end
end
