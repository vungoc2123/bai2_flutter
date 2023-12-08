import 'package:bai_2/ThemeModeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const ProviderScope(child: MyHomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}

final themeProvider = StateNotifierProvider<ThemeModeNotifier, bool>(
  (ref) => ThemeModeNotifier(),
);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    Color colorText = theme == true ? Colors.white : Colors.black;
    Color colorBg = theme == true ? Colors.black : Colors.white;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: AppBar(
          title: const Text("Bài 2"),
          actions: [
            Switch(
              value: theme,
              onChanged: (bool newValue) {
                ref.read(themeProvider.notifier).toggleTheme(newValue);
              },
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.grey,
            ),
          ],
        ),
        body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _showMyDialog(context, colorText, colorBg);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(colorBg)),
                    child: Text('Hello', style: TextStyle(color: colorText))),
                const SizedBox(height: 50,),
                Image.asset('assets/images/img.png'),
                const SizedBox(height: 50,),
                Text(
                  "Hello world",
                  style: TextStyle(
                      color: colorText,
                      backgroundColor: colorBg),
                )
              ],
            );
          },

        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context, Color colorText, Color colorBg) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: colorBg,
        title: Text(
          'AlertDialog Title',
          style: TextStyle(
              color: colorText,
              backgroundColor: colorBg),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('This is a demo alert dialog.', style: TextStyle(
                color: colorText,
                backgroundColor: colorBg
              ),),
              Text('Would you like to approve of this message?', style: TextStyle(
                color: colorText,
                backgroundColor: colorBg
              ),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
