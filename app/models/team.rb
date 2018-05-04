class Team < ApplicationRecord
  has_many :games
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_attached_file :image, styles: { medium: "240x320#", thumb: "150x150#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
