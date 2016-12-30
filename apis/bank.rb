namespace '/api' do

  # 银行列表
  get '/bank' do
    query, sort, page, size = parse_query_params(params)
    banks = Bank.where(generate_query(query))
    json banks
  end

  # 获取银行详情
  get '/bank/:id' do |id|
    bank = Bank.find(id)
    if bank.nil?
      halt 400, "不存在ID为#{id}的银行"
    end

    result = bank.to_hash

    json result
  end

  # 新增银行
  post '/bank' do
    fields = JSON.parse(request.body.read)
    bank = Bank.new
    bank.update_attributes(fields)
    bank.create_date = Time.now
    if bank.save
      json Bank.find(bank.id).to_hash
    else
      bank.errors.full_messages
    end
  end

  delete '/bank/:id' do |id|
    bank = Bank.find(id)
    if bank != nil
      bank.delete
      json :message => "success"
    else
      halt 400, "不存在ID为#{id}的银行"
    end
  end

  patch '/bank/:id' do |id|
    bank = Bank.find(id)

    if bank.nil?
      halt 400, "不存在ID为#{id}的银行"
    end

    fields = JSON.parse(request.body.read)
    bank.update_attributes(fields)
    bank.write_date = Time.now
    if bank.save
      json Bank.find(bank.id).to_hash
    else
      halt 400, bank.errors.full_messages
    end
  end

end
