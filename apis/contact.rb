namespace '/api' do

  get '/contact' do
    query, sort, page, size = parse_query_params(params)
    contacts = Contact.where(generate_query(query))
    contacts = contacts.paginate(page: page, per_page: size)
    json :item => contacts.collect(&:to_hash), :total => contacts.total_entries
  end

  get '/contact/:id' do |id|
    contact = Contact.find(id)
    if contact.nil?
      halt 400, "不存在ID为#{id}的联系人"
    end

    result = contact.to_hash

    json result
  end

  post '/contact' do
    fields = JSON.parse(request.body.read)
    contact = Contact.new
    contact.update_attributes(fields)
    contact.create_date = Time.now
    contact.write_date = Time.now
    if contact.save
      json Contact.find(contact.id).to_hash
    else
      contact.errors.full_messages
    end
  end

  patch '/contact/:id' do
    contact = Contact.find(id)

    if contact.nil?
      halt 400, "找不到ID为#{id}的联系人"
    end

    fields = JSON.parse(request.body.read)
    contact.update_attributes(fields)
    contact.write_date = Time.now
    if contact.save
      json Contact.find(id).to_hash
    else
      halt 400, contact.errors.full_messages
    end
  end

  delete '/contact/:id' do |id|
    contact = Contact.find(id)

    if contact.nil?
      halt 400, "找不到ID为#{id}的联系人"
    else
      contact.delete
      json :message => "success"
    end
  end

end
