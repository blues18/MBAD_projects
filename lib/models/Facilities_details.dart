 class facilitiesDetail {
   final String place; // LAter delete this!!!!!!!!!!!!
   final String blocks_and_level;
   final String opening_hours;
   final String facilities_type;

   const facilitiesDetail({required this.place, required this.blocks_and_level, required this.opening_hours, required this.facilities_type});
}

const allfacilitiesDetail = [

facilitiesDetail(
place:'Anchorvale communtiy ceneter',
blocks_and_level: 'Block 1 level 1 #01-112',
opening_hours: '07:00 - 23:00',
facilities_type: 'gym'),

facilitiesDetail(
place: 'Fernvale community center',
blocks_and_level: 'near main entrance',
opening_hours: '07:00 - 23:59',
facilities_type: 'gym'),

facilitiesDetail(
place: 'Hougang Community center',
blocks_and_level: 'Block 1 level 2 #02-001',
opening_hours: '07:00 - 23:00',
facilities_type: 'gym')
];
