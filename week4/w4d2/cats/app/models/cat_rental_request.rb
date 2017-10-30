# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord

  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true,
  inclusion: { in: %w(APPROVED DENIED PENDING),
    message: "%(value) is not a valid status" }

  validate :does_not_overlap_approved_request

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat,
    dependent: :destroy


  def overlapping_requests
    conflicts = CatRentalRequest
      .where("cat_id = ?", cat_id)
      .where.not("id = ?", id)
      .where.not("end_date < ? OR start_date > ?", start_date, end_date)
    conflicts
  end

  def overlapping_approved_requests
    overlapping_requests
      .where("status = 'APPROVED'")
  end

  def does_not_overlap_approved_request
    overlapping_approved_requests.exists?
  end
end
