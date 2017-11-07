class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :post
end
