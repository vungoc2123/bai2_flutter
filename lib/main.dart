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
    return const ProviderScope(child: MyHomePage());
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme == true ? ThemeData.dark() : ThemeData.light(),
      home: SafeArea(
        child: Scaffold(
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme == true ? Colors.black : Colors.blue)),
                      onPressed: () {
                        _showMyDialog(context);
                      },
                      child: const Text('Hello')),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset('assets/images/img.png'),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Hello world"),
                ],
              );
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const [
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
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
