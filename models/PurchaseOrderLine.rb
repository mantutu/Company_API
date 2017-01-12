class PurchaseOrderLine

  Name = "采购订单行"
  include Mongoid::Document

  field :currency_id, type: String, label: '币种'
  field :amount_tax, type: String, label: '税金'
  field :amount_total, type: Integer, label: '总计'
  field :date_order, type: DateTime, label: '单据日期'
  field :name, type: String, label: '说明'
  field :price_unit, type: Integer, label: '单价'
  field :price_total, type: Integer, label: '总价'
  field :price_tax, type: Integer, label: '税金'
  field :price_subtotal, type: Integer, label: '小计'

end
