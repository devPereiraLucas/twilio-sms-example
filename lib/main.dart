import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:twilio_sms/shared/inputsFormatters.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send SMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Send SMS with Twilio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const accountSid = "Your SID";
  static const accountToken = "Your Token";
  static const accountPhone = "Your phone Number";
  final messageController = TextEditingController();
  final receiverNumberController = TextEditingController();

  final twilioFlutter = TwilioFlutter(
      accountSid: accountSid, // replace *** with Account SID
      authToken: accountToken, // replace xxx with Auth Token
      twilioNumber: accountPhone // replace .... with Twilio Number
      );

  void sendSMS() {
    twilioFlutter.sendSMS(
        toNumber: receiverNumberController.text,
        messageBody: messageController.text);
    ScaffoldMessenger.of(context).showSnackBar(snackBarSMSSucess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: messageController,
                decoration:
                    const InputDecoration(hintText: 'Escreva sua mensagem...'),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: receiverNumberController,
                inputFormatters: [InputsFormatter.phoneMaskFormatter],
                decoration: const InputDecoration(
                    hintText: 'Para quem devo enviar a mensagem?'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Para enviar o SMS, precione o botão abaixo!',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSMS,
        tooltip: 'Send',
        child: const Icon(Icons.send),
      ),
    );
  }

  final snackBarSMSSucess = const SnackBar(
    content: Text(
      'SMS enviado com sucesso!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.green,
  );

  final snackBarSMSFail = const SnackBar(
    content: Text(
      'Falha ao enviar SMS, tente novamente!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
  );
}
