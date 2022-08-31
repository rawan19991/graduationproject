import '../../model/product.dart';
import '../../provider/modalProgressHUD.dart';
import '../../widget/sign_up.dart';
import '../../widget/textformfield_1.dart';
import 'admin_panel.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'methodes/edit_product.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  static const String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
 var  nameController = TextEditingController();

 var priceController = TextEditingController();

 var  descriptionController = TextEditingController();

 var categoryController = TextEditingController();

 var imageController = TextEditingController();

   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 var productId ;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      final arguments = ModalRoute.of(context).settings.arguments as Map;
      var product = arguments['product'] as Product;
      productId=arguments['productId'];

      nameController.text=product.name;
      priceController.text=product.price;
      descriptionController.text=product.description;
      categoryController.text=product.category;
      imageController.text=product.image;

    });
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Success",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.green.shade700),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
              backgroundColor: Colors.blue.withOpacity(.5),
            ),
            child: Text(
              "Going to Admin panal",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AdminPanel.id);
            },
          ),
        ),

      ],
    );
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressProvider>(
        context,
      ).inAsyncCall,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormFieldAll(
                        "Product Name",
                        nameController,
                        false,
                        validatorName,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFieldAll(
                        "Product Price",
                        priceController,
                        false,
                        validatorPrice,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFieldAll(
                        "Product Description",
                        descriptionController,
                        false,
                        validatorDescription,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFieldAll(
                        "Product Category",
                        categoryController,
                        false,
                        validatorCategory,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFieldAll(
                        "Product Image",
                        imageController,
                        false,
                        validatorImage,
                      ),
                    ],
                  )),
              SizedBox(
                height: 65,
              ),
              SignUp(() async {
                Provider.of<ProgressProvider>(context, listen: false)
                    .isLoding(true);
                if (_formKey.currentState.validate()) {
                  await updateProduct(
                      productId,
                      nameController,
                      priceController,
                      descriptionController,
                      categoryController,
                      imageController);
                  Provider.of<ProgressProvider>(context, listen: false)
                      .isLoding(false);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
                Provider.of<ProgressProvider>(context, listen: false)
                    .isLoding(false);
              }, 'Edit Product', 250.0)
            ],
          ),
        ),
      ),
    ));
  }
}
