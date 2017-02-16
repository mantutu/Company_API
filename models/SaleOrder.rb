class SaleOrder

  Name = "销售订单"
  include Mongoid::Document

  field :partner_id, type: String, label: '客户'
  field :product_id, type: String, label: '产品'
  field :currency_id, type: String, label: '币种'
  field :amount_tax, type: String, label: '税金'
  field :amount_total, type: Float, label: '总计', default: 0
  field :saler_id, type: String, label: "销售员"
  field :state, type: String, label: '状态'
  field :payment_term, type: String, label: '付款条款'
  field :date_order, type: DateTime, label: '订购日期'
  field :confirmation_date, type: DateTime, label: '确认日期'
  field :validity_date, type: DateTime, label: '到期日期'
  field :create_date, type: DateTime, label: '创建时间'
  #field :create_uid, type: String, label: '创建人'
  field :create_account, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  #field :write_uid, type: String, label: '最后更新人'
  field :write_account, type: String, label: '最后更新人'
  field :last_update, type: Date, label: '最后修改日'

  def to_hash
    hash = {'id' => self.id.to_s}
    for name, field in self.class.fields
      if not name.end_with?("_id")
        if self.has_attribute?(name)
          value = self[field.name]
          hash.store name, value if not value.nil?
        end
      end
    end
    if self.partner_id != nil
      customer = Contact.find(partner_id).to_hash
      hash.store 'customer', customer
    end
    if self.saler_id != nil
      saler = User.find(saler_id).to_hash
      hash.store 'saler', saler
    end
    hash
  end

end
