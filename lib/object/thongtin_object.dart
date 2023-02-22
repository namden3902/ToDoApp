class ThongTinObject {
  final String email;
  final String hoten;
  final String matkhau;
  ThongTinObject(this.email, this.hoten, this.matkhau);
  ThongTinObject.formJson(Map<String, dynamic> json)
      : email = json['email'],
        hoten = json['hoten'],
        matkhau = json['matkhau'];

  Map<String, Object> toJson() {
    return {'email': email, 'hoten': hoten, 'matkhau': matkhau};
  }
}
