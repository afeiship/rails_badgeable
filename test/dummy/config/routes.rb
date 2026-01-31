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
      end
    end

    # Separate route for removing badge from post
    delete '/posts/:post_id/badges/:badge_id', to: 'posts#remove_badge'
  end
end
