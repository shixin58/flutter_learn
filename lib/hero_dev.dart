import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

class Photo extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double? width;

  const Photo({
    Key? key,
    required this.photo,
    required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(builder: (context, size) {
          return Image.network(
            photo,
            fit: BoxFit.fill,
          );
        }),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final dynamic clipRectSize;
  final Widget child;

  const RadialExpansion({
    Key? key,
    required this.maxRadius,
    required this.child,
  }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2,
                height: kMaxRadius * 2,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName, 
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16.0,)
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildHero(BuildContext context, String imageName, String description) {
    return SizedBox(
      width: kMinRadius,
      height: kMinRadius,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder<void>(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child){
                    return Opacity(
                      opacity: opacityCurve.transform(animation.value),
                      child: _buildPage(context, imageName, description),
                    );
                  },
                );
              }));
            },
          ),
        ),
      ),
    );
  }

  const RadialExpansionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Transition Demo'),),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif', 'Dash Fainting'),
            _buildHero(context, 'https://picsum.photos/250?image=9', 'Note Book'),
            _buildHero(context, 'http://www.devio.org/img/avatar.png', 'Avatar'),
          ],
        ),
      )
    );
  }
}
