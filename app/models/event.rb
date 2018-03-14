class Event < ApplicationRecord
  before_save :pre_set_image_url
  after_save :set_image_url

  self.table_name = 'event'
  self.inheritance_column = 'inheritance'
  validates :image, attachment_presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 120

  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  private

  def pre_set_image_url
    self.image_url = 'unknown' unless image_url
  end

  def set_image_url
    if image.url.start_with?('//')
      update_column(:image_url, "https:#{image.url}")
    else
      update_column(:image_url, image.url)
    end
  end
end
