import 'package:flutter/cupertino.dart';
import 'package:image_flip/arch_utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_flip/models/get_meme_response.dart';
import 'package:image_flip/styles/app_theme.dart';

class MemeContainer extends StatelessWidget {
  MemeContainer({Key? key, this.onSaveTap, required this.meme, this.isSaved = false}) : super(key: key);
  final Memes meme;
  final Function(bool)? onSaveTap;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final checkAspectRatio = constraints.maxWidth < meme.width;
          double containerHeight = meme.height.toDouble();
          //This is only for the cases where the width of the image is more than the available width of the screen.
          if (checkAspectRatio) {
            final aspectRatio = meme.width / meme.height;
            containerHeight = constraints.maxWidth / aspectRatio;
          }
          return SizedBox(
            width: double.infinity,
            height: containerHeight,
            child: Stack(
              children: [
                Center(child: Image.network(meme.url)),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.grey.shade500.withOpacity(0.5),
                      ],
                      stops: const [
                        0.5,
                        1,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16.vdp()),
                      child: Text(
                        meme.name,
                        style: AppTheme.textTheme.bodyText1.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SaveIcon(onSaveTap: onSaveTap, isSaved: isSaved),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class SaveIcon extends StatefulWidget {
  const SaveIcon({
    Key? key,
    this.onSaveTap,
    required this.isSaved,
  }) : super(key: key);

  final Function(bool)? onSaveTap;
  final bool isSaved;

  @override
  State<SaveIcon> createState() => _SaveIconState();
}

class _SaveIconState extends State<SaveIcon> {
  bool isSaved = false;

  @override
  void initState() {
    isSaved = widget.isSaved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.onSaveTap != null) {
          widget.onSaveTap!(isSaved);
        }
        setState(() {
          isSaved = !isSaved;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
