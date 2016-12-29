namespace '/api' do

  # 客户列表
  get '/customer' do
    query, sort, page, size = parse_query_params(params)
    customers = Customer.where(generate_query(query))
    json customers
  end

  # 新增客户
  post '/customer' do
    fields = JSON.parse(request.body.read)
    customer = Customer.new
    customer.update_attributes(fields)
    if customer.save
      json Customer.find(customer.id).to_hash
    else
      customer.errors.full_messages
    end
  end

end
