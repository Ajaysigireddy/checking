import 'package:fllutter/screens/libraryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fllutter/constantsHelpers/connectionCheck.dart'; // Import your ConnectivityService

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectivityService(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ConnectivityWrapper(),
        routes: {
          '/library': (context) => LibraryScreen(),
          // Add other routes here
        },
      ),
    );
  }
}

class ConnectivityWrapper extends StatefulWidget {
  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  @override
  Widget build(BuildContext context) {
    final connectivityService = Provider.of<ConnectivityService>(context);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!connectivityService.hasConnection) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No Internet Connection'),
            duration: Duration(days: 365), // Persistent snackbar
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                connectivityService.retryConnectivity(); // Retry connectivity check
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
          // Use the initial route
          return MaterialPageRoute(
            builder: (context) => LibraryScreen(), // Change this to your initial screen
          );
        },
      ),
    );
  }
}
