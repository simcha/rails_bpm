module RailsBpm
  class Participant
    include Ruote::LocalParticipant
    def self.inherited(subclass)
      @subclassees ||= []
      @subclassees << subclass
    end 
    def self.participant_name(name) 
      @_participant_name = name
    end
    def self._participant_name
      @_participant_name
    end
    def self._register_all
      unless @subclassees.blank?
        @subclassees.each do |subclass|
          name = subclass._participant_name
          if name.blank?
            if subclass.name =~ /Participant$/
              name = subclass.name[/(.*)(Participant$)/,1].underscore
            else
              name = subclass.name.underscore
            end
          end
          RuoteKit.engine.register_participant name, subclass
        end
      end
    end
  end
end