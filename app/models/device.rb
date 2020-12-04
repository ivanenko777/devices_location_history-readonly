class Device < ApplicationRecord
  include UserTrackable

  enum status: {
      in_operation: 1,
      decommissioned: 2
  }

  belongs_to :device_model
  belongs_to :room

  scope :filter_by_status, ->(status_id) { where status: status_id }
  scope :filter_by_device_type, ->(device_type_id) { joins(device_model: :device_type).where("device_models.device_type_id = ?", device_type_id) }
  scope :filter_by_device_manufacturer, lambda { |device_manufacturer_id|
    joins(device_model: :device_manufacturer).where('device_models.device_manufacturer_id = ?', device_manufacturer_id)
  }
  scope :filter_by_device_model, ->(device_model_id) { where(device_model_id: device_model_id) }

  validates :device_model_id, presence: true
  validates :room_id, presence: true
  validates :serial_no, presence: true, uniqueness: {scope: :device_model_id}
end
