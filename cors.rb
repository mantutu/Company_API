# Cross-Origin Resource Sharing

before do
  origin = request.env["HTTP_ORIGIN"]
  if SiteConfig.Client.origin.include?(origin)
    headers 'Access-Control-Allow-Origin' => origin
  end
end

options /.*/ do
  headers 'Access-Control-Allow-Methods' => 'GET, HEAD, POST, PUT, PATCH, DELETE',
     'Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  status 200
end
