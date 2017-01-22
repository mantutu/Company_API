namespace '/api' do

  get '/role' do
    query, sort, page, size = parse_query_params(params)
    roles = Role.where(generate_query(query))
    roles = roles.paginate(page: page, per_page: size)
    json :item => roles.collect(&:to_hash), :total => roles.total_entries
  end

  post '/role' do
    payload, error = verify_jwt(request)
    fields = JSON.parse(request.body.read)
    role = Role.new
    role.update_attributes(fields)
    if role.save
      json Role.find(role.id).to_hash
    else
      role.errors.full_messages
    end
  end

  delete '/role/:id' do |id|
    role = Role.find(id)
    if role.nil?
      halt 400, "不存在ID为#{id}的角色"
    else
      role.delete
      json :message => "success"
    end
  end

end
