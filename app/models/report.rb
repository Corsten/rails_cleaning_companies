class Report < ApplicationRecord
  include StateMashines::ReportStateMashine
  extend Enumerize

  enumerize :state, in: %i[new in_process done], default: :new

  paginates_per 15

  belongs_to :admin
  has_one_attached :file, dependent: :destroy
  validates :state, :file_type, presence: true
end
