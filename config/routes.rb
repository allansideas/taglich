Taglich::Application.routes.draw do
  root :to => 'taglich#index'

  devise_for :users

  match 'days/:year/:month/:day' => 'days#find_by_date'
  match 'fetch_german_remember' => 'remembers#fetch_german_remember'

  resources :days do
    collection do
      get 'current_week'
    end
  end

  resources :users do
    resources :metrics
    member do
      resources :card_scores do
        member do
          post 'update_score'
          post 'update_seen'
        end
      end
    end
    collection do
      resources :card_scores do
        collection do
          delete 'delete_card_scores_by_set'
        end
      end
    end
  end

  resources :card_sets

  resources :metrics do
    collection { post :sort }
  end

  resources :metric_scores do
    member { get :graph_data }
    member { get :historical_data }
  end
end
