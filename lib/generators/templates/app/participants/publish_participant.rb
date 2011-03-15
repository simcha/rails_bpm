class PublishParticipant < RailsBpm::Participant
  #participant_name "publish_test"
  
  def consume(workitem)
    #do the publish here
    stack = workitem.fields["stack"]
    rooms = stack.collect{|s|Room.new(s["room"])}
    puts "!!!!!!!!!PUBLISHED!!!!!!!!!!"
    rooms.each{|r| puts "Room #{r.name} temperature #{r.temperature}"}
    reply_to_engine(workitem)
  end
 
  def cancel(fei, flavour)
    # nothing to do
  end
 
  #def on_reply(workitem)
  #end
end