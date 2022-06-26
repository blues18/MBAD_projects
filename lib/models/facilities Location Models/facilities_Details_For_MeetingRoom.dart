class Facilities_Details_Meeting_Room{ //saved for part 3
  String id;
  String location;
  String block_And_Level;
  String room_Number;
  String opening_Hour;
  String facilities_Type;
  String facilities_Notice;
  int Room_Size;
  int pax_size;
  bool Smart_tv;
  bool Whiteboard;
  bool wifi;
  bool DigitalAvSolution;
  bool officeSupplies;
  bool AccessToRefreshment;

  Facilities_Details_Meeting_Room(
  {required this.id, required this.location, required this.block_And_Level, required this.room_Number
    ,required this.opening_Hour, required this.facilities_Type, required this.facilities_Notice,
    required this.Room_Size, required this.pax_size, required this.Smart_tv, required this.Whiteboard
    ,required this.wifi, required this.DigitalAvSolution, required this.officeSupplies
    ,required this.AccessToRefreshment
});


}