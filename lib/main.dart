import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/provider/addProductToCart.dart';
import 'package:graduationproject/provider/counter_order.dart';
import 'package:graduationproject/provider/filter_category.dart';
import 'package:graduationproject/provider/imageProfil.dart';
import 'package:graduationproject/provider/invisible_icon.dart';
import 'package:graduationproject/provider/modalProgressHUD.dart';
import 'package:graduationproject/provider/search_product.dart';
import 'package:graduationproject/screens/admin/add_product.dart';
import 'package:graduationproject/screens/admin/admin_panel.dart';
import 'package:graduationproject/screens/admin/edit_product.dart';
import 'package:graduationproject/screens/admin/methodes/flter_category_admin.dart';
import 'package:graduationproject/screens/admin/order_details.dart';
import 'package:graduationproject/screens/admin/view_orders.dart';
import 'package:graduationproject/screens/admin/your_profile.dart';
import 'package:graduationproject/screens/user/cartPage.dart';
import 'package:graduationproject/screens/user/filtterPage.dart';
import 'package:graduationproject/screens/user/methodes/flter_category_user.dart';
import 'package:graduationproject/screens/user/methodes/produt_details.dart';
import 'package:graduationproject/screens/user/searchPage.dart';
import 'package:graduationproject/screens/user/settingsPage.dart';
import 'auth/log_in_screen.dart';
import 'auth/sign_login.dart';
import 'auth/sign_up_screen.dart';
import 'screens/admin/show_product.dart';
import 'screens/user/favoritePage.dart';
import 'screens/user/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/user/profilPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<InvisibleIcon>(
        create: (context) => InvisibleIcon(),
      ),
      ChangeNotifierProvider<ProgressProvider>(
        create: (context) => ProgressProvider(),
      ),
      ChangeNotifierProvider<FilterCategoryItem>(
        create: (context) => FilterCategoryItem(),
      ),
      ChangeNotifierProvider<ImageProfile>(
        create: (context) => ImageProfile(),
      ),
      ChangeNotifierProvider<Search>(
        create: (context) => Search(),
      ),
      ChangeNotifierProvider<CounterOrder>(
        create: (context) => CounterOrder(),
      ),
      ChangeNotifierProvider<AddProductToCart>(
        create: (context) => AddProductToCart(),
      ),
    ],

    child: MyApp(),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  static const String id = 'MyApp';

  User firebaseUser = FirebaseAuth.instance.currentUser;
  String firstWidget() {
    if (firebaseUser != null && firebaseUser.email.contains("admin")) {
      return AdminPanel.id;
    } else if (firebaseUser != null) {
      return HomePage.id;
    } else {
      return SignOrLogin.id;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: firstWidget(),
      routes: {
        SignOrLogin.id: (context) => SignOrLogin(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LogInScreen.id: (context) => LogInScreen(),
        HomePage.id: (context) => HomePage(),
        AdminPanel.id: (context) => AdminPanel(),
        MyApp.id: (context) => MyApp(),
        AddProduct.id: (context) => AddProduct(),
        ShowProduct.id: (context) => ShowProduct(),
        FilterCategory.id: (context) => FilterCategory(),
        EditProduct.id: (context) => EditProduct(),
        YourProfile.id: (context) => YourProfile(),
        FavoritePage.id: (context) => FavoritePage(),
        FilterPage.id: (context) => FilterPage(),
        ProfilePage.id: (context) => ProfilePage(),
        SearchPage.id: (context) => SearchPage(),
        SettingsPage.id: (context) => SettingsPage(),
        ProductDetails.id: (context) => ProductDetails(),
        FilterCategoryUser.id: (context) => FilterCategoryUser(),
        CartPage.id: (context) => CartPage(),
        ViewOrder.id: (context) => ViewOrder(),
        OrderDetails.id: (context) => OrderDetails(),
      },
    );
  }

}
