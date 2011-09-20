module ZombieAdmin
  module Controllers
    class Responder < ::ActionController::Responder
      def to_html
        begin
          render @controller.controller_path
        rescue ActionView::MissingTemplate => e
          render 'zombie_admin/' + @controller.action_name
        end
      end
    end
  end
end
