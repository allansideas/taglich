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
    collection do 
      get 'current'
    end
  end

  resources :cards do
    collection do
      get 'only_ids'
    end
    member do
      put 'update_seen'
      put 'update_score'
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
