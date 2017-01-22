class Permission

  Name = "权限"
  include Mongoid::Document

  field :ordinal, type: Integer, label: "编号"
  field :name, type: String, label: "权限名称"

  validates :name, presence: true, uniqueness: true

end
