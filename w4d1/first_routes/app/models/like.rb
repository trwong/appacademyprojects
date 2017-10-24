class Like < ApplicationRecord
  validates :user_id, presence: true
  validates :artwork_id, uniqueness: { scope: :user_id }
  validates :comment_id, uniqueness: { scope: :user_id }


  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  # belongs_to :likeable,
  #   polymorphic: true,
  #   optional: true
  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Artwork,
    optional: true

  belongs_to :comment,
    primary_key: :id,
    foreign_key: :comment_id,
    class_name: :Comment,
    optional: true
end
