class Spree::Partner < ActiveRecord::Base

  enum status: [:surly, :allcity, :nrth, :whisky, :issi, :problem ]

  has_attached_file :logo, styles: { thumb: '75x75>', medium: '150x150>' }

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :status, presence: true

end
