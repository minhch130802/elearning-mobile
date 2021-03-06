class RoleModel {
  RoleModel({this.roleId, this.name, this.shortName, this.sortOrder});

  int? roleId;
  String? name;
  String? shortName;
  int? sortOrder;

  RoleModel.fromJSON(Map<String, dynamic> json) {
    this.roleId = json['roleid'];
    this.name = json['name'];
    this.shortName = json['shortname'];
    this.sortOrder = json['sortorder'];
  }
}