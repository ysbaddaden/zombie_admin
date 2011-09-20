ZombieAdmin.register Blog do
  menu false

  actions :edit, :update

  member_action :publish, :method => :put do
    @blog.update_attribute(:published, true)
  end

  collection_action :published do
    @posts = @blog.posts.published
    respond_with(@posts)
  end
end
