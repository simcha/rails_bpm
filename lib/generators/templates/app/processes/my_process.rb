class MyProces < RailsBpm::Process
  name "my-process"
  definition  do
    cursor do
      concurrence :merge_type => :stack do
        bob :task => "collect_data"
        alice :task => "collect_data"
      end
      timestamp 
      editor :task => "my_task"
      publish # the document
    end
  end
  register_participant :timestamp do |workitem|
    workitem.fields['timestamp'] = Time.now
  end
end