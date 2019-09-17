class ObjectT {
  String uuid;
  String user;
  String cellphone;
  String image;
  String date;
  String time;
  String description;
  String contacts;

  ObjectT(
      {this.uuid,
      this.user,
      this.cellphone,
      this.image,
      this.date,
      this.time,
      this.description,
      this.contacts});

  ObjectT.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    user = json['user'];
    cellphone = json['cellphone'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    contacts = json['contacts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['user'] = this.user;
    data['cellphone'] = this.cellphone;
    data['image'] = this.image;
    data['date'] = this.date;
    data['time'] = this.time;
    data['description'] = this.description;
    data['contacts'] = this.contacts;
    return data;
  }
  
  @override
  String toString() => toJson().toString();
}