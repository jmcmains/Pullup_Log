class BandUsed < ActiveRecord::Base
  attr_accessible :band_id, :exercise_id
  belongs_to :band, class_name: "Band"
  belongs_to :exercise, class_name: "Exercise"
  
end
