# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  artwork_id :integer          not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :artwork_id, presence: true
  validates :body, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User,
    dependent: :destroy

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Artwork,
    dependent: :destroy

  # has_many :likes,
  #   as: :likeable

  has_many :likes,
    primary_key: :id,
    foreign_key: :comment_id,
    class_name: :Like
end
