class EndPoints {
  static const String baserUrl = "http://57.129.46.137/api/v1/";
  static const String login = "auth/login";
  static const String sendOTP = "auth/send_otp";
  static const String register = "auth/register";
  static const String me = "auth/me";
  static const String profile = "auth/profile";
  static const String governorate = "governorate?per_page=18";
  static const String complaint = "complaint";
  static const String deleteComplaint = "complaint/";
  static const String perPage = "complaint?per_page=";
  static const String predictionsBaseURL =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?components=country:IQ";
  static const String predictionsDetailsBaseURL =
      "https://maps.googleapis.com/maps/api/place/details/json";
}
