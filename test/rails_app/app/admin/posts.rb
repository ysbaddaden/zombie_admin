ActiveAdmin.register Post do
  scope :all
  scope :published
  scope :unpublished, :private
end
