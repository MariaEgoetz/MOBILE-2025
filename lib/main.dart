import 'package:flutter/material.dart';

bool isAuthenticated = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Simples',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        }
        if (isAuthenticated) {
          if (settings.name == '/home') {
            return MaterialPageRoute(builder: (_) => HomeScreen());
          }
          if (settings.name == '/profile') {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(builder: (_) => ProfileScreen(userData: args ?? {}));
          }
        }
        return MaterialPageRoute(builder: (_) => LoginScreen());
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            isAuthenticated = true;
            Navigator.pushNamed(context, '/home');
          },
          child: Text('Autenticar e Ir para Home'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo à Home (Privada)'),
            ElevatedButton(
              onPressed: () {
                final userData = {
                  'nomeCompleto': 'Maria Eduarda Goetz Maia',
                  'dataNascimento': '23/03/2005',
                  'telefone': '(64) 98442-6512',
                };
                Navigator.pushNamed(context, '/profile', arguments: userData);
              },
              child: Text('Ir para Perfil'),
            ),
            ElevatedButton(
              onPressed: () {
                isAuthenticated = false;
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  ProfileScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome Completo: ${userData['nomeCompleto'] ?? 'N/A'}'),
            Text('Data de Nascimento: ${userData['dataNascimento'] ?? 'N/A'}'),
            Text('Telefone: ${userData['telefone'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
  