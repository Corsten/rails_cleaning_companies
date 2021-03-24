class Report < ApplicationRecord
  include StateMashines::ReportStateMashine
  extend Enumerize
  paginates_per 15

  belongs_to :admin
  validates :state, :file_type, presence: true
  enumerize :state, in: %i[new in_process done], default: :new
end
