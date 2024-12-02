import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../Provider/commonviewmodel.dart';
import '../webservice/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CommonViewModel? vm;

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.getproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
        ),
        body: Consumer<CommonViewModel>(builder: (context, product, child) {
          if (product.productload == true) {
            return const Center(child: Text("Loading ..."));
          } else {
            return product.productslist.length == 0
                ? Center(
                    child: Text("No Data"),
                  )
                : StaggeredGridView.countBuilder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.productslist.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      final procduct = product.productslist[index];
                      // log("image"+procduct.image.toString());
                      return InkWell(
                        onTap: () {
                          log("clicked");
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return DetailsPage(
                          //     id: procduct.id!,
                          //     name: procduct.productname!,
                          //     price: procduct.price!.toString(),
                          //     image: Webservice().imageurl+ procduct.image!,
                          //     description: procduct.description!);
                          // }));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        minHeight: 100, maxHeight: 250),
                                    child: Image(
                                        image: NetworkImage(
                                      ApiService().imageurl + procduct.image!,
                                      // "assets/images/slide4.jpg"
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          procduct.productname1!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Rs.' + procduct.price.toString(),
                                          style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                  );
          }
        }));
  }
}
