require 'sourcify'
module RailsBpm
class Process
   attr_accessor :name, :revision, :definition_proc
   def id 
     @name
   end
   def definition
     "Ruote.process_definition '#{name}' #{definition_proc.to_source[4..-1].strip}"
   end
   def self.name(name) 
     @name = name
   end
   def self.revision(rev) 
     @revision = rev
   end
   def self.definition(&proc)
     @@procesess ||= []
     p = self.new
     p.name = @name
     p.definition_proc = proc
     @@procesess << p
   end
   def self.register_participant(name, &proc)
     @@participants ||=[]
     @@participants << [name, proc]
   end
   def self._register_participants
     @@participants ||= nil
     unless @@participants.blank?
       @@participants.each do |name, block|
         RuoteKit.engine.register_participant name, &block
       end
     end
   end
   def self.all
     @@procesess ||= []
     @@procesess
   end
   def self.find(id)
     @@procesess ||= []
     @@procesess.find{|p|p.id == id}
   end
end
end
