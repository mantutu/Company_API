class Department

  Name = "部门"
  include Mongoid::Document

  field :name, type: String, label: '部门名称'
  # field :child_ids, type: BSON::ObjectId, label: '子部门'
  # field :manager_id, type: BSON::ObjectId, label: '管理员'
  # field :member_ids, type: BSON::ObjectId, label: '员工'
  # field :parent_id, type: String, label: '上级部门'
  # field :total_employee, type: Integer, label: '员工总数'
  # field :jobs_ids, type: BSON::ObjectId, label: '工作'
  field :note, type: String, label: '备注'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'

  has_many :employees
  has_many :jobs

  # has_one :manager_id
  # has_many :member_ids
  # has_many :jobs_ids
  # has_many :child_ids
  # belongs_to :department

  def total_employee
    self.employees.count()
  end

  def total_job
    self.jobs.count()
  end

  # def child_departments
  #   self.departments.count()
  # end

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
    hash.store 'total_job', self.total_job
    # hash.store 'child_departments', self.child_departments
    hash
  end

end
