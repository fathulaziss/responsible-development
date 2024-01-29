class AccessModel {
  AccessModel({
    this.id,
    this.mModuleId,
    this.mRoleId,
    this.canCreate,
    this.canUpdate,
    this.canDelete,
    this.isActive,
  });

  factory AccessModel.fromMap(Map<String, dynamic> map) {
    return AccessModel(
      id: map['id'],
      mModuleId: map['m_module_id'],
      mRoleId: map['m_role_id'],
      canCreate: map['can_create'],
      canUpdate: map['can_update'],
      canDelete: map['can_delete'],
      isActive: map['is_active'],
    );
  }

  String? id;
  String? mModuleId;
  String? mRoleId;
  int? canCreate;
  int? canUpdate;
  int? canDelete;
  int? isActive;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'm_module_id': mModuleId,
      'm_role_id': mRoleId,
      'can_create': canCreate,
      'can_update': canUpdate,
      'can_delete': canDelete,
      'is_active': isActive,
    };
  }

  @override
  String toString() {
    return 'AccessModel(id: $id, m_module_id: $mModuleId, m_role_id: $mRoleId, can_create: $canCreate, can_update: $canUpdate, can_delete: $canDelete, is_active: $isActive)';
  }
}
