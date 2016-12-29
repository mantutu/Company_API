namespace '/account' do

  post '/login' do
    account = params['username']
    response = HTTParty.post(SiteConfig.YunLuWang.apiUrl + '?' + request.query_string, {
      headers: {"Content-Type" => request.content_type},
      body: request.body.read
    })
    result = Hashie::Mash.new JSON.parse(response.body)
    if result.status == true
      role = result.data.userType == 2 ? '企业用户' : '个人用户'
      expire_time = Date.today.next_day(14).to_time.to_i + 3600 * 4
      payload = {account: account, role: role, exp: expire_time}
      payload[:token] = JWT.encode payload, settings.token_secret
      payload[:permission] = Role.find_by(:name => role)&.permission
      json result.merge(payload)
    else
      json result
    end
  end

end
