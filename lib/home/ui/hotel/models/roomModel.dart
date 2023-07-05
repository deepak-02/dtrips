class RoomModel {
  int roomNo = 1;
  late int adultNo;
  late int childNo;
  late List<int> age;

  RoomModel(this.roomNo, this.adultNo, this.childNo, this.age);

  RoomModel.fromJson(Map<String, dynamic> json) {
    adultNo = json['NoOfAdults'];
    childNo = json['NoOfChild'];
    age = json['ChildAge'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoOfAdults'] = this.adultNo;
    data['NoOfChild'] = this.childNo;
    data['ChildAge'] = this.age;
    return data;
  }
}
