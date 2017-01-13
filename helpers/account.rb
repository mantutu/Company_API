helpers do

  def granted(role, ability)
    if role == "系统管理员"
      return true
    else
      role = Role.find_by(:name => role)
      return role && role.permission.include?(ability.to_s)
    end
  end

  def verify_jwt(request)
    begin
      auth_header = request.env['HTTP_AUTHORIZATION']
      if not auth_header.nil? and auth_header.start_with?('Bearer ')
        token = auth_header.split(' ')[1]
        payload, _ = JWT.decode(token, settings.token_secret)
        return Hashie::Mash.new(payload), nil
      else
        return nil, 'No Authorization Header'
      end
    rescue JWT::DecodeError => error
      return nil, error.message
    end
  end

end
