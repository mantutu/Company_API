class Employee

  Name = "员工"
  include Mongoid::Document

  field :name, type: String, label: '名字'
  field :mobile_phone, type: String, label: '办公手机'
  field :gender, type: String, label: '性别'
  field :department_id, type: String, label: '部门'
  field :child_ids, type: Array, label: '下属'
  field :job_id, type: String, label: '工作头衔'
  field :manager_id, type: BSON::ObjectId, label: '管理员'
  field :identification_id, type: String, label: '身份证号'
  field :bank_account_id, type: String, label: '银行账户号码'
  field :create_date, type: DateTime, label: '创建时间'
  field :create_uid, type: String, label: '创建人'
  field :write_date, type: DateTime, label: '最后更新时间'
  field :write_uid, type: String, label: '最后更新人'

  has_many :employees
  belongs_to :department
  belongs_to :job

  def to_hash(include_department=false, include_job=false)
    hash = {'id' => self.id.to_s}
    for name, field in self.class.fields
      if not name.end_with?("_id")
        if self.has_attribute?(name)
          value = self[field.name]
          hash.store name, value if not value.nil?
        end
      end
    end
    if include_department
      department = Department.find(self.department_id)
      hash.store 'department', department.to_hash
    end
    if include_job
      job = Job.find(self.job_id)
      hash.store 'job', job.to_hash
    end
    hash
  end

end
