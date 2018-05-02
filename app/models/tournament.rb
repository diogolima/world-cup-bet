class Tournament < ApplicationRecord
  validates :name, :description, presence: true
  has_attached_file :image, styles: { medium: "240x320#", thumb: "150x150#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
