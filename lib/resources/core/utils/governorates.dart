import 'dart:convert';
import 'package:tasks_collector/main.dart';

class Governorates {
  late final Map<String, int> governoratesMap;
  late final List<String> governoratesNames;
  late final List<int> governoratesIDs;

  Governorates() {
    governoratesMap = preferences!.getString('governorates') != null
        ? Map<String, int>.from(
            jsonDecode(preferences!.getString('governorates')!))
        : {};
    governoratesNames = governoratesMap.keys.toList();
    governoratesIDs = governoratesMap.values.toList();
  }
}

// final List<String> governoratesList = [
//   'erbil',
//   'al-anbar',
//   'babil',
//   'baghdad',
//   'basra',
//   'duhok',
//   'al-qadisiyah',
//   'dialah',
//   'dhi qar',
//   'al-sulaymaniyah',
//   'salah al-deen',
//   'karkuk',
//   'karbalaa',
//   'al-muthanna',
//   'misan',
//   'al-najaf',
//   'naynawah',
//   'wasit',
// ];
//
// final Map<String, String> governoratesNamesMapEnglish = {
//   'erbil': '1',
//   'al-anbar': '2',
//   'babil': '3',
//   'baghdad': '4',
//   'basra': '5',
//   'duhok': '6',
//   'al-qadisiyah': '7',
//   'dialah': '8',
//   'dhi qar': '9',
//   'al-sulaymaniyah': '10',
//   'salah al-deen': '11',
//   'karkuk': '12',
//   'karbalaa': '13',
//   'al-muthanna': '14',
//   'misan': '15',
//   'al-najaf': '16',
//   'naynawah': '17',
//   'wasit': '18',
// };
//
// final Map<String, String> governoratesNamesMapArabic = {
//   'أربيل': '1',
//   'الأنبار': '2',
//   'بابل': '3',
//   'بغداد': '4',
//   'البصرة': '5',
//   'دهوك': '6',
//   'القادسية': '7',
//   'ديالى': '8',
//   'ذي قار': '9',
//   'السليمانية': '10',
//   'صلاح الدين': '11',
//   'كركوك': '12',
//   'كربلاء': '13',
//   'المثنى': '14',
//   'ميسان': '15',
//   'النجف': '16',
//   'نينوى': '17',
//   'واسط': '18',
// };
//
// final Map<String, String> governoratesNumbersMap = {
//   '1': 'erbil',
//   '2': 'al-anbar',
//   '3': 'babil',
//   '4': 'baghdad',
//   '5': 'basra',
//   '6': 'duhok',
//   '7': 'al-qadisiyah',
//   '8': 'dialah',
//   '9': 'dhi qar',
//   '10': 'al-sulaymaniyah',
//   '11': 'salah al-deen',
//   '12': 'karkuk',
//   '13': 'karbalaa',
//   '14': 'al-muthanna',
//   '15': 'misan',
//   '16': 'al-najaf',
//   '17': 'naynawah',
//   '18': 'wasit',
// };
//

//  "erbil": "أربيل",
//  "al-anbar": "الأنبار",
//  "babil": "بابل",
//  "baghdad": "بغداد",
//  "basra": "البصرة",
//  "duhok": "دهوك",
//  "al-qadisiyah": "القادسية",
//  "dialah": "ديالى",
//  "dhi qar": "ذي قار",
//  "al-sulaymaniyah": "السليمانية",
//  "salah al-deen": "صلاح الدين",
//  "karkuk": "كركوك",
//  "karbalaa": "كربلاء",
//  "al-muthanna": "المثنى",
//  "misan": "ميسان",
//  "al-najaf": "النجف",
//  "naynawah": "نينوى",
//  "wasit": "واسط",
//
// "erbil": "Erbil",
// "al-anbar": "Al-Anbar",
// "babil": "Babil",
// "baghdad": "Baghdad",
// "basra": "Basra",
// "duhok": "Duhok",
// "al-qadisiyah": "Al-Qadisiyah",
// "dialah": "Dialah",
// "dhi qar": "Dhi Qar",
// "al-sulaymaniyah": "Al-Sulaymaniyah",
// "salah al-deen": "Salah Al-Deen",
// "karbalaa": "Karbalaa",
// "karkuk": "Karkuk",
// "al-muthanna": "Al-Muthanna",
// "misan": "Misan",
// "al-najaf": "Al-Najaf",
// "naynawah": "Naynawah",
// "wasit": "Wasit",
