class BlockRoomModel {
  late int ResultIndex;
  late String HotelCode;
  late String HotelName;
  late String GuestNationality;
  late String NoOfRooms;
  late double ClientReferenceNo;
  late String IsVoucherBooking;
  late String CategoryId;
  late String EndUserIp;
  late String TokenId;
  late String TraceId;
  late List HotelRoomsDetails;

  BlockRoomModel(
      this.ResultIndex,
      this.HotelCode,
      this.HotelName,
      this.GuestNationality,
      this.NoOfRooms,
      this.ClientReferenceNo,
      this.IsVoucherBooking,
      this.EndUserIp,
      this.CategoryId,
      this.TokenId,
      this.TraceId,
      this.HotelRoomsDetails);

  BlockRoomModel.fromJson(Map<String, dynamic> json) {
    ResultIndex = json['ResultIndex'];
    HotelCode = json['HotelCode'];
    HotelName = json['HotelName'];
    GuestNationality = json['GuestNationality'];
    NoOfRooms = json['NoOfRooms'];
    ClientReferenceNo = json['ClientReferenceNo'];
    IsVoucherBooking = json['IsVoucherBooking'];
    CategoryId = json['CategoryId'];
    EndUserIp = json['EndUserIp'];
    TokenId = json['TokenId'];
    TraceId = json['TraceId'];
    HotelRoomsDetails = json['HotelRoomsDetails'].cast();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResultIndex'] = this.ResultIndex;
    data['HotelCode'] = this.HotelCode;
    data['HotelName'] = this.HotelName;
    data['GuestNationality'] = this.GuestNationality;
    data['NoOfRooms'] = this.NoOfRooms;
    data['ClientReferenceNo'] = this.ClientReferenceNo;
    data['IsVoucherBooking'] = this.IsVoucherBooking;
    data['CategoryId'] = this.CategoryId;
    data['EndUserIp'] = this.EndUserIp;
    data['TokenId'] = this.TokenId;
    data['TraceId'] = this.TraceId;
    data['HotelRoomsDetails'] = this.HotelRoomsDetails;
    return data;
  }
}
