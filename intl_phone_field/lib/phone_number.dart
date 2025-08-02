import 'package:flutter/foundation.dart';

import 'countries.dart';

class NumberTooLongException implements Exception{}
class NumberTooShortException implements Exception{}
class InvalidCharactersException implements Exception{}

class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  factory PhoneNumber.fromCompleteNumber({required String completeNumber}){
    if(completeNumber == "") {
      return PhoneNumber(countryISOCode: "",
          countryCode: "",
          number: "");
    }

    try{
      AppIntlCountry country = getCountry(completeNumber);
      String number;
      if (completeNumber.startsWith('+')) {
        number = completeNumber.substring(1+country.dialCode.length+country.regionCode.length);
      } else {
        number = completeNumber.substring(country.dialCode.length+country.regionCode.length);
      }
      return PhoneNumber(countryISOCode: country.code,
          countryCode: country.dialCode + country.regionCode,
          number: number);
    } on InvalidCharactersException{
      rethrow;
    } on Exception catch(e){
      if(kDebugMode) {
        print(e.toString());
      }
      return PhoneNumber(countryISOCode: "",
          countryCode: "",
          number: "");
    }

  }

  bool isValidNumber(){
      AppIntlCountry country = getCountry(completeNumber);
      if( number.length < country.minLength){
        throw NumberTooShortException();
      }

      if( number.length > country.maxLength){
        throw NumberTooLongException();
      }
      return true;
  }

  String get completeNumber {
    return countryCode + number;
  }

  static AppIntlCountry getCountry(String phoneNumber) {
    if(phoneNumber == ""){
      throw NumberTooShortException();
    }

    final _validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if(!_validPhoneNumber.hasMatch(phoneNumber)){
      throw InvalidCharactersException();
    }

    if (phoneNumber.startsWith('+')) {
      return intlCountriesList.firstWhere((country) =>
          phoneNumber
              .substring(1)
              .startsWith(country.dialCode + country.regionCode));
    }
    return intlCountriesList.firstWhere((country) =>
        phoneNumber.startsWith(country.dialCode + country.regionCode));
  }

  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
