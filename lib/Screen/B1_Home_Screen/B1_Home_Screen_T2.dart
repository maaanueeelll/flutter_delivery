import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../main.dart';
import '/Library/no_connection.dart';
import '/models/menuModel.dart';
import '/models/productModel.dart';
import '/models/restaurantModel.dart';
import '/constants.dart';
import '/Screen/B1_Home_Screen/Component_Detail_Food/Food_Detail_Screen.dart';
import '/Screen/B3_Menu_Screen/B3_Menus_Screen.dart';

class HomeScreenT2 extends StatefulWidget {
  HomeScreenT2({Key? key}) : super(key: key);

  @override
  _HomeScreenT2State createState() => _HomeScreenT2State();
}

class _HomeScreenT2State extends State<HomeScreenT2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,

              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              //icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      //  Navigator.pushNamed(
      //    context,
      //    '/message',
      //    arguments: MessageArguments(message, true),
      //  );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Future.delayed(const Duration(milliseconds: 500), () {
        return true;
      }),
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 5,
                  centerTitle: true,
                  backgroundColor: Colors.white70,
                  elevation: 1,
                ),
                body: ConnectionNotifierToggler(
                  onConnectionStatusChanged: (connected) {
                    /// that means it is still in the initialization phase.
                    if (connected == null) return;
                  },
                  connected: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 150,
                              child: Image.asset(
                                  'assets/image/wholedata_logo_home.png'),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: FutureBuilder<Restaurant>(
                                    future: fetchRestaurant(http.Client()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Container(
                                          height: 20,
                                          child: const Text(
                                            'errore',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: "Sofia",
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Container(
                                          height: 20,
                                          child: DefaultTextStyle(
                                            style: TextStyle(
                                                color:
                                                    snapshot.data!.activeOrders
                                                        ? Colors.green.shade400
                                                        : Colors.red.shade400,
                                                fontFamily: "Sofia",
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700),
                                            child: AnimatedTextKit(
                                              isRepeatingAnimation: true,
                                              repeatForever: true,
                                              // totalRepeatCount: 8,
                                              animatedTexts: [
                                                RotateAnimatedText(
                                                    snapshot.data!.activeOrders
                                                        ? 'ORDINI ATTIVI'
                                                        : 'NON RICEVE ORDINI',
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Text('');
                                      }
                                    })),
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Text(
                                "Promozioni",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                height: 156,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    alignment: Alignment.topLeft,
                                    fit: BoxFit.fitHeight,
                                    image: Image.asset(
                                      "assets/image/onboard_3.png",
                                      scale: 50,
                                    ).image,
                                  ),
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.amber.shade700.withOpacity(1),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        right: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: const TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: "Sofia",
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w700),
                                              children: [
                                                TextSpan(
                                                  text: "Get Discount of \n",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Sofia",
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "30% \n",
                                                  style: TextStyle(
                                                    fontSize: 43,
                                                    fontFamily: "Sofia",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "at WHOLEDATA on your first order & Instant cashback",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: "Sofia",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "Menù",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Container(
                                height: 160,
                                child: FutureBuilder<List<Menu>>(
                                  future: fetchMenus(http.Client()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      //print('ERRORE $snapshot.error');
                                      return const Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Center(
                                          child: Text(
                                            'An error has occurred!',
                                            style: TextStyle(
                                              fontFamily: "Sofia",
                                              fontSize: 16,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasData) {
                                      return ListView.builder(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        shrinkWrap: true,
                                        primary: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (ctx, index) {
                                          return CardMenu(
                                            menu: snapshot.data![index],
                                          );
                                        },
                                      );
                                    } else {
                                      return const Text('');
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "Popolari",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: FutureBuilder<List<Product>>(
                                future: fetchPopularProducts(http.Client()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Center(
                                        child: Text(
                                          'An error has occurred!',
                                          style: TextStyle(
                                            fontFamily: "Sofia",
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    return ListView.builder(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (ctx, index) {
                                        return CardPopular(
                                            product: snapshot.data![index]);
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  disconnected: const NoConnection(),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber.shade700,
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}

class CardMenu extends StatelessWidget {
  Menu menu;
  CardMenu({
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        bottom: 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MenuFoodList(
                    menu: menu,
                  ),
                ),
              );
            },
            child: Material(
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 8.0, color: Colors.black12)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: 'https://${BASE_URL + menu.imageUrl}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text(
                          'caricamento..',
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400),
                        ),
                        radius: 100,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              menu.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Sofia",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              '${menu.countFood.toString()} prodotti',
              style: const TextStyle(
                  color: Colors.black12,
                  fontFamily: "Sofia",
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

class CardPopular extends StatelessWidget {
  // dinner _dinner;
  final Product product;
  CardPopular({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => FoodDetailT2(
              product: product,
            ),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                color: Colors.black12.withOpacity(0.03),
                spreadRadius: 10.0),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Hero(
                tag: 'hero-tag-${product.id}',
                child: Material(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: CachedNetworkImage(
                      imageUrl: 'https://${BASE_URL + product.imageUrl}',
                      fit: BoxFit.cover,
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text(
                          'caricamento..',
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        radius: 120,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                right: 5.0,
                left: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                    child: Text(
                      product.name,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        product.ingredients,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: buildRating(product.rating.toInt()),
                      ),
                      Text(
                        product.rating > 0.0
                            ? "(" + product.rating.toString() + ")"
                            : "(no rating)",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: "Sofia",
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      '${product.price.toString()} €',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: "Sofia",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Padding(
      //  padding: const EdgeInsets.only(top: 10.0, left: 15.0),
      //  child: Row(
      //    mainAxisAlignment: MainAxisAlignment.start,
      //    crossAxisAlignment: CrossAxisAlignment.start,
      //    children: <Widget>[
      //      Hero(
      //        tag: 'hero-tag-${product.id}',
      //        child: Material(
      //          child: Container(
      //            height: 106.0,
      //            width: 106.0,
      //            decoration: BoxDecoration(
      //              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      //              boxShadow: [
      //                BoxShadow(
      //                    blurRadius: 3.0,
      //                    color: Colors.black12.withOpacity(0.1),
      //                    spreadRadius: 1.0)
      //              ],
      //            ),
      //            child: CachedNetworkImage(
      //              imageUrl: 'https://${BASE_URL + product.imageUrl}',
      //              fit: BoxFit.cover,
      //              placeholder: (context, url) => const CircleAvatar(
      //                backgroundColor: Colors.transparent,
      //                child: Text(
      //                  'caricamento..',
      //                  style: TextStyle(
      //                      fontFamily: "Sofia",
      //                      fontSize: 13,
      //                      color: Colors.black54,
      //                      fontWeight: FontWeight.w400),
      //                ),
      //                radius: 100,
      //              ),
      //              errorWidget: (context, url, error) =>
      //                  const Icon(Icons.error),
      //            ),
      //          ),
      //        ),
      //      ),
      //      Padding(
      //        padding: const EdgeInsets.only(left: 15.0, top: 5.0),
      //        child: Column(
      //          mainAxisAlignment: MainAxisAlignment.start,
      //          crossAxisAlignment: CrossAxisAlignment.start,
      //          children: <Widget>[
      //            Text(
      //              product.name,
      //              style: const TextStyle(
      //                  fontFamily: "Sofia",
      //                  fontWeight: FontWeight.w600,
      //                  fontSize: 16.0,
      //                  color: Colors.black87),
      //            ),
      //            const SizedBox(
      //              height: 2.0,
      //            ),
      //            Row(
      //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //              crossAxisAlignment: CrossAxisAlignment.center,
      //              children: <Widget>[
      //                const Icon(
      //                  Icons.star,
      //                  size: 18.0,
      //                  color: Colors.yellow,
      //                ),
      //                Padding(
      //                  padding: const EdgeInsets.only(top: 3.0),
      //                  child: Text(
      //                    product.rating.toString(),
      //                    style: const TextStyle(
      //                        fontWeight: FontWeight.w700,
      //                        fontFamily: "Sofia",
      //                        fontSize: 13.0),
      //                  ),
      //                ),
      //              ],
      //            )
      //          ],
      //        ),
      //      ),
      //    ],
      //  ),
      //),
    );
  }

  List<Widget> buildRating(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < rating; i++) {
      stars.add(
        const Icon(
          Icons.star,
          size: 18.0,
          color: Colors.yellow,
        ),
      );
    }
    return stars;
  }
}
