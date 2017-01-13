class User

  Name = "用户"
  include Mongoid::Document

  field :ordinal, type: Integer, label: '编号'
  field :username, type: String, label: '用户名'
  field :password, type: String, label: '密码'
  field :permission, type: Array, label: '权限', default: []
  field :realname, type: String, label: '姓名'
  field :email, type: String, label: 'Email'
  field :phone, type: Integer, label: '联系方式'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_account, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_account, type: String, label: '最后更新人'
  field :last_presence, type: DateTime, label: '最后登录时间'
  field :last_update, type: Date, label: '最后修改日'

  validates :username, presence: true, uniqueness: true

end
