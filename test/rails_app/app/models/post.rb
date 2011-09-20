class Post < ActiveRecord::Base
  belongs_to :blog
  has_many :comments, :order => 'created_at ASC'
end
