namespace '/api' do

  get '/department' do
    query, sort, page, size = parse_query_params(params)
    departments = Department.where(generate_query(query))
    departments = departments.paginate(page: page, per_page: size)
    json :item => departments.collect(&:to_hash), :total => departments.total_entries
  end

  post '/department' do
    fields = JSON.parse(request.body.read)
    department = Department.new
    department.update_attributes(fields)
    department.create_date = Time.now
    department.write_date = Time.now
    if department.save
      json Department.find(department.id).to_hash
    else
      department.errors.full_messages
    end
  end

end
