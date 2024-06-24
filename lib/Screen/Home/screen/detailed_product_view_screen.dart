// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meatzy/Constants/Global_Variables.dart';
import 'package:meatzy/Model/meat_seller_model.dart';
import 'package:meatzy/Widget/carousel_widget.dart';

class DetailedProductViewScreen extends StatelessWidget {
  Product product;
  DetailedProductViewScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    const textStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        wordSpacing: 3);

    const seeAllStyle = TextStyle(
        color: Color.fromARGB(255, 6, 81, 143),
        fontSize: 14,
        fontWeight: FontWeight.w800);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalVariables.secondaryColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: ListView(children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 250,
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   child: CarouselSlider(
            //     items: product.images.map(
            //       (i) {
            //         return Builder(
            //           builder: (BuildContext context) => Image.network(
            //             i,
            //             fit: BoxFit.cover,
            //             height: 200,
            //           ),
            //         );
            //       },
            //     ).toList(),
            //     options: CarouselOptions(
            //       enlargeCenterPage: true,
            //       viewportFraction: 1,
            //       height: 200,
            //     ),
            //   ),
            // ),
            Container(child: CarouselWidget(imgUrls: product.images)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, //Color.fromARGB(255, 175, 217, 252),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      product.productName,
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Description",
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: product.highlightedDescription,
                              style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontWeight: FontWeight.bold))
                        ],
                        text: product.description,
                        style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                            wordSpacing: 2,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Category  :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(product.categoryName,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Min Kg  :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(product.minKg.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Max KG  :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(product.maxKg.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Max KG Limit Per Day  :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(product.maxKgLimitPerDay.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Is Having Stock :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  product.isHavingStock == false ? 'NO' : 'Yes',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Discount:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  '${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Price  :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: [
                                Text(
                                  "₹",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(product.pricePerKg.toString(),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 131, 130, 130),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_note_outlined,
                              size: 14,
                            ),
                            label: Text(
                              'Edit ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 188, 55, 211),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () {},
                            icon: Icon(
                              Icons.discount_outlined,
                              size: 14,
                            ),
                            label: Text(
                              'Add Discount',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
