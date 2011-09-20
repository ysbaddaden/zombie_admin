module ActiveAdmin
  module Controllers
    class Responder < ::ActionController::Responder
      def to_html
        begin
          render @controller.controller_path
        rescue ActionView::MissingTemplate => e
          render 'active_admin/' + @controller.action_name
        end
      end
    end
  end
end
