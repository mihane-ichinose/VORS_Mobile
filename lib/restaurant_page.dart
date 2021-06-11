import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  Future<bool> _goToUser(BuildContext context) {
    return Navigator.of(context)
        .pushNamed('/user')
    // We want to pop the user profile here.
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura.bold',
    color: Colors.white,
    fontSize: 26,
  );

  // final routeObserver = TransitionRouteObserver<PageRoute?>();
  // static const headerAniInterval = Interval(.1, .3, curve: Curves.easeOut);
  // late Animation<double> _headerScaleAnimation;
  // AnimationController? _loadingController;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _loadingController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 1250),
  //   );
  //
  //   _headerScaleAnimation =
  //       Tween<double>(begin: .6, end: 1).animate(CurvedAnimation(
  //         parent: _loadingController!,
  //         curve: headerAniInterval,
  //       ));
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   routeObserver.subscribe(
  //       this, ModalRoute.of(context) as PageRoute<dynamic>?);
  // }

  // @override
  // void dispose() {
  //   routeObserver.unsubscribe(this);
  //   _loadingController!.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didPushAfterTransition() => _loadingController!.forward();

  AppBar _buildAppBar() {

    final userBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.user),
      color: Colors.black,
      tooltip: "User Profile",
      onPressed: () => _goToUser(context),
    );

    final searchField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Search...",
        hintStyle: TextStyle(
          fontFamily: 'Futura',
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
      ),
    );

    return AppBar(
      backgroundColor: Color(0xFF17B2E0),
      title: searchField,
      actions: <Widget>[
        userBtn,
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildHeader() {
  //   final primaryColor = Colors.purple;
  //       //Colors.primaries.where((c) => c == theme.primaryColor).first;
  //   final linearGradient = LinearGradient(colors: [
  //     primaryColor[800]!,
  //     primaryColor[200]!,
  //   ]).createShader(Rect.fromLTWH(0.0, 0.0, 418.0, 78.0));
  //
  //   return ScaleTransition(
  //     scale: _headerScaleAnimation,
  //     child: FadeIn(
  //       controller: _loadingController,
  //       curve: headerAniInterval,
  //       fadeDirection: FadeDirection.bottomToTop,
  //       offset: .5,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 '\$',
  //                 style: theme.textTheme.headline3!.copyWith(
  //                   fontWeight: FontWeight.w300,
  //                   color: Colors.purple,
  //                 ),
  //               ),
  //               SizedBox(width: 5),
  //               AnimatedNumericText(
  //                 initialValue: 14,
  //                 targetValue: 3467.87,
  //                 curve: Interval(0, .5, curve: Curves.easeOut),
  //                 controller: _loadingController!,
  //                 style: theme.textTheme.headline3!.copyWith(
  //                   foreground: Paint()..shader = linearGradient,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Text('Account Balance', style: theme.textTheme.caption),
  //         ],
  //       ),
  //     ),
  //   );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildHeader(),
    );
  }
}