Taglich::Application.routes.draw do
  root :to => 'taglich#index'

  devise_for :users

  match 'fetch_german_remember' => 'remembers#fetch_german_remember'

  match '/days/:date/get_by_date' => "days#get_by_date"

  match '/days/:day_id/metric_scores/only_ids' => "metric_scores#only_ids"

  resources :days do
    resources :metric_scores
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
      get 'current'
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
