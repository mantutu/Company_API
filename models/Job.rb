class Job

  Name = "工作岗位"
  include Mongoid::Document

  field :name, type: String, label: '工作头衔'
  field :description, type: String, label: '工作说明'
  field :department_id, type: String, label: '部门'
  # field :employee_ids, type: Array, label: '员工'
  field :requirements, type: String, label: '要求'
  field :no_of_employee, type: Integer, label: '当前员工数量'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'

  has_many :employees
  belongs_to :department

  def total_employee
    self.employees.count()
  end

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
    hash.store 'total_employee', self.total_employee
    hash
  end

end
