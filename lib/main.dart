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
          if (settings.name == '/main') {
            return MaterialPageRoute(builder: (_) => MainScreen());
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
            Navigator.pushNamed(context, '/main');
          },
          child: Text('Autenticar e Ir para Main'),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const Module2Tab(),
    const ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Módulo 2'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Bem-vindo à Home')),
    );
  }
}

class Module2Tab extends StatelessWidget {
  const Module2Tab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Módulo 2'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NestedRouteScreen(tabName: 'Tab 1'),
            NestedRouteScreen(tabName: 'Tab 2'),
          ],
        ),
      ),
    );
  }
}

class NestedRouteScreen extends StatelessWidget {
  final String tabName;

  const NestedRouteScreen({super.key, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Conteúdo da $tabName'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubScreen(tabName: tabName)),
              );
            },
            child: Text('Ir para Sub-Tela'),
          ),
        ],
      ),
    );
  }
}

class SubScreen extends StatelessWidget {
  final String tabName;

  const SubScreen({super.key, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sub-Tela de $tabName')),
      body: Center(child: Text('Esta é uma rota aninhada dentro da $tabName')),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = {
      'nomeCompleto': 'Maria Eduarda Goetz Maia',
      'dataNascimento': '23/03/2005',
      'telefone': '(64) 98442-6512',
    };
    return ProfileScreen(userData: userData);
  }
}

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileScreen({super.key, required this.userData});

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
  