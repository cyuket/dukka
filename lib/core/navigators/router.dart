import 'package:dukka/core/navigators/routes.dart';
import 'package:dukka/feature/auth/presentation/pages/login.dart';
import 'package:dukka/feature/auth/presentation/pages/signup.dart';
import 'package:dukka/feature/dashboard/presentation/page/adding_expenses.dart';
import 'package:dukka/feature/dashboard/presentation/page/adding_income.dart';
import 'package:dukka/feature/dashboard/presentation/page/home_container.dart';
import 'package:dukka/feature/debtor/presentation/pages/add_debtor.dart';
import 'package:flutter/material.dart';

/// Generate routes for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.loginPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const LoginPage(),
      );
    case Routes.signupPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SignupPage(),
      );
    case Routes.dashboardScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeContainer(
          params: settings.arguments as HomeContainerParams?,
        ),
      );
    case Routes.addDebtScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const AddDebtorPage(),
      );
    case Routes.addExpenseScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const AddingExpensePage(),
      );
    case Routes.addIncomeScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const AddingIncomePage(),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute<dynamic>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
