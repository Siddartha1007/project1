class StuClass {
  int? id;
  String name;
  String clgname;
  String branch;
  String year;
  
  StuClass({ 
    this.id, 
    required this.name, 
    required this.clgname, 
    required this.branch, 
    required this.year}
  );
 
  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'name': name, 
      'clgname': clgname, 
      'branch': branch, 
      'year': year
    };
  }
}