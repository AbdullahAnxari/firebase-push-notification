import 'lib.dart';

class GetAccessToken {
  static final instance = GetAccessToken();
  late String accessToken;
  dynamic getAccessToken() async {
    // Replace with the path to your service account JSON file
    final credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "fir-9e91b",
      "private_key_id": "65027c1cc11ccf7ca40cc99ec318c536b114a193",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDB7I0UT3qN9tFN\nl1KwUcx/vRsF6TDyeKeeJjgbEoT9WNa6rOa3ePm1lkot0QJ4PlLA0eVU++Woskfg\nic8miFE/Sy4YJn/q/KEo698Zs/kx25Gh2bJW8DFUR/dLfEIVOlDAqHiFi+3ElBO+\nknOUdYxI4/i4hRL1Jch+xOS/nl3SXe8MyBCyePpSiwyuoy6zqFzdKjDBUwm6wxOW\n3tkPgokd/i9z3jeZXceOSxLF6ijOP6zKh5vKJIhIC90hJoEjhg1am8x6FfenYCU1\nWot+syCKGwYmrRS9Z2Fa1AUtyNf5EeeK0zqlz+jYSTqVyCSox7R7nnTW15ZEbHfE\n2poVyw8pAgMBAAECggEAA99SCd/JwLVMWfz1kmkaaPVBFDh4g77+XzLALWTh8Z/T\n2d0Yq6fnb0WAVwiKFhXt18Uui9M5M3SBPu3sNwbDKJJlvzxgPYmskNafmTHLfhVh\nA8GxxU6n4tj1CorWqaSFIZ5mRF8WRmChQaLxr+XmVpDxfIMbwngYrX9dBKky57/I\nzKklKCLw1pIALRnL4AyvvJ8DFiyZuYhzW9app2u3URnJdbUM9qyulvrNCs4Zj0g5\nkWxlNQZthEsMzZdLQS9ie4FS/KOU9Ad/xWCdN2K3SGn2VeBLwgg7mB948quaCJ1P\nhONJw+mvi6T1ntz2Gkgu6Ek4aOC5a64VMe5+anQryQKBgQD9a6glKmTE2r3ga1zh\nQchZUX8JzjtIfQ21QcRpKh5FfIcpgGviTxrY0bX4FKdFzXINforBIhAF0wIKAuqk\n5j+BXLCSpQFk/VlX8afsUnejPRbZZTLt7/FTl8YhylimRloljaE+YUDpaaJaCAKp\n2r0eNH8Mh9tW+a2Kv5KqGK/GWwKBgQDD5dzsdF4XsvmgxEIRnZV1qWL18XVpL7hS\n7hK2LBFwM9Uzsb/MJlY/RHYP0JkEo9x0EZHsPsczBnfPFJB2jeA86wv+XxN6nShb\nX4fcVhurHZA4yQxJCXPo6n20BU2goxDvEq+TT8BE8Vthsm8WiP9E8F+QljrJc0VX\nLHc1kvdfywKBgQCiMbofd1+hYoLuVKjQfwLUr8VIKFdnEKqqXNpxmIRhYs87L7dc\n09ZR+P6nNcjNcy1RF7GE5OEuaRu//pfhTIBOsl1MrhETatc44zDfnvR1ZM7v+sY6\n5TwmjVhBHjnYyeQ+bsRJoYMjIPnI96GExrwNzfmWsokexJRe3jfnZ/9wSwKBgG/O\nFVTu5XTpNQfIe1zKb68DyfNMqBIspirOredDJ4C+VIR4glrl1nuteyRzjaHUU9H6\n5SnMeqxomKCbwAep2b1q+SFo6hkk8Q+Valka3BfBe7qtJFHbD0hz7OJ91FxGNTf9\nli+haL7wcZNE35og/nA+MIy48TxgicbDHhZ5lq4ZAoGAPnKKUDwvPyNMinj7O7Al\nITAO3QrRulwydPbRl6MS3vsfdrIVZljctWCKQhru7KmWtYPwmDpkdTXmoGI+G4SL\ns08d+kQoukeJuniO0O+tiazn3KW0orftuMyXtJG67JUf+dZX5XSJ98i2cdoUXs/j\nWNTfBhEUm6ExFIWo6Za3//I=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-9z7xo@fir-9e91b.iam.gserviceaccount.com",
      "client_id": "112612973990831874912",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9z7xo%40fir-9e91b.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });
    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await clientViaServiceAccount(credentials, scopes);
    debugPrint("${client.credentials.accessToken.data.substring(0, 512)}/");
    debugPrint("${client.credentials.accessToken.data.substring(513)}/");
    accessToken = client.credentials.accessToken.data;
  }
}
