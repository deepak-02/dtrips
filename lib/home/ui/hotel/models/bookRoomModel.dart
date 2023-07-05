class BookRoomModel {
  String Title = "Mr";
  late String FirstName;
  late String MiddleName;
  late String LastName;
  late var Phoneno;
  late var Email;
  late int PaxType;
  late bool LeadPassenger;
  late int Age;
  late var PassportNo;
  late var PassportIssueDate;
  late var PassportExpDate;
  late String PAN;

  BookRoomModel(
      this.Title,
      this.FirstName,
      this.MiddleName,
      this.LastName,
      this.Phoneno,
      this.Email,
      this.PaxType,
      this.LeadPassenger,
      this.Age,
      this.PassportNo,
      this.PassportIssueDate,
      this.PassportExpDate,
      this.PAN);

  BookRoomModel.fromJson(Map<String, dynamic> json) {
    Title = json['Title'];
    FirstName = json['FirstName'];
    MiddleName = json['MiddleName'];
    LastName = json['LastName'];
    Phoneno = json['Phoneno'];
    Email = json['Email'];
    PaxType = json['PaxType'];
    LeadPassenger = json['LeadPassenger'];
    Age = json['Age'];
    PassportNo = json['PassportNo'];
    PassportIssueDate = json['PassportIssueDate'];
    PassportExpDate = json['PassportExpDate'];
    PAN = json['PAN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.Title;
    data['FirstName'] = this.FirstName;
    data['MiddleName'] = this.MiddleName;
    data['LastName'] = this.LastName;
    data['Phoneno'] = this.Phoneno;
    data['Email'] = this.Email;
    data['PaxType'] = this.PaxType;
    data['LeadPassenger'] = this.LeadPassenger;
    data['Age'] = this.Age;
    data['PassportNo'] = this.PassportNo;
    data['PassportIssueDate'] = this.PassportIssueDate;
    data['PassportExpDate'] = this.PassportExpDate;
    data['PAN'] = this.PAN;
    return data;
  }
}
