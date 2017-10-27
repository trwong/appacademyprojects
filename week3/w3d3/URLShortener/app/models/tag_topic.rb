class TagTopic < ApplicationRecord

  has_many :taggings,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :Tagging

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url


end
