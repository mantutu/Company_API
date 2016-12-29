class Product

  Name = "产品"
  include Mongoid::Document

  field :sequence, type: Integer, label: '序号'
  field :name, type: String, label: '产品名'
  field :price, type: Integer, label: '标价'
  field :cost, type: Integer, label: '成本'
  field :product_type, type: String, label: '产品类型'
  field :seller_ids, type: Array, label: '供应商'
  field :description, type: String, label: '说明'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'
  field :status, type: String, label: '状态'

  validates :name, presence: true, uniqueness: true

end
