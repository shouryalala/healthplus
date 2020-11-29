import 'dart:math' as math;
import 'dart:ui' as ui show Gradient, TextBox, lerpDouble, Image;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthplus/logger.dart';


/// Possible ways to draw Flutter's logo.
enum LogoStyle {
  /// Show only Flutter's logo, not the "Flutter" label.
  ///
  /// This is the default behavior for [LogoDecoration] objects.
  markOnly,

  /// Show Flutter's logo on the left, and the "Flutter" label to its right.
  horizontal,

  /// Show Flutter's logo above the "Flutter" label.
  stacked,
}

/// An immutable description of how to paint Flutter's logo.
class LogoDecoration extends Decoration {
  /// Creates a decoration that knows how to paint Flutter's logo.
  ///
  /// The [lightColor] and [darkColor] are used to fill the logo. The [style]
  /// controls whether and where to draw the "Flutter" label. If one is shown,
  /// the [textColor] controls the color of the label.
  ///
  /// The [lightColor], [darkColor], [textColor], [style], and [margin]
  /// arguments must not be null.
  const LogoDecoration({
    this.lightColor = const Color(0xFF42A5F5), // Colors.blue[400]
    this.darkColor = const Color(0xFF0D47A1), // Colors.blue[900]
    this.textColor = const Color(0xFF616161),
    this.style = LogoStyle.markOnly,
    this.margin = EdgeInsets.zero,
    this.logo = null,
  }) : assert(lightColor != null),
       assert(darkColor != null),
       assert(textColor != null),
       assert(style != null),
       assert(margin != null),
       assert(logo != null),
       _position = identical(style, LogoStyle.markOnly) ? 0.0 : identical(style, LogoStyle.horizontal) ? 1.0 : -1.0,
       // (see https://github.com/dart-lang/sdk/issues/26980 for details about that ignore statement)
       _opacity = 1.0;

  const LogoDecoration._(this.lightColor, this.darkColor, this.textColor, this.style, this.margin, this._position, this._opacity, this.logo);

  /// The lighter of the two colors used to paint the logo.
  ///
  /// If possible, the default should be used. It corresponds to the 400 and 900
  /// values of [material.Colors.blue] from the Material library.
  ///
  /// If for some reason that color scheme is impractical, the same entries from
  /// [material.Colors.amber], [material.Colors.red], or
  /// [material.Colors.indigo] colors can be used. These are Flutter's secondary
  /// colors.
  ///
  /// In extreme cases where none of those four color schemes will work,
  /// [material.Colors.pink], [material.Colors.purple], or
  /// [material.Colors.cyan] can be used. These are Flutter's tertiary colors.
  final Color lightColor;

  /// The darker of the two colors used to paint the logo.
  ///
  /// See [lightColor] for more information about selecting the logo's colors.
  final Color darkColor;

  /// The color used to paint the "Flutter" text on the logo, if [style] is
  /// [LogoStyle.horizontal] or [LogoStyle.stacked]. The
  /// appropriate color is `const Color(0xFF616161)` (a medium gray), against a
  /// white background.
  final Color textColor;

  /// Whether and where to draw the "Flutter" text. By default, only the logo
  /// itself is drawn.
  // This property isn't actually used when painting. It's only really used to
  // set the internal _position property.
  final LogoStyle style;

  /// How far to inset the logo from the edge of the container.
  final EdgeInsets margin;

  final ui.Image logo;

  // The following are set when lerping, to represent states that can't be
  // represented by the constructor.
  final double _position; // -1.0 for stacked, 1.0 for horizontal, 0.0 for no logo
  final double _opacity; // 0.0 .. 1.0

  bool get _inTransition => _opacity != 1.0 || (_position != -1.0 && _position != 0.0 && _position != 1.0);

  @override
  bool debugAssertIsValid() {
    assert(lightColor != null
        && darkColor != null
        && textColor != null
        && style != null
        && margin != null
        && _position != null
        && _position.isFinite
        && _opacity != null
        && _opacity >= 0.0
        && _opacity <= 1.0);
    return true;
  }

  @override
  bool get isComplex => !_inTransition;

  /// Linearly interpolate between two Flutter logo descriptions.
  ///
  /// Interpolates both the color and the style in a continuous fashion.
  ///
  /// If both values are null, this returns null. Otherwise, it returns a
  /// non-null value. If one of the values is null, then the result is obtained
  /// by scaling the other value's opacity and [margin].
  ///
  /// {@macro dart.ui.shadow.lerp}
  ///
  /// See also:
  ///
  ///  * [Decoration.lerp], which interpolates between arbitrary decorations.
  static LogoDecoration lerp(LogoDecoration a, LogoDecoration b, double t) {
    assert(t != null);
    assert(a == null || a.debugAssertIsValid());
    assert(b == null || b.debugAssertIsValid());
    if (a == null && b == null)
      return null;
    if (a == null) {
      return LogoDecoration._(
        b.lightColor,
        b.darkColor,
        b.textColor,
        b.style,
        b.margin * t,
        b._position,
        b._opacity * t.clamp(0.0, 1.0),
        b.logo,
      );
    }
    if (b == null) {
      return LogoDecoration._(
        a.lightColor,
        a.darkColor,
        a.textColor,
        a.style,
        a.margin * t,
        a._position,
        a._opacity * (1.0 - t).clamp(0.0, 1.0),
        a.logo,
      );
    }
    if (t == 0.0)
      return a;
    if (t == 1.0)
      return b;
    return LogoDecoration._(
      Color.lerp(a.lightColor, b.lightColor, t),
      Color.lerp(a.darkColor, b.darkColor, t),
      Color.lerp(a.textColor, b.textColor, t),
      t < 0.5 ? a.style : b.style,
      EdgeInsets.lerp(a.margin, b.margin, t),
      a._position + (b._position - a._position) * t,
      (a._opacity + (b._opacity - a._opacity) * t).clamp(0.0, 1.0),
      a.logo,
    );
  }

  @override
  LogoDecoration lerpFrom(Decoration a, double t) {
    assert(debugAssertIsValid());
    if (a == null || a is LogoDecoration) {
      assert(a == null || a.debugAssertIsValid());
      return LogoDecoration.lerp(a, this, t);
    }
    return super.lerpFrom(a, t);
  }

  @override
  LogoDecoration lerpTo(Decoration b, double t) {
    assert(debugAssertIsValid());
    if (b == null || b is LogoDecoration) {
      assert(b == null || b.debugAssertIsValid());
      return LogoDecoration.lerp(this, b, t);
    }
    return super.lerpTo(b, t);
  }

  @override
  // TODO(ianh): better hit testing
  bool hitTest(Size size, Offset position, { TextDirection textDirection }) => true;

  @override
  BoxPainter createBoxPainter([ VoidCallback onChanged ]) {
    assert(debugAssertIsValid());
    return _LogoPainter(this);
  }

  @override
  bool operator ==(dynamic other) {
    assert(debugAssertIsValid());
    if (identical(this, other))
      return true;
    if (other is! LogoDecoration)
      return false;
    final LogoDecoration typedOther = other;
    return lightColor == typedOther.lightColor
        && darkColor == typedOther.darkColor
        && textColor == typedOther.textColor
        && _position == typedOther._position
        && _opacity == typedOther._opacity;
  }

  @override
  int get hashCode {
    assert(debugAssertIsValid());
    return hashValues(
      lightColor,
      darkColor,
      textColor,
      _position,
      _opacity,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsNode.message('$lightColor/$darkColor on $textColor'));
    properties.add(EnumProperty<LogoStyle>('style', style));
    if (_inTransition)
      properties.add(DiagnosticsNode.message('transition ${debugFormatDouble(_position)}:${debugFormatDouble(_opacity)}'));
  }
}


/// An object that paints a [BoxDecoration] into a canvas.
class _LogoPainter extends BoxPainter {
  Log log = new Log('LogoPainter');
  _LogoPainter(this._config)
      : assert(_config != null),
        assert(_config.debugAssertIsValid()),
        super(null) {
    _prepareText();
    //_prepareLogo();
  }

  final LogoDecoration _config;

  // these are configured assuming a font size of 100.0.
  TextPainter _textPainter;
  DecorationImagePainter _logoImage;
  ui.Image _logoUiImage;
  Rect _textBoundingRect;

  void _prepareText() {
    const String kLabel = 'HEALTH PLUS';//Constants.APP_NAME;
    _textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: kLabel,
            style: TextStyle(
              color: _config.textColor,
              fontFamily: 'Roboto',
              fontSize: 110.0, // 247 is the height of the F when the fontSize is 350, assuming device pixel ratio 1.0
//          fontSize: 100.0 * 50.0 / 247.0, // 247 is the height of the F when the fontSize is 350, assuming device pixel ratio 1.0
              fontWeight: FontWeight.w600,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          TextSpan(
            text: '\nby Suraaj Ray Lala',
            style: TextStyle(
              color: _config.textColor,
              fontFamily: 'Roboto',
              fontSize: 60.0, // 247 is the height of the F when the fontSize is 350, assuming device pixel ratio 1.0
//          fontSize: 100.0 * 50.0 / 247.0, // 247 is the height of the F when the fontSize is 350, assuming device pixel ratio 1.0
              fontWeight: FontWeight.w600,
              textBaseline: TextBaseline.alphabetic,
            ),
          )
        ],
      ),
      textDirection: TextDirection.ltr,textAlign: TextAlign.center
    );
    _textPainter.layout();
    final ui.TextBox textSize = _textPainter.getBoxesForSelection(const TextSelection(baseOffset: 0, extentOffset: kLabel.length)).single;
    _textBoundingRect = Rect.fromLTRB(textSize.left, textSize.top, textSize.right, textSize.bottom);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    offset += _config.margin.topLeft;
    final Size canvasSize = _config.margin.deflateSize(configuration.size);
    if (canvasSize.isEmpty)
      return;
    Size logoSize;
    if (_config._position > 0.0) {
      // horizontal style
      logoSize = const Size(820.0, 232.0);
    } else if (_config._position < 0.0) {
      // stacked style
      logoSize = const Size(252.0, 306.0);
    } else {
      // only the mark
      logoSize = const Size(202.0, 202.0);
    }
    final FittedSizes fittedSize = applyBoxFit(BoxFit.contain, logoSize, canvasSize);
    assert(fittedSize.source == logoSize);
    final Rect rect = Alignment.center.inscribe(fittedSize.destination, offset & canvasSize);
    final double centerSquareHeight = canvasSize.shortestSide;
    final Rect centerSquare = Rect.fromLTWH(
      offset.dx + (canvasSize.width - centerSquareHeight) / 2.0,
      offset.dy + (canvasSize.height - centerSquareHeight) / 2.0,
      centerSquareHeight,
      centerSquareHeight,
    );

    Rect logoTargetSquare;
    if (_config._position > 0.0) {
      // horizontal style
      logoTargetSquare = Rect.fromLTWH(rect.left, rect.top, rect.height, rect.height);
    } else if (_config._position < 0.0) {
      // stacked style
      final double logoHeight = rect.height * 191.0 / 306.0;
      logoTargetSquare = Rect.fromLTWH(
        rect.left + (rect.width - logoHeight) / 2.0,
        rect.top,
        logoHeight,
        logoHeight,
      );
    } else {
      // only the mark
      logoTargetSquare = centerSquare;
    }
    final Rect logoSquare = Rect.lerp(centerSquare, logoTargetSquare, _config._position.abs());

    if (_config._opacity < 1.0) {
      canvas.saveLayer(
        offset & canvasSize,
        Paint()
          ..colorFilter = ColorFilter.mode(
            const Color(0xFFFFFFFF).withOpacity(_config._opacity),
            BlendMode.modulate,
          ),
      );
    }
    if (_config._position != 0.0) {
      if (_config._position > 0.0) {
        // horizontal style
        final double fontSize = 2.0 / 3.0 * logoSquare.height * (1 - (10.4 * 2.0) / 202.0);
        final double scale = fontSize / 100.0;
        final double finalLeftTextPosition = // position of text in rest position
          (256.4 / 820.0) * rect.width - // 256.4 is the distance from the left edge to the left of the F when the whole logo is 820.0 wide
          (32.0 / 350.0) * fontSize; // 32 is the distance from the text bounding box edge to the left edge of the F when the font size is 350
        final double initialLeftTextPosition = // position of text when just starting the animation
          rect.width / 2.0 - _textBoundingRect.width * scale;
        final Offset textOffset = Offset(
          rect.left + ui.lerpDouble(initialLeftTextPosition, finalLeftTextPosition, _config._position),
          rect.top + (rect.height - _textBoundingRect.height * scale) / 2.0,
        );
        canvas.save();
        if (_config._position < 1.0) {
          final Offset center = logoSquare.center;
          final Path path = Path()
            ..moveTo(center.dx, center.dy)
            ..lineTo(center.dx + rect.width, center.dy - rect.width)
            ..lineTo(center.dx + rect.width, center.dy + rect.width)
            ..close();
          canvas.clipPath(path);
        }
        canvas.translate(textOffset.dx, textOffset.dy);
        canvas.scale(scale, scale);
        _textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      } else if (_config._position < 0.0) {
        // stacked style
        final double fontSize = 0.35 * logoTargetSquare.height * (1 - (10.4 * 2.0) / 202.0);
        final double scale = fontSize / 100.0;
        if (_config._position > -1.0) {
          // This limits what the drawRect call below is going to blend with.
          canvas.saveLayer(_textBoundingRect, Paint());
        } else {
          canvas.save();
        }
        canvas.translate(
          logoTargetSquare.center.dx - (_textBoundingRect.width * scale / 2.0),
          logoTargetSquare.bottom,
        );
        canvas.scale(scale, scale);
        _textPainter.paint(canvas, Offset.zero);
        if (_config._position > -1.0) {
          canvas.drawRect(_textBoundingRect.inflate(_textBoundingRect.width * 0.5), Paint()
            ..blendMode = BlendMode.modulate
            ..shader = ui.Gradient.linear(
              Offset(_textBoundingRect.width * -0.5, 0.0),
              Offset(_textBoundingRect.width * 1.5, 0.0),
              <Color>[const Color(0xFFFFFFFF), const Color(0xFFFFFFFF), const Color(0x00FFFFFF), const Color(0x00FFFFFF)],
              <double>[ 0.0, math.max(0.0, _config._position.abs() - 0.1), math.min(_config._position.abs() + 0.1, 1.0), 1.0 ],
            ),
          );
        }
        canvas.restore();
      }
    }
    if(_config.logo != null)paintImage(canvas: canvas, rect: logoSquare, image: _config.logo);
    if (_config._opacity < 1.0)
      canvas.restore();
  }
}
