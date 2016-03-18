class Address


	attr_accessor :city, :state, :location

	def initialize(city=nil, state=nil, location=nil)
		city.nil? ? @city=city : @city=city
		state.nil? ? @state=state : @state=state
		location.nil? ? @loc=location : @location = Point.new(location[:coordinates][0], location[:coordinates][1])
	end

	def mongoize
		hash={}
		hash[:city]=@city if @city
		hash[:state]=@state if @state 
		hash[:loc]={:type=>"Point", :coordinates=>[@location.nil? ? "" : @location.longitude, @location.nil? ? "" : @location.latitude]}
		hash
	end

	def self.mongoize (object)
		case object
			when nil then nil
			when Hash then {:city=>object[:city], :state=>object[:state], :loc=>object[:loc].nil? ? nil : object[:loc]}
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