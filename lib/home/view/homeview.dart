import 'dart:convert';

import '../../lib.dart';
import 'package:http/http.dart' as http;

NotificationServices noti = NotificationServices();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    AndroidPermission.notificationPermission().then((value) {
      // noti.requestNotification();
      // if (value) {
      noti.getDeviceToken().then((value) {});
      noti.isTokenRefresh();
      noti.firebaseInit(context);
      noti.setupInteractMessage(context);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                //*
                ElevatedButton(
                  onPressed: () => GetAccessToken.instance.getAccessToken(),
                  child: const Text('Get Access Tokken'),
                ),
                const SizedBox(height: 20),
                //this is to send message to other device
                ElevatedButton(
                  onPressed: () {
                    // Get the device token using the noti object
                    noti.getDeviceToken().then((value) async {
                      // Prepare the data to be sent in the FCM (Firebase Cloud Messaging) request
                      var data = {
                        'to': value
                            .toString(), // Specify the recipient device's FCM token
                        'priority': 'high', //*ya ni ha
                        'notification': {
                          'title': 'Asif', // Title of the notification
                          'body':
                              'Subscribe to my channel', // Body text of the notification
                        },
                        //
                        'android': {
                          'notification': {
                            'notification_count': 23,
                          }
                        },
                        //To go to next screen
                        'data': {
                          'type': 'msg',
                          'id': 'Abdullah',
                        },
                      };
                      // Send a POST request to the FCM API to deliver the message
                      await http.post(
                          // Define the URI for the FCM API
                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                          // Uri.parse('https://fcm.googleapis.com/v1/projects/fir-9e91b/messages:send'),
                          body: jsonEncode(data), // Encode the data as JSON
                          headers: {
                            // Define the headers for the FCM API request
                            'Content-Type': 'application/json: charset=UTF-8',
                            // 'Authorization':
                            //     'ftDFotb4RHubd64tniHSAU:APA91bEd5fC6sqLsG3ZO7TK4vtb45ARQeTcAVaRHgdv6WAsdBYsT2jTweDxlDWhzOFRbgcctvKqojh9OboCdWCgnDXyRA9N_4pevWEC2RxlEtCxY6WaPM3-2pNXUYWeChdiNH-FMpjPs', //TODO Put your key here from cloud messaging api(legacy)
                            //* yahan server wali key rakh raha   
                            'Auth':
                                'ftDFotb4RHubd64tniHSAU:APA91bEd5fC6sqLsG3ZO7TK4vtb45ARQeTcAVaRHgdv6WAsdBYsT2jTweDxlDWhzOFRbgcctvKqojh9OboCdWCgnDXyRA9N_4pevWEC2RxlEtCxY6WaPM3-2pNXUYWeChdiNH-FMpjPs', 
                                //TODO Put your key here from cloud messaging api(legacy)
                          }).then((value) {
                        debugPrint('value: $value');
                      }).onError((error, stackTrace) {
                        debugPrint('Error: $error');
                      });
                    });
                  },
                  child: const Text('Get Access Tokken'),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Firebase Push Notification'),
      ),
    );
  }
}

  //isolates isolate
