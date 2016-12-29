namespace '/api' do

  # 产品列表
  get '/product' do
    query, sort, page, size = parse_query_params(params)
    products = Product.where(generate_query(query))
    json products
  end

  # 获取产品详情
  get '/product/:id' do |id|
    product = Product.find(id)
    if product.nil?
      halt 400, "不存在ID为#{id}的产品"
    end

    result = product.to_hash

    json result
  end

  # 新增产品
  post '/product' do
    fields = JSON.parse(request.body.read)
    product = Product.new
    product.update_attributes(fields)
    if product.save
      json Product.find(product.id).to_hash
    else
      product.errors.full_messages
    end
  end

  # 删除产品
  delete '/product/:id' do |id|
    product = Product.find(id)

    if product != nil
      product.delete
      json :message => "success"
    else
      halt 400, "不存在该产品"
    end
  end

  # 修改产品
  patch '/product/:id' do |id|
    product = Product.find(id)

    if product.nil?
      halt 400, "该产品不存在"
    end

    fields = JSON.parse(request.body.read)
    product.update_attributes(fields)
    product.write_date = Time.now
    if product.save
      json Product.find(product.id).to_hash
    else
      halt 400, product.errors.full_messages
    end
  end

end
