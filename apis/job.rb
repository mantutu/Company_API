namespace '/api' do

  get '/job' do
    query, sort, page, size = parse_query_params(params)
    jobs = Job.where(generate_query(query))
    jobs = jobs.paginate(page: page, per_page: size)
    json :item => jobs.collect(&:to_hash), :total => jobs.total_entries
  end

  get '/job/:id' do |id|
    job = Job.find(id)
    if job.nil?
      halt 400, "不存在ID为#{id}的部门"
    end

    result = job.to_hash
    employees = Employee.where(:job_id => id)
    result.store 'employees', employees.collect()

    json result
  end

  post '/job' do
    fields = JSON.parse(request.body.read)
    job = Job.new
    job.update_attributes(fields)
    job.create_date = Time.now
    job.write_date = Time.now
    if job.save
      json Job.find(job.id).to_hash
    else
      job.errors.full_messages
    end
  end

end
