class Event < ApplicationRecord
  paginates_per 25

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

  has_attached_file :image, styles: { original: ['800x>', :jpg] }
  crop_attached_file :image, aspect: '16:9'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def prev
    Event.where(type: type).where('start_time < ?', start_time).order(:start_time).last || Event.where(type: type).order(:start_time).last
  end

  def next
    Event.where(type: type).where('start_time > ?', start_time).order(:start_time).first || Event.where(type: type).order(:start_time).first
  end

  def to_s
    "<Event: #{name}>"
  end

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
