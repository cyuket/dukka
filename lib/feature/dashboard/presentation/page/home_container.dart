import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/widget/touchables/touchable_opacity.dart';
import 'package:dukka/feature/dashboard/presentation/page/home_page.dart';
import 'package:dukka/feature/dashboard/presentation/widget/nav_bottom_sheet.dart';
import 'package:dukka/feature/dashboard/presentation/widget/navbar_widget.dart';
import 'package:dukka/feature/debtor/presentation/pages/all_debtors.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key, this.params}) : super(key: key);
  final HomeContainerParams? params;
  @override
  HomeContainerState createState() => HomeContainerState();
}

class HomeContainerState extends State<HomeContainer> {
  late int _selectedIndex;
  Widget? child;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      if (widget.params == null) {
        _selectedIndex = 0;
        child = null;
      } else {
        _selectedIndex = widget.params!.index;
        child = widget.params!.child;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = <Widget>[
      const HomePage(),
      // const EscrowPage(),
      const AllDebtors(),
      // Container()
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TouchableOpacity(
        onTap: () => CreateBudgetBootom.show(context: context),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: AppColors.blackColor10,
            ),
          ),
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.white,
        selectedColor: AppColors.blueColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        centerItemText: '',
        items: [
          FABBottomAppBarItem(
            icon: Icons.home,
            text: 'Home',
          ),
          FABBottomAppBarItem(
            icon: Icons.money,
            text: 'File',
          ),
        ],
      ),
    );
  }
}

class HomeContainerParams {
  HomeContainerParams({this.child, required this.index});

  final int index;
  final Widget? child;
}
