class Post < ActiveRecord::Base
  belongs_to :blog
  has_many :comments, :order => 'created_at ASC'

  scope :published,   where(:published => true)
  scope :unpublished, where(:published => false)
end
