class UserModel {
  UserModel({
    this.id,
    this.code,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mRoleId,
    this.username,
    this.address,
    this.gender,
    this.rememberToken,
    this.mCompanyId,
    this.mEmployeeHrisId,
    this.phoneNumber,
    this.lastLogin,
    this.loginStatus,
    this.lastConnected,
    this.mOccupationId,
    this.mDepartmentId,
    this.mMillId,
    this.groupName,
    this.level,
    this.employeeCode,
    this.employeeNumber,
    this.supervisorEmployeeCode,
    this.isActive,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      email: map['email'],
      emailVerifiedAt: map['email_verified_at'],
      mRoleId: map['m_role_id'],
      username: map['username'],
      address: map['address'],
      gender: map['gender'],
      rememberToken: map['remember_token'],
      mCompanyId: map['m_company_id'],
      mEmployeeHrisId: map['m_employee_hris_id'],
      phoneNumber: map['phone_number'],
      lastLogin: map['last_login'],
      loginStatus: map['login_status'],
      lastConnected: map['last_connected'],
      mOccupationId: map['m_occupation_id'],
      mDepartmentId: map['m_department_id'],
      mMillId: map['m_mill_id'],
      groupName: map['group_name'],
      level: map['level'],
      employeeCode: map['employee_code'],
      employeeNumber: map['employee_number'],
      supervisorEmployeeCode: map['supervisor_employee_code'],
      isActive: map['is_active'],
      createdAt: map['created_at'],
      createdBy: map['created_by'],
      updatedAt: map['updated_at'],
      updatedBy: map['updated_by'],
    );
  }

  String? id;
  String? code;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mRoleId;
  String? username;
  String? address;
  String? gender;
  String? rememberToken;
  String? mCompanyId;
  String? mEmployeeHrisId;
  String? phoneNumber;
  String? lastLogin;
  String? loginStatus;
  String? lastConnected;
  String? mOccupationId;
  String? mDepartmentId;
  String? mMillId;
  String? groupName;
  int? level;
  String? employeeCode;
  String? employeeNumber;
  String? supervisorEmployeeCode;
  int? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'm_role_id': mRoleId,
      'username': username,
      'address': address,
      'gender': gender,
      'remember_token': rememberToken,
      'm_company_id': mCompanyId,
      'm_employee_hris_id': mEmployeeHrisId,
      'phone_number': phoneNumber,
      'last_login': lastLogin,
      'login_status': loginStatus,
      'last_connected': lastConnected,
      'm_occupation_id': mOccupationId,
      'm_department_id': mDepartmentId,
      'm_mill_id': mMillId,
      'group_name': groupName,
      'level': level,
      'employee_code': employeeCode,
      'supervisor_employee_code': supervisorEmployeeCode,
      'is_active': isActive,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, code: $code, name: $name, email: $email, email_verified_at: $emailVerifiedAt, m_role_id: $mRoleId, username: $username, address: $address, gender: $gender, remember_token: $rememberToken, m_company_id: $mCompanyId, m_employee_hris_id: $mEmployeeHrisId, phone_number: $phoneNumber, last_login: $lastLogin, login_status: $loginStatus, last_connected: $lastConnected, m_occupation_id: $mOccupationId, m_department_id: $mDepartmentId, m_mill_id: $mMillId, group_name: $groupName, level: $level, employee_code: $employeeCode, employee_number: $employeeNumber, supervisor_employee_code: $supervisorEmployeeCode, is_active: $isActive, created_at: $createdAt, created_by: $createdBy, updated_at: $updatedAt, updated_by: $updatedBy)';
  }
}
