namespace '/account' do

  post '/login' do
    fields = JSON.parse(request.body.read)
    username = fields['username']
    password = Digest::MD5.hexdigest(fields['password'])
    user = User.find_by(username: username)
    if user.nil?
      halt 400, "不存在该用户名"
    end

    if user.password != password
      halt 400, "用户名或密码不正确"
    else
      user.last_presence = Time.now
      if user.save
        expire_time = Date.today.next_day(14).to_time.to_i + 3600 * 4
        payload = {username: username, exp: expire_time}
        payload[:token] = JWT.encode payload, settings.token_secret
        payload[:role] = Role.find(user.role_id).to_hash
        json payload
      else
        user.errors.full_messages
      end
    end
  end

end
