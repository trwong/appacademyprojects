# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w(black white calico orange gray brown).freeze

  validates :color, inclusion: { in: COLORS,
    message: "%(value) is not a valid color" },
    presence: true

  validates :sex, inclusion: { in: %w(M F),
    message: "%(value) is not a valid sex" },
    presence: true

  validates :birth_date, presence: true

  validates :name, presence: true

  validates :description, presence: true

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest


  def age
    # Date.today.year - birth_date.year
    time_ago_in_words(birth_date)
  end
end
