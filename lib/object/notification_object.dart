class NotificationObject {
  final String email;
  final bool trangthai;
  final String hour;
  final String minute;

  NotificationObject(this.email, this.trangthai, this.hour, this.minute);
  NotificationObject.formJson(Map<String, dynamic> json)
      : email = json['email'],
        trangthai = json['trangthai'],
        hour = json['hour'],
        minute = json['minute'];

  Map<String, Object> toJson() {
    return {
      'email': email,
      'trangthai': trangthai,
    };
  }
}
