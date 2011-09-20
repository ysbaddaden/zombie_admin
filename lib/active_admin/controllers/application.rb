module ActiveAdmin
  module Controllers
    class Application < ::ApplicationController
      respond_to :html, :xml, :json, :csv

      layout 'active_admin'
      append_view_path(File.expand_path('../../../../app/views', __FILE__))

      helper_method :current_resource?, :active_admin_resource,
        :resource_klass, :resources_name, :resource_name, :resources, :resource

      def current_resource?(resource)
        controller_path == "admin/" + resource.controller_name
      end

      def active_admin_resource
        ActiveAdmin.resources[controller_name]
      end

      def resource_klass
        active_admin_resource.klass
      end

      def resource_name
        active_admin_resource.model_name.singular
      end

      def resources_name
        active_admin_resource.model_name.plural
      end

      def resource
        instance_variable_get(:"@#{resource_name}")
      end

      def resource=(value)
        instance_variable_get(:"@#{resource_name}", value)
      end

      def resources()
        instance_variable_get(:"@#{resources_name}")
      end

      def resources=(value)
        instance_variable_get(:"@#{resources_name}", value)
      end

      def load_resources?
        !active_admin_resource.collection_actions[action_name].nil?
      end

      def load_resource?
        !active_admin_resource.member_actions[action_name].nil?
      end

      def load_resources
        resources = scoped_collection
      end

      def load_resource
        resource = scoped_collection.find(params[:id])
      end
    end
  end
end
