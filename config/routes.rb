Rails.application.routes.draw do
  resources :tags, except: %i[show index destroy] do
  end

  get 'stats' => 'tags#stats_for_all'
  get 'tags/:entity_type' => 'tags#index' ## route to return multiple tags and specific entity tag
  delete 'tags/:entity_type/:entity_identifier' => 'tags#destroy'
  get 'tags/:entity_type/:entity_identifier' => 'tags#show' ## route to return specific entity
  get 'stats/:entity_type' => 'tags#stats_for_entity_type'
end
