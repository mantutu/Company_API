class Role

  Name = "角色"
  include Mongoid::Document

  field :ordinal, type: Integer, label: "编号"
  field :name, type: String, label: "角色名称"
  field :permission, type: Array, label: '权限', default: []

  belongs_to :user

  validates :name, presence: true, uniqueness: true

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
    if self.permission.size.to_s != 0
      permissions = []
      self.permission.each{|value| permission = Permission.find(value).to_hash; permissions.push(permission["name"])}
      hash.store 'permission', permissions
    end
    hash
  end

end
