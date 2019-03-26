Rails.application.routes.draw do
  if Rails.env.development? # can't use TestTrack.enabled? here because then the Remote:: models don't make API calls.
    namespace :tt do
      namespace :api do
        namespace :v1 do
          resource :split_registry, only: :show

          resource :assignment, only: :create

          resource :assignment_event, only: :create

          resource :assignment_override, only: :create

          resource :identifier, only: :create

          resources :visitors, only: :show

          resource :split_detail, only: :show

          resources :identifier_types, only: [], param: :name do
            resources :identifiers, only: [], param: :value do
              resource :visitor, only: :show, controller: 'identifier_visitors'
              resource :visitor_details, only: :show
            end
          end

          resources :split_configs, only: [:create, :destroy]
          resource :identifier_type, only: :create
        end
      end
    end
  end
end
