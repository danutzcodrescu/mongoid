class Point

	

	attr_accessor :longitude, :latitude

	def initialize(longitude, latitude)
		@longitude=longitude
		@latitude=latitude
	end

	def mongoize
		return {:type=>"Point", :coordinates=>[@longitude, @latitude]}
	end

	def self.mongoize (object)
		case object
			when nil then nil
			when Hash then {:type=>"Point", :coordinates=>[object[:coordinates][0], object[:coordinates][1]]}
			when Point then {:type=>"Point", :coordinates=>[object.longitude, object.latitude]}
		end
	end

	def self.demongoize (object)
		case object
			when nil then nil
			when Hash then Point.new(object[:coordinates][0], object[:coordinates][1])
			when Point then Point.new(object.longitude, object.latitude)
		end
	end

	def self.evolve (object)
		self.class.mongoize(object)
	end
end