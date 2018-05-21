class Tournament < ApplicationRecord
  has_many :games, dependent: :destroy
  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_attached_file :image, styles: { medium: "320x240#", thumb: "110x80#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
