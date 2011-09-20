RailsApp::Application.routes.draw do
  zombie_admin
  root :to => redirect("/admin")
end
