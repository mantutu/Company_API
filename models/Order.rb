class Order

  Name = "销售订单"
  include Mongoid::Document

  field :partner_id, type: BSON::ObjectId, label: '客户'
  field :product_id, type: BSON::ObjectId, label: '产品'
  field :confirmation_date, type: DateTime, label: '确认日期'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'
  field :last_presence, type: DateTime, label: '最后登录时间'
  field :last_update, type: Date, label: '最后修改日'

end
