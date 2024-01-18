// ignore_for_file: non_constant_identifier_names

class ApiUrls {
  ApiUrls() {
    login = '${domainUrl}login';
    notifications = '${domainUrl}notifications/';
    notificationRead = '${domainUrl}notifications-read';
    single_ads = '${domainUrl}single-ads/';
    email = '${domainUrl}email';
    buisness_categories = '${domainUrl} ';
    zipcodes = '${domainUrl}zipcodes/';
    registration = '${domainUrl}registration';
    change_name = '${domainUrl}change-name';
    change_password = '${domainUrl}change-password';
    getuser = '${domainUrl}getuser/';
    general_setting = '${domainUrl}general-setting';
    auth_categories = '${domainUrl}auth-categories/';
    impressions = '${domainUrl}impressions';
    advertismentCategory = '${domainUrl}advertismentCategory/';
    privacy = '${domainUrl}privacy-policy/';
    aboutUs = '${domainUrl}about/';
    activateApi = '${domainUrl}account-deletion/';
  }
  final domainUrl = "https://ffadvertisement.appscanada.net/api/";
  late String login;
  late String notifications;
  late String notificationRead;
  late String single_ads;
  late String email;
  late String buisness_categories;
  late String zipcodes;
  late String registration;
  late String change_name;
  late String change_password;
  late String getuser;
  late String general_setting;
  late String auth_categories;
  late String impressions;
  late String advertismentCategory;
  late String privacy;
  late String aboutUs;
  late String activateApi;
}
