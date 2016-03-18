class RunResult < LegResult
    field :mmile, as: :minute_mile, type:Float
    
    def calc_ave
        if event && secs
            miles = event.miles
            self.mmile=miles.nil? ? nil : (self.secs/60)/miles
        end
    end
end