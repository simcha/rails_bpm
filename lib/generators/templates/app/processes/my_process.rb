class MyProces < RailsBpm::Process
  name "my-process"
  definition  do
    cursor do
      select_root_for_measurement
      concurrence :merge_type => :stack do
        bob :task => "collect_data"
        alice :task => "collect_data"
      end
      measurements_compare 
      john :task => "review_data", :unless => "${data_same}"
      publish :if => "'${answer}' == accept or ${data_same}"
    end
  end
  register_participant :measurements_compare do |workitem|
    room_1 = Room.new workitem.fields['stack'][0]['room']
    room_2 = Room.new workitem.fields['stack'][1]['room']
    if room_1.temperature != room_2.temperature ||
        room_1.name != room_2.name 
      workitem.fields['data_same'] = false
    else
      workitem.fields['data_same'] = true    
    end
  end
  register_participant :select_root_for_measurement do |workitem|
    workitem.fields['room'] ||= {}
    workitem.fields['room']['name'] = "Room No #{rand(10)}"
  end
end