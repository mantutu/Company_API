namespace '/api' do

  # 用户列表
  get '/user' do
    query, sort, page, size = parse_query_params(params)
    users = User.where(generate_query(query)).without(:password, :permission)
    users = users.paginate(page: page, per_page: size)
    json :item => users.collect(&:to_hash), :total => users.total_entries
  end

  get '/user/:id' do |id|
    user = User.find(id)
    if user.nil?
      halt 400, "不存在ID为#{id}的用户"
    end

    result = user.to_hash

    json result
  end

  post '/user' do
    fields = JSON.parse(request.body.read)
    user = User.new
    user.update_attributes(fields)
    user.password = Digest::MD5.hexdigest(fields['password'])
    user.create_date = Time.now
    user.write_date = Time.now
    if user.save
      json User.find(user.id).to_hash
    else
      user.errors.full_messages
    end
  end

  delete '/user/:id' do |id|
    user = User.find(id)
    if user != nil
      user.delete
      json :message => "success"
    else
      halt 400, "不存在该用户"
    end
  end

end
