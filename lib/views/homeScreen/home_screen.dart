import 'package:flutter/material.dart';
import 'package:image_flip/arch_utils/ui/responsize_builder.dart';
import 'package:image_flip/arch_utils/ui/size_config.dart';
import 'package:image_flip/controllers/meme_controller.dart';
import 'package:image_flip/styles/app_theme.dart';
import 'package:image_flip/views/commonWidgets/meme_list_widget.dart';
import 'package:provider/provider.dart';

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
            onTap: (index) {
              if (index == 1) {
                context.read<MemeController>().getSavedMemes();
              }
            },
            tabs: const [
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
                  Consumer<MemeController>(
                    builder: (context, controller, child) {
                      if (controller.showLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!controller.hasError && controller.memeResponseModel != null) {
                          final memeList = controller.memeResponseModel!.data.memes;
                          return MemeListWidget(
                            key: const Key("Tab1"),
                            memeList: memeList,
                            onSaveTap: (isSaved, meme) {
                              if (isSaved) {
                                controller.removeMeme(meme);
                              } else {
                                controller.saveMeme(meme);
                              }
                            },
                          );
                        }
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(controller.errorMessage,
                                  textAlign: TextAlign.center, style: AppTheme.textTheme.bodyText1),
                              OutlinedButton(
                                onPressed: () {
                                  controller.getMemes();
                                },
                                child:
                                    Text("Retry ?", textAlign: TextAlign.center, style: AppTheme.textTheme.bodyText1),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),

                  //Saved Memes
                  Consumer<MemeController>(
                    builder: (context, controller, child) {
                      if (controller.savedMemesList.isNotEmpty) {
                        return MemeListWidget(
                          key: const Key("Tab2"),
                          memeList: controller.savedMemesList,
                          onSaveTap: (isSaved, meme) {
                            if (isSaved) {
                              controller.removeMeme(meme);
                            } else {
                              controller.saveMeme(meme);
                            }
                          },
                        );
                      }
                      return Center(child: Text("No saved Memes", style: AppTheme.textTheme.bodyText1));
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
