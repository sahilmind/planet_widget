part of planet_widget;

class DrawCirclePainter extends CustomPainter {

  static late ui.Size paintSize;

  final BuildContext context;
  final VoidCallback onDrawCompleteCallback;

  late PlanetWidgetModel _planetWidgetModel;

  DrawCirclePainter({
    required this.context,
    required this.onDrawCompleteCallback,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _planetWidgetModel = PlanetWidgetModel.of(context);
    drawCircles(canvas, size);
  }

  drawCircles(Canvas canvas, Size size) {
    paintSize = size;
    _radius = (size.width < size.height) ? (size.width / 2) : (size.height / 2);
    if (_planetWidgetModel.visibleFirstCircle) {
      createFirstCircle(
        canvas: canvas,
        size: size,
      );
    }
    if (_planetWidgetModel.visibleSecondCircle) {
      createSecondCircle(
        canvas: canvas,
        size: size,
      );
    }
    if (_planetWidgetModel.visibleThirdCircle) {
      createThirdCircle(
        canvas: canvas,
        size: size,
      );
    }
    onDrawCompleteCallback.call();
  }

  createFirstCircle({
    required Canvas canvas,
    required Size size,
  }) async {
    _firstRadius = _radius - _planetWidgetModel.firstCircleRadius;
    createCircle(
      canvas: canvas,
      size: size,
      radius: _firstRadius,
      paint: getPaint(
        color: (_planetWidgetModel.firstCircleStrokeColor != null)
            ? _planetWidgetModel.firstCircleStrokeColor!
            : _planetWidgetModel.allCircleStrokeColor,
        strokeWidth: (_planetWidgetModel.firstCircleStrokeWidth != -1)
            ? _planetWidgetModel.firstCircleStrokeWidth
            : _planetWidgetModel.allCircleStrokeWidth,
      ),
    );
  }

  createSecondCircle({
    required Canvas canvas,
    required Size size,
  }) async {
    _secondRadius = _firstRadius - _planetWidgetModel.secondCircleRadius;
    createCircle(
      canvas: canvas,
      size: size,
      radius: _secondRadius,
      paint: getPaint(
        color: (_planetWidgetModel.secondCircleStrokeColor != null)
            ? _planetWidgetModel.secondCircleStrokeColor!
            : _planetWidgetModel.allCircleStrokeColor,
        strokeWidth: (_planetWidgetModel.secondCircleStrokeWidth != -1)
            ? _planetWidgetModel.secondCircleStrokeWidth
            : _planetWidgetModel.allCircleStrokeWidth,
      ),
    );
  }

  void createThirdCircle({
    required Canvas canvas,
    required Size size,
  }) {
    _thirdRadius = _secondRadius - _planetWidgetModel.thirdCircleRadius;
    createCircle(
      canvas: canvas,
      size: size,
      radius: _thirdRadius,
      paint: getPaint(
        color: (_planetWidgetModel.thirdCircleStrokeColor != null)
            ? _planetWidgetModel.thirdCircleStrokeColor!
            : _planetWidgetModel.allCircleStrokeColor,
        strokeWidth: (_planetWidgetModel.thirdCircleStrokeWidth != -1)
            ? _planetWidgetModel.thirdCircleStrokeWidth
            : _planetWidgetModel.allCircleStrokeWidth,
      ),
    );
  }

  Rect createCircle(
      {required Canvas canvas,
      required Size size,
      required double radius,
      required Paint paint}) {
    // Using drawCircle
    _circleCenter = Offset(size.width / 2, size.height / 2);
    var path = Path();
    path.addOval(
      Rect.fromCircle(center: _circleCenter, radius: radius),
    );
    canvas.drawPath(path, paint);
    return path.getBounds();
  }

  Paint getPaint({required Color color, required double strokeWidth}) {
    return Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
