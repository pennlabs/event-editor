class Event < ApplicationRecord
  before_save :pre_set_image_url, :normalize_blank_values
  after_save :set_image_url

  self.table_name = 'event'
  self.inheritance_column = 'inheritance'
  validates :image, attachment_presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :email, presence: true
  validates_email_format_of :email
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 120
  validates :start_time, presence: true
  validates :end_time, presence: true, date: { after_or_equal_to: :start_time }

  has_attached_file :image, styles: { original: '800x' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  private

  def pre_set_image_url
    self.image_url = 'unknown' unless image_url
  end

  def normalize_blank_values
    self.website = nil unless website.present?
    self.facebook = nil unless facebook.present?
  end

  def set_image_url
    if image.url.start_with?('//')
      update_column(:image_url, "https:#{image.url}")
    else
      update_column(:image_url, image.url)
    end
  end
end
