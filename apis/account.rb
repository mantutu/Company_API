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
      json :message => "success"
    end
  end

end
