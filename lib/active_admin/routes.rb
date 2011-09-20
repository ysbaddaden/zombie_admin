module ActionDispatch # :nodoc:
  module Routing # :nodoc:
    class Mapper
      def active_admin(*args)
        ActiveAdmin.load_resources!
        
        namespace :admin do
          ActiveAdmin.resources.each_value do |r|
            resources r.model_name.plural, :only => r.actions do
              member do
                r.member_actions.each_value { |a| send(a.method, a.name) }
              end
              
              collection do
                r.collection_actions.each_value { |a| send(a.method, a.name) }
              end
            end
          end
          
          root :to => "dashboard#index"
        end
        
#        devise_for :admin_user
      end
    end
  end
end
