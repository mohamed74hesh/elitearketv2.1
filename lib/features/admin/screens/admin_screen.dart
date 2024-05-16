import 'package:elitemarketv2/constants/global_variables.dart';
import 'package:elitemarketv2/features/account/services/account_services.dart';
import 'package:elitemarketv2/features/account/widgets/account_button.dart';
import 'package:elitemarketv2/features/admin/screens/orders_screen.dart';
import 'package:elitemarketv2/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 100,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              AccountButton(
                text: 'Log Out',
                onTap: () => AccountServices().logOut(context),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PostsScreen(),
          OrdersScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (index) => _tabController.animateTo(index),
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: IconSize,
        items: [
          _createBottomNavigationBarItem(Icons.home_outlined, 0),
          _createBottomNavigationBarItem(Icons.all_inbox_outlined, 1),
        ],
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        width: BottomBarWidth,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _tabController.index == index
                  ? GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
              width: BottomBarBorderWidth,
            ),
          ),
        ),
        child: Icon(icon),
      ),
      label: '',
    );
  }
}

const double AppBarHeight = 50;
const double BottomBarWidth = 42;
const double BottomBarBorderWidth = 5;
const double IconSize = 28;