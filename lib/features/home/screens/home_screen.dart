import 'package:elitemarketv2/common/widgets/loader.dart';
import 'package:elitemarketv2/constants/global_variables.dart';
import 'package:elitemarketv2/constants/utils.dart';
import 'package:elitemarketv2/features/account/widgets/single_product.dart';
import 'package:elitemarketv2/features/home/services/home_services.dart';
import 'package:elitemarketv2/features/home/widgets/address_box.dart';
import 'package:elitemarketv2/features/home/widgets/carousel_image.dart';
import 'package:elitemarketv2/features/home/widgets/deal_of_day.dart';
import 'package:elitemarketv2/features/home/widgets/top_categories.dart';
import 'package:elitemarketv2/features/product_details/screens/product_details_screen.dart';
import 'package:elitemarketv2/features/search/screens/search_screen.dart';
import 'package:elitemarketv2/features/search/widget/searched_product.dart';
import 'package:elitemarketv2/models/product.dart';
import 'package:flutter/material.dart';

import '../../admin/services/admin_services.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>? products;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
  final products = await homeServices.fetchAllProducts(context);
  if (mounted) {
    setState(() {
      this.products = products;
    });
  }
}

  void navigateToSearchScreen(String query) {
    if (query == null) {
      
      
    }
  
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: "Serearch In ${appname}",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
      body:
          // products == null
          //     ? const Loader()
          Column(
        children: [
          
          const SizedBox(height: 10),
          const TopCategories(),
          const SizedBox(height: 10),
          const CarouselImage(),
          products == null
              ? const Loader()
              : Expanded(
                  child: GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final product = products![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: product,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product.images[0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${product.price} EG",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
