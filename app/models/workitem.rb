
#
# Simply opening the ruote workitem class to add some things specific
# to arts (and ActiveModel).
#
class Ruote::Workitem

  #include ActiveModel::Naming
  #include ActiveModel::Validations

  def task
    params['task']
  end

  def participant_name=(name)
    @h['participant_name'] = name
  end

  def self.for_user_count(username,opts, all_users = false)
    user = User.find(username)
    opts[:count] = true
    return RuoteKit.engine.storage_participant.query(opts) if all_users and user.admin?
    
    opts[:participant_name] = username
    count = RuoteKit.engine.storage_participant.query(opts)
    return count
  end

  def self.for_user(username, opts, all_users = false)

    user = User.find(username)

    return RuoteKit.engine.storage_participant.query(opts) if all_users and user.admin?

    opts[:participant_name] = username
    #FIXME remove when fixed in ruote
    limit = opts.delete :limit
    RuoteKit.engine.storage_participant.query(opts)[0,limit]
  end

  #--
  # active model (method need to make of workitems active models)
  #++

#  def self.model_name
#
#    return @_model_name if @_model_name
#
#    mn = Object.new
#    def mn.name; 'workitem'; end
#    @_model_name = ActiveModel::Name.new(mn)
#  end
#
#  def to_model
#    self
#  end
#
#  def destroyed?
#    fields['_destroyed'] == true
#  end
#
#  def new_record?
#    @h['fei'] == {}
#  end
#
#  def persisted?
#    @h['fei'] != {}
#  end
#
#  def to_key
#    return nil unless persisted?
#    [ @h['_id'] ]
#  end

  def to_param
    fei.sid
  end
end

