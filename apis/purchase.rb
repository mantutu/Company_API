namespace '/api' do

  get '/purchase' do
    query, sort, page, size = parse_query_params(params)
    purchases = PurchaseOrder.where(generate_query(query))
    purchases = purchases.paginate(page: page, per_page: size)
    json :item => purchases.collect(&:to_hash), :total => purchases.total_entries
  end

  get '/purchase/:id' do |id|
    purchase = PurchaseOrder.find(id)

    if purchase.nil?
      halt 400, "不存在ID为#{id}的采购订单"
    else
      result = purchase.to_hash
      json result
    end
  end

  post '/purchase' do
    payload, error = verify_jwt(request)
    fields = JSON.parse(request.body.read)
    purchase = PurchaseOrder.new
    purchase.update_attributes(fields)
    purchase.write_account = payload.username
    purchase.create_account = payload.username
    purchase.create_date = Time.now
    purchase.write_date = Time.now
    if purchase.save
      json PurchaseOrder.find(purchase.id).to_hash
    else
      purchase.errors.full_messages
    end
  end

  delete '/purchase/:id' do |id|
    purchase = PurchaseOrder.find(id)
    if purchase.nil?
      halt 400, "不存在ID为#{id}的采购订单"
    else
      purchase.delete
      json :message => "success"
    end
  end

  patch '/purchase/:id' do |id|
    purchase = PurchaseOrder.find(id)

    if purchase.nil?
      halt 400, "该订单不存在"
    end

    fields = JSON.parse(request.body.read)
    purchase.update_attributes(fields)
    purchase.write_date = Time.now
    if purchase.save
      json PurchaseOrder.find(purchase.id).to_hash
    else
      halt 400, purchase.errors.full_messages
    end
  end

end
