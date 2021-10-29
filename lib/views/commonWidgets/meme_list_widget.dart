import 'package:flutter/material.dart';
import 'package:image_flip/arch_utils/ui/size_config.dart';
import 'package:image_flip/models/get_meme_response.dart';

import 'meme_container.dart';

class MemeListWidget extends StatelessWidget {
  MemeListWidget({Key? key, this.onSaveTap, required this.memeList}) : super(key: key);
  final List<Memes> memeList;
  final Function(bool, Memes)? onSaveTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey(key),
      itemCount: memeList.length,
      itemBuilder: (context, index) {
        final meme = memeList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.vdp(), horizontal: 8.hdp()),
          child: MemeContainer(
            meme: meme,
            onSaveTap: (isSaved) {
              if (onSaveTap != null) {
                onSaveTap!(isSaved, meme);
              }
            },
          ),
        );
      },
    );
  }
}
