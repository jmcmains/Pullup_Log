class Band < ActiveRecord::Base
  attr_accessible :name
  has_many :bands_used, class_name: "BandUsed", foreign_key: "band_id", dependent: :destroy
  has_many :exercises, through: :bands_used
end
