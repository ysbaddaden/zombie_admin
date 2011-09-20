module ZombieAdmin
  module Controllers
    class Resources < Application
      before_filter :set_default_scope, :only => :index
      before_filter :load_resources, :if => :load_resources?
      before_filter :load_resource,  :if => :load_resource?

      def index
        self.resources = scoped_collection
        respond_with(resources, :responder => Responder)
      end

      def show
        self.resource = scoped_collection.find(params[:id])
        respond_with(resource, :responder => Responder)
      end

      def new
        self.resource = resource_klass.new
        respond_with(resource, :responder => Responder)
      end

      def edit
        self.resource = scoped_collection.find(params[:id])
        respond_with(resource, :responder => Responder)
      end

      def create
        self.resource = if scoped_collection.respond_to?(:build)
          scoped_collection.build(params[resource_name])
        else
          scoped_collection.new(params[resource_name])
        end
        resource.save
        respond_with(resource)
      end

      def update
        self.resource = resource_klass.find(params[:id])
        resource.update_attributes(params[resource_name])
        respond_with(resource)
      end

      def destroy
        self.resource = resource_klass.find(params[:id])
        resource.destroy
        respond_with(resource)
      end

      def scoped_collection
        collection
      end

      def collection
        _collection = resource_klass
        
        if params[:scope]
          scope = zombie_admin_resource.scopes.find(params[:scope])
          unless scope.nil? || scope.name == 'all'
            _collection = _collection.send(scope.method)
          end
        end
        
        _collection
      end

      def set_default_scope
        if zombie_admin_resource.scopes.default_scope
          params[:scope] ||= zombie_admin_resource.default_scope.name
        elsif zombie_admin_resource.scopes.any?
          params[:scope] ||= zombie_admin_resource.scopes.first.name
        end
      end
    end
  end
end
