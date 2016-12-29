helpers do

  def parse_query_params(params)
    query = params.has_key?('query') ? JSON.parse(params['query']) : {}
    sort = params.has_key?('sort') ? JSON.parse(params['sort']) : {}
    page = params.has_key?('page') ? params['page'].to_i : 1
    size = params.has_key?('size') ? [params['size'].to_i, 500].min : 50
    return query, sort, page, size
  end

end
