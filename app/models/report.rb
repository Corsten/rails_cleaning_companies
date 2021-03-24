class Report < ApplicationRecord
  include StateMashines::ReportStateMashine
  paginates_per 15

  belongs_to :admin
  validates :state, :file_type, presence: true
end
