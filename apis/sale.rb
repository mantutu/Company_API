namespace '/api' do

  get '/sale' do
    query, sort, page, size = parse_query_params(params)
    sales = SaleOrder.where(generate_query(query))
    sales = sales.paginate(page: page, per_page: size)
    json :item => sales.collect(&:to_hash), :total => sales.total_entries
  end

  get '/sale/:id' do |id|
    sale = SaleOrder.find(id)
    if sale.nil?
      halt 400, "不存在ID为#{id}的用户"
    end

    result = sale.to_hash
    json result
  end

  post '/sale' do
    payload, error = verify_jwt(request)
    fields = JSON.parse(request.body.read)
    sale = SaleOrder.new
    sale.update_attributes(fields)
    sale.write_account = payload.username
    sale.create_account = payload.username
    sale.create_date = Time.now
    sale.write_date = Time.now
    if sale.save
      json SaleOrder.find(sale.id).to_hash
    else
      sale.errors.full_messages
    end
  end

  delete '/sale/:id' do |id|
    sale = SaleOrder.find(id)
    if sale.nil?
      halt 400, "不存在ID为#{id}的销售订单"
    else
      sale.delete
      json :message => "success"
    end
  end

  # 修改订单
  patch '/sale/:id' do |id|
    sale = SaleOrder.find(id)

    if sale.nil?
      halt 400, "该订单不存在"
    end

    fields = JSON.parse(request.body.read)
    sale.update_attributes(fields)
    sale.write_date = Time.now
    if sale.save
      json SaleOrder.find(sale.id).to_hash
    else
      halt 400, sale.errors.full_messages
    end
  end

end
