class Customer

  Name = "客户"
  include Mongoid::Document

  field :company_id, type: Array, label: '公司'
  field :company_name, type: String, label: '公司名称'
  field :name, type: String, label: '名称'
  field :email, type: String, label: 'Email'
  field :function, type: String, label: '工作岗位'
  field :user_image, type: BSON::Binary, label: '用户头像'
  field :province, type: String, label: '省'
  field :city, type: String, label: '城市'
  field :zip, type: String, label: '邮政编码'
  field :fax, type: String, label: '传真'
  field :comment, type: String, label: '备注'
  field :credit_limit, type: Float, label: '信用额度'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'

  validates :name, presence: true, uniqueness: true

end
