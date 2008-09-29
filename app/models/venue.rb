class Venue < ActiveRecord::Base
  has_many :shows
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
	validates_inclusion_of :zipcode, :in => 00501..99999, :message => "must be 5 digits", :allow_blank => true, :allow_nil => true
	
	def city_state_zip
	  c = self.city
	  s = self.state
	  z = "#{self.zipcode}"
	  
	  csz = ""
	  csz += c unless c.blank?
	  csz += ", " + s unless s.blank?
	  csz += " " + z unless z.blank?
	  csz
	end
end
