class Address


	attr_accessor :city, :state, :location

	def initialize (city, state, location)
		@city= city.to_s
		@state= state.to_s
		@location=Point.new(location[:coordinates][0], location[:coordinates][1])
	end

	def mongoize
		return {:city=>@city, :state=>@state, :loc=>{:type=>"Point", :coordinates=>[@location.longitude, @location.latitude]}}
	end

	def self.mongoize (object)
		case object
			when nil then nil
			when Hash then {:city=>object[:city], :state=>object[:state], :loc=>object[:loc]}
			when Address then object.mongoize
		end
	end

	def self.demongoize (object)
		case object
			when nil then nil
			when Hash then Address.new(object[:city], object[:state], object[:loc])
			when Point then Address.new(object.city, object.state, object.loc)
		end
	end

	def self.evolve (object)
		self.class.mongoize(object)
	end
end