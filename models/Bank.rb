class Bank

  Name = "银行"
  include Mongoid::Document

  field :name, type: String, label: '名称'
  field :bic, type: Integer, label: '银行识别代码'
  field :province, type: String, label: '省'
  field :city, type: String, label: '城市'
  field :zip, type: String, label: '邮政编码'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'

  validates :bic, presence: true, uniqueness: true

end
