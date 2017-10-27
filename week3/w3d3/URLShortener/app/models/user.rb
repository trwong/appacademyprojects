class User < ApplicationRecord
  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

    has_many :visits,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :shortened_url


    validates :email, presence: true, uniqueness: true
end
