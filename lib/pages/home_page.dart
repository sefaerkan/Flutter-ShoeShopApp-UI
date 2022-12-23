import 'package:flutter/material.dart';
import 'package:shoeshop/core/const.dart';
import 'package:shoeshop/core/flutter_icons.dart';
import 'package:shoeshop/models/shoe_model.dart';
import 'package:shoeshop/pages/detail_page.dart';
import 'package:shoeshop/widgets/app_clipper.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShoeModel> shoeModel = ShoeModel.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          FlutterIcons.menu,
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    FlutterIcons.search,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              itemCount: shoeModel.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailPage(shoeModel[index]),
                        ),
                    );
                  },
                  child: Container(
                    width: 230,
                    margin: EdgeInsets.only(right: 16),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: _buildBackground(index, 230),
                        ),
                        Positioned(
                          bottom: 130,
                          right: 10,
                          child: Hero(
                            tag: "hero${shoeModel[index].imgPath}",
                            child: Transform.rotate(
                              angle: -math.pi / 7,
                              child: Image(
                                image: AssetImage(
                                "assets/${shoeModel[index].imgPath}"
                              ),
                                width: 220,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "JUST FOR YOU",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "VIEW ALL",
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          ...shoeModel.map((data) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailPage(data),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/${data.imgPath}"),
                      height: 60,
                      width: 100,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * .4,
                            child: Text(
                              "${data.name}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "${data.brand}",
                            style: TextStyle(
                              color: Colors.black26,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "\$${data.price.toInt()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.greenColor,
          unselectedItemColor: Colors.black26,
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(FlutterIcons.compass),
              ),
              label: "data",
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIcons.list),
              label: "data",
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIcons.bag),
              label: "data",
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIcons.person_outline),
              label: "data",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(int index, double width) {
    return ClipPath(
      clipper: AppClipper(
        cornerSize: 25,
        diagonalHeight: 180,
      ),
      child: Container(
        color: shoeModel[index].color,
        width: width,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Icon(
                      shoeModel[index].brand == "Nike"
                          ? FlutterIcons.nike
                          : FlutterIcons.converse,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    width: 125,
                    child: Text(
                      '${shoeModel[index].name}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${shoeModel[index].price}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    FlutterIcons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
