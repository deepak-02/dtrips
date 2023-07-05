class Passenger {
  String title;
  String firstName;
  String lastName;
  int paxType;
  String dateOfBirth;
  int gender;
  String passportNo;
  String passportExpiry;
  String addressLine1;
  String addressLine2;
  String city;
  String countryCode;
  String countryName;
  String nationality;
  String contactNo;
  String email;
  bool isLeadPax;
  Fare fare;
  List<Baggage> baggage;
  List<Meal> mealDynamic;
  List<Seat> seatDynamic;

  Passenger({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.paxType,
    required this.dateOfBirth,
    required this.gender,
    required this.passportNo,
    required this.passportExpiry,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.countryCode,
    required this.countryName,
    required this.nationality,
    required this.contactNo,
    required this.email,
    required this.isLeadPax,
    required this.fare,
    required this.baggage,
    required this.mealDynamic,
    required this.seatDynamic,
  });
}

class Fare {
  int baseFare;
  int tax;
  int yqTax;
  int additionalTxnFeePub;
  int additionalTxnFeeOfrd;
  double otherCharges;

  Fare({
    required this.baseFare,
    required this.tax,
    required this.yqTax,
    required this.additionalTxnFeePub,
    required this.additionalTxnFeeOfrd,
    required this.otherCharges,
  });
}

class Baggage {
  String airlineCode;
  String flightNumber;
  int wayType;
  String code;
  int description;
  int weight;
  String currency;
  int price;
  String origin;
  String destination;

  Baggage({
    required this.airlineCode,
    required this.flightNumber,
    required this.wayType,
    required this.code,
    required this.description,
    required this.weight,
    required this.currency,
    required this.price,
    required this.origin,
    required this.destination,
  });
}

class Meal {
  String airlineCode;
  String flightNumber;
  int wayType;
  String code;
  int description;
  String airlineDescription;
  int quantity;
  String currency;
  int price;
  String origin;
  String destination;

  Meal({
    required this.airlineCode,
    required this.flightNumber,
    required this.wayType,
    required this.code,
    required this.description,
    required this.airlineDescription,
    required this.quantity,
    required this.currency,
    required this.price,
    required this.origin,
    required this.destination,
  });
}

class Seat {
  String airlineCode;
  String flightNumber;
  String craftType;
  String origin;
  String destination;
  int availablityType;
  int description;
  String code;
  String rowNo;
  String seatNo;
  int seatType;
  int seatWayType;
  int compartment;
  int deck;
  String currency;
  int price;

  Seat({
    required this.airlineCode,
    required this.flightNumber,
    required this.craftType,
    required this.origin,
    required this.destination,
    required this.availablityType,
    required this.description,
    required this.code,
    required this.rowNo,
    required this.seatNo,
    required this.seatType,
    required this.seatWayType,
    required this.compartment,
    required this.deck,
    required this.currency,
    required this.price,
  });
}
