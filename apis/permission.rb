namespace '/api' do

  get '/permission' do
    query, sort, page, size = parse_query_params(params)
    permissions = Permission.where(generate_query(query))
    permissions = permissions.paginate(page: page, per_page: size)
    json :item => permissions.collect(&:to_hash), :total => permissions.total_entries
  end

  post '/permission' do
    payload, error = verify_jwt(request)
    fields = JSON.parse(request.body.read)
    permission = Permission.new
    permission.update_attributes(fields)
    if permission.save
      json Permission.find(permission.id).to_hash
    else
      permission.errors.full_messages
    end
  end

  delete '/permission/:id' do |id|
    permission = Permission.find(id)
    if permission.nil?
      halt 400, "不存在ID为#{id}的权限"
    else
      permission.delete
      json :message => "success"
    end
  end

end
