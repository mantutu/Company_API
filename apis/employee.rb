namespace '/api' do

  get '/employee' do
    query, sort, page, size = parse_query_params(params)
    employees = Employee.where(generate_query(query))
    employees = employees.paginate(page: page, per_page: size)
    json :item => employees.collect(&:to_hash), :total => employees.total_entries
  end

  get '/employee/:id' do |id|
    employee = Employee.find(id)
    if employee.nil?
      halt 400, "不存在ID为#{id}的员工"
    end

    result = employee.to_hash

    json result
  end

  post '/employee' do
    fields = JSON.parse(request.body.read)
    employee = Employee.new
    employee.update_attributes(fields)
    employee.create_date = Time.now
    employee.write_date = Time.now
    if employee.save
      json Employee.find(employee.id).to_hash
    else
      employee.errors.full_messages
    end
  end

end
