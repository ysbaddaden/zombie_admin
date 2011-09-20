module ZombieAdmin
  module Controllers
    class Resources < Application
      before_filter :load_resources, :if => :load_resources?
      before_filter :load_resource,  :if => :load_resource?

      def index
        resources = scoped_collection
        respond_with(resources, :responder => Responder)
      end

      def show
        resource = scoped_collection.find(params[:id])
        respond_with(resource)
      end

      def new
        resource = resource_klass.new
        respond_with(resource)
      end

      def edit
        resource = scoped_collection.find(params[:id])
      end

      def create
        resource = if scoped_collection.respond_to?(:build)
          scoped_collection.build(params[resource_name])
        else
          scoped_collection.new(params[resource_name])
        end
        resource.save
        respond_with(resource)
      end

      def update
        resource = resource_klass.find(params[:id])
        resource.update_attributes(params[resource_name])
        respond_with(resource)
      end

      def destroy
        resource = resource_klass.find(params[:id])
        resource.destroy
        respond_with(resource)
      end

      def scoped_collection
        collection
      end

      def collection
        collection = resource_klass
        collection.send(zombie_admin_resource.scopes[params[:scope]].method) if params[:scope]
        collection
      end
    end
  end
end
