Rails.application.routes.draw do
  namespace :api do
    resources :badges do
      member do
        get :assigned_to
      end
    end

    resources :posts do
      member do
        get :badges
        post :badges, to: 'posts#add_badge'
        delete :badges/:badge_id, to: 'posts#remove_badge'
      end
    end
  end
end
