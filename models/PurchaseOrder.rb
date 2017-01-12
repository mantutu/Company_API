class PurchaseOrder

  Name = "采购订单"
  include Mongoid::Document

  field :partner_id, type: BSON::ObjectId, label: '客户'
  field :currency_id, type: String, label: '币种'
  field :amount_tax, type: String, label: '税金'
  field :amount_total, type: Integer, label: '总计'
  field :amount_untaxed, type: Integer, label: '未含税金额'
  field :supplier_id, type: String, label: '供应商'
  field :partner_ref, type: String, label: '供应商参考' 	# 销售订单的参照或者供应商发出的投标。当你接收产品的时候被显示在收货单上。主要用来做匹配
  field :product_id, type: String, label: '产品'
  field :is_shipped, type: Boolean, label: '已送货'
  field :state, type: Array, label: '状态'
  field :order_line, type: Array, label: '订单行'
  field :confirmation_date, type: DateTime, label: '确认日期'
  field :date_order, type: DateTime, label: '单据日期'
  field :date_planned, type: DateTime, label: '安排的日期'
  field :date_approve, type: DateTime, label: '审批日期'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'
  field :last_presence, type: DateTime, label: '最后登录时间'
  field :last_update, type: Date, label: '最后修改日'

end
