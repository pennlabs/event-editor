class Event < ApplicationRecord
  self.table_name = 'event'
  self.inheritance_column = 'inheritance'
  validates :image_url, attachment_presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 120

  has_attached_file :image_url
  validates_attachment_content_type :image_url, content_type: /\Aimage\/.*\z/
end
