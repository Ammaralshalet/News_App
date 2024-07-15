import 'package:flutnews/core/config/bloc_observer.dart';
import 'package:flutnews/core/config/service_locater.dart';
import 'package:flutnews/features/presentation/bloc/manager/manager_bloc.dart';
import 'package:flutnews/features/presentation/bloc/manager/manager_event.dart';
import 'package:flutnews/features/presentation/bloc/manager/manager_state.dart';
import 'package:flutnews/features/presentation/bloc/save/save_bloc.dart';
import 'package:flutnews/view/home_page.dart';
import 'package:flutnews/view/login_page.dart';
import 'package:flutnews/view/account_page.dart';
import 'package:flutnews/view/save_page.dart';
import 'package:flutnews/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManagerBloc()
            ..add(ExcuteLastRequest())
            ..add(CheckAuthorized()),
        ),
        BlocProvider(
          create: (context) => SaveBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<ManagerBloc, ManagerState>(
          builder: (context, state) {
            if (state is NavigateToHomePage) {
              return const MainPage();
            } else if (state is NavigateToOffline) {
              return const OfflinePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InkWell(
          onTap: () {
            context.read<ManagerBloc>().add(RestoreToLogIn());
          },
          child: const Text.rich(
            TextSpan(
              text: 'Error in username or password ',
              style: TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: ' Click back to log in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const SavePage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.orange,
        color: const Color(0xff001F3F),
        items: [
          const Icon(Icons.home, color: Colors.white),
          Icon(pageIndex == 1 ? Icons.search : Icons.search_outlined,
              color: Colors.white),
          Icon(pageIndex == 2 ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white),
          Icon(pageIndex == 3 ? Icons.person : Icons.person_outline,
              color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}
