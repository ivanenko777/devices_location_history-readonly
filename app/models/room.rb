class Room < ApplicationRecord
  belongs_to :office

  validates :name, presence: true
  validates :office_id, presence: true
end
