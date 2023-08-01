import 'package:dtrips/home/ui/hotel/models/roomModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/Flight/LccSsrModel.dart';
import '../db/Flight/newsearchModel.dart';

var ip = '';

//Hotel................

int GuestCount = 1;
int room = 1;
List StoredGuest = [RoomModel(1, 1, 0, []).toJson()];

var countryCode = "";
var cityId = "";
var country = "";
var city = "";

List imgList = [];
List hotelFacilities = [];

List commonFacilities = [
  {"name": "Free WiFi", "icon": Icons.wifi},
  {"name": "Bar/lounge", "icon": Icons.local_bar},
  {"name": "elevator", "icon": Icons.elevator},
  {"name": "Breakfast available (surcharge)", "icon": Icons.free_breakfast},
  {"name": "24-hour front desk", "icon": Icons.support_agent},
  {"name": "Fitness facilities", "icon": Icons.fitness_center},
  {"name": "Free self parking", "icon": Icons.local_parking_rounded},
  {"name": "Restaurant", "icon": Icons.restaurant},
  {"name": "Dry cleaning/laundry service", "icon": Icons.dry_cleaning},
  {"name": "Laundry facilities", "icon": Icons.local_laundry_service},
  {"name": "Free newspapers in lobby", "icon": Icons.newspaper},
  {"name": "Luggage storage", "icon": Icons.luggage},
  {"name": "Concierge services", "icon": Icons.room_service},
  {"name": "Coffee shop or café", "icon": Icons.coffee},
];

List hotelRoomDetail = [];
List hotelRoomDetail1 = [];

var SaveImg = '';

var name;
var pemail;
var pphone;
var paddress;

var color = Colors.white;

var chechinDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
var checkOutDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().add(const Duration(days: 1)))
    .toString();

var inDate = DateFormat('dd MMM').format(DateTime.now()).toString();
var outDate = DateFormat('dd MMM')
    .format(DateTime.now().add(const Duration(days: 1)))
    .toString();

var night = 1;

var passDate1 = DateFormat('dd MMM').format(DateTime.now()).toString();
var passDate2 = DateFormat('dd MMM')
    .format(DateTime.now().add(const Duration(days: 1)))
    .toString();

//Flight.............

var departureDate =
    DateFormat('yyyy-MM-ddT00:00:00').format(DateTime.now()).toString();
var returnDate =
    DateFormat('yyyy-MM-ddT00:00:00').format(DateTime.now()).toString();

var depDate = DateFormat('dd MMM').format(DateTime.now()).toString();
var retDate = DateFormat('dd MMM').format(DateTime.now()).toString();

var nightF = 1;
var btn1 = "active", btn2 = "", btn3 = "";

int journeyType = 1;

int planeClassType = 1;
String planeClassName = "All";

List<Result> flightDetails = [];

var fromPlace = "";
var fromPort = "Select a place";
var toPlace = "";
var toPort = "Select a place";

int noOfAdult = 1;
int noOfChild = 0;
int noOfInfant = 0;

var destinationCode = "";
var destinationAirportName = "";
var destinationAirportCode = "";
var destinationCityName = "";
var destinationCityCode = "";
var destinationCountryCode = "";

var originCode = "";
var originAirportName = "";
var originAirportCode = "";
var originCityName = "";
var originCityCode = "";
var originCountryCode = "";

bool ClickLoading = false;

late bool lcc;
var res = "noooooooo";
bool ssr = true;

List<Baggage> LccBaggage = [];

List<Baggage> mealItems = [];

List<SeatDynamic>? seatDynamic = [];
List<SpecialService>? specialServices = [];

// Set selectedSeats = {};
List<Map<String, dynamic>> selectedSeats = [];

List FlightSeats = [];

// var selectedMeal = "Spaghetti";
dynamic selectedMeal;

// List<dynamic> baggageOptions = ['Select Baggage'];
dynamic selectedOption;

var selectedItem;
var selectedDuration = "";
var selectedFlight = "";
