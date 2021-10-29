import 'package:flutter/material.dart';
import 'package:image_flip/arch_utils/ui/responsize_builder.dart';
import 'package:image_flip/arch_utils/ui/size_config.dart';
import 'package:image_flip/arch_utils/widgets/responsive_safe_area.dart';
import 'package:image_flip/styles/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:image_flip/controllers/meme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _usableHeight = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<MemeController>().getMemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GeeksForGeeks"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Memes",
              ),
              Tab(
                text: "Saved Memes",
              ),
            ],
          ),
        ),
        body: ResponsiveBuilder(builder: (context, size) {
          if (_usableHeight < size.localWidgetSize.height) {
            _usableHeight = size.localWidgetSize.height;
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: _usableHeight,
              child: TabBarView(
                children: [
                  //Memes from the API
                  Container(),

                  //Saved Memes
                  Container(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
