class SaleOrderLine

  Name = "销售订单行"
  include Mongoid::Document

  field :price_tax, type: Float, label: '税金'
  field :price_unit, type: Float, label: '单价'
  field :price_total, type: Float, label: '总计'
  field :price_subtotal, type: Float, label: '小计'
  field :product_id, type: String, label: '产品'
  field :description, type: String, label: '说明'
  field :order_id, type: String, label: '订单关联'
  field :product_uom_qty, type: Integer, label: '数量'
  field :tax_id, type: String, label: '税金'
  field :create_date, type: DateTime, label: '创建时间'
  #field :create_uid, type: String, label: '创建人'
  field :create_account, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  #field :write_uid, type: String, label: '最后更新人'
  field :write_account, type: String, label: '最后更新人'
  field :last_update, type: Date, label: '最后修改日'

end
