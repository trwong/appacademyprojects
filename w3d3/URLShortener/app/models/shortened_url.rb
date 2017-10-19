require 'securerandom'

class ShortenedUrl < ApplicationRecord
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  has_many :topics,
    through: :taggings,
    source: :tag_topic

  def self.random_code(user, long_url)
    new_url = SecureRandom.base64(16)
    while ShortenedUrl.exists?(short_url: new_url)
      new_url = SecureRandom.base64(16)
    end
    ShortenedUrl.create!(short_url: new_url, user_id: user.id, url: long_url)
  end

  def num_clicks
    # Visit.all.select { |m| m.url_id == self.id }.count
    visits.length
  end

  def num_uniques
    # Visit.select(:url_id).distinct.select { |m| m.url_id == self.id }.count
    visitors.length
  end


  def num_recent_uniques
    time = 10.minutes.ago
    visits.select(:user_id).where("updated_at >= ?", time).distinct.count#.select(:url_id).distinct.select { |m| m.url_id == self.id }.count

  end

  validates :url, presence: true
  validates :user_id, presence: true
end
