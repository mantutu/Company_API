namespace '/api' do

  get '/department' do
    query, sort, page, size = parse_query_params(params)
    departments = Department.where(generate_query(query))
    departments = departments.paginate(page: page, per_page: size)
    json :item => departments.collect(&:to_hash), :total => departments.total_entries
  end

  get '/department/:id' do |id|
    department = Department.find(id)
    if department.nil?
      halt 400, "不存在ID为#{id}的部门"
    end

    result = department.to_hash
    employees = Employee.where(:department_id => id)
    result.store 'employees', employees.collect()

    json result
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
