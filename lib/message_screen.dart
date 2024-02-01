import 'lib.dart';

class MessageScreen extends StatelessWidget {
  final String id;
  const MessageScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Center(
            child: Text('data'),
          )
        ],
      ),
      appBar: AppBar(
        title: Text('Message Screen  $id'),
      ),
    );
  }
}
