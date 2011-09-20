RailsApp::Application.routes.draw do
  active_admin
  root :to => redirect("/admin")
end
