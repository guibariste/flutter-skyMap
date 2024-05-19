// // import 'package:flutter/material.dart';

// // class GridPainter extends CustomPainter {
// //   final double azimuth;
// //   final double screendwith;
// //   final List<Map<String, dynamic>> planetData;
// //   final double altitude;
// //   GridPainter(this.azimuth, this.screendwith, this.planetData, this.altitude);

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final Paint backgroundPaint = Paint() // Ajout du fond noir
// //       ..color = Colors.black; // Couleur noire
// //     final Paint linePaint = Paint()
// //       ..color = Colors.white.withOpacity(0.5)
// //       ..strokeWidth = 1;

// //     final double halfWidth = size.width / 2;
// //     final double lineHeight = size.height;
// //     print(altitude);
// //     final TextStyle textStyle = TextStyle(
// //       color: Colors.white,
// //       fontSize: 12,
// //     );

// //     final TextPainter textPainter = TextPainter(
// //       textAlign: TextAlign.center,
// //       textDirection: TextDirection.ltr,
// //     );
// //     canvas.drawRect(
// //       Rect.fromLTWH(0, 0, size.width, size.height),
// //       backgroundPaint,
// //     );
// //     // Dessiner les lignes de la grille et les textes correspondants
// //     for (int i = 0; i <= 360; i += 10) {
// //       final double xPos = halfWidth +
// //           (azimuth - i) *
// //               (size.width / 50); // 1 degré = la moitié de la largeur de l'écran
// //       final double yPos = lineHeight / 2;

// //       // Dessiner les lignes de la grille
// //       canvas.drawLine(
// //         Offset(xPos, 0),
// //         Offset(xPos, lineHeight),
// //         linePaint,
// //       );
// //       String name = getPlanetNameForAzimuth(azimuth, planetData, i);
// //       final String degreeText = i.toString();

// //       textPainter.text = TextSpan(
// //         text: '$degreeText $name', // Ajout du nom de la planète
// //         style: textStyle,
// //       );
// //       textPainter.layout();
// //       textPainter.paint(
// //         canvas,
// //         Offset(xPos - textPainter.width / 2, yPos - textPainter.height / 2),
// //       );
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return true;
// //   }

// //   String getPlanetNameForAzimuth(
// //       double azimuth, List<Map<String, dynamic>> planetData, int i) {
// //     String planetName = '';
// //     for (var data in planetData) {
// //       double dataAzimuth = data['azimuth'];
// //       if ((dataAzimuth - 5) <= azimuth && azimuth <= (dataAzimuth + 5)) {
// //         planetName = data['name'];
// //         break;
// //       }
// //     }
// //     return planetName;
// //   }
// // }
// import 'package:flutter/material.dart';

// class GridPainter extends CustomPainter {
//   final double azimuth;
//   final double screendwith;
//   final List<Map<String, dynamic>> planetData;
//   final double altitude;

//   GridPainter(this.azimuth, this.screendwith, this.planetData, this.altitude);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint backgroundPaint = Paint()..color = Colors.black;
//     final Paint linePaint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..strokeWidth = 1;

//     final double halfWidth = size.width / 2;
//     final double halfHeight = size.height / 2;
//     final double lineHeight = size.height;

//     final TextStyle textStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 12,
//     );

//     final TextPainter textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       backgroundPaint,
//     );

//     // Dessiner les lignes de la grille et les textes correspondants
//     for (int i = 0; i <= 360; i += 10) {
//       final double xPos = halfWidth + (azimuth - i) * (size.width / 50);
//       final double yPos = lineHeight / 2;

//       // Dessiner les lignes de la grille
//       canvas.drawLine(
//         Offset(xPos, 0),
//         Offset(xPos, lineHeight),
//         linePaint,
//       );

//       String name = getPlanetNameForAzimuth(azimuth, planetData, i);
//       final String degreeText = i.toString();

//       textPainter.text = TextSpan(
//         text: '$degreeText $name',
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(xPos - textPainter.width / 2, yPos - textPainter.height / 2),
//       );
//     }

//     // Dessiner les lignes horizontales correspondant à l'altitude
//     final Paint horizontalLinePaint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..strokeWidth = 1;
//     // String nam = "";
//     for (int i = 0; i <= 100; i += 30) {
//       final double yPos = halfHeight + (altitude - i) * (lineHeight / 100);
//       // if (i == 20) {
//       //   nam = "planete";
//       // }
//       canvas.drawLine(
//         Offset(0, yPos),
//         Offset(size.width, yPos),
//         horizontalLinePaint,
//       );
//       final String degreeText = i.toString();

//       textPainter.text = TextSpan(
//         text: '$degreeText ',
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(altitude - textPainter.width / 2, yPos - textPainter.height / 2),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }

//   String getPlanetNameForAzimuth(
//       double azimuth, List<Map<String, dynamic>> planetData, int i) {
//     String planetName = '';
//     for (var data in planetData) {
//       double dataAzimuth = data['azimuth'];
//       if ((dataAzimuth - 5) <= azimuth && azimuth <= (dataAzimuth + 5)) {
//         planetName = data['name'];
//         break;
//       }
//     }
//     return planetName;
//   }
// }
// import 'package:flutter/material.dart';

// class GridPainter extends CustomPainter {
//   final double azimuth;
//   final double screendwith;
//   final List<Map<String, dynamic>> planetData;
//   final double altitude;

//   GridPainter(this.azimuth, this.screendwith, this.planetData, this.altitude);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint backgroundPaint = Paint()..color = Colors.black;
//     final Paint linePaint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..strokeWidth = 1;

//     final double halfWidth = size.width / 2;
//     final double halfHeight = size.height / 2;
//     final double lineHeight = size.height;

//     final TextStyle textStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 12,
//     );

//     final TextPainter textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       backgroundPaint,
//     );

//     // Dessiner les lignes de la grille et les textes correspondants
//     for (int i = 0; i <= 360; i += 10) {
//       final double xPos = halfWidth + (azimuth - i) * (size.width / 50);
//       final double yPos = lineHeight / 2;

//       // Dessiner les lignes de la grille
//       canvas.drawLine(
//         Offset(xPos, 0),
//         Offset(xPos, lineHeight),
//         linePaint,
//       );

//       String name = getPlanetNameForAzimuth(azimuth, planetData, i);
//       final String degreeText = i.toString();

//       textPainter.text = TextSpan(
//         text: '$degreeText $name',
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(xPos - textPainter.width / 2, yPos - textPainter.height / 2),
//       );
//     }

//     // Dessiner les lignes horizontales correspondant à l'altitude
//     final Paint horizontalLinePaint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..strokeWidth = 1;

//     for (int i = -50; i <= 50; i += 10) {
//       final double yPos = halfHeight - (altitude - i) * (lineHeight / 100);

//       canvas.drawLine(
//         Offset(0, yPos),
//         Offset(size.width, yPos),
//         horizontalLinePaint,
//       );

//       final String degreeText = i.toString();

//       textPainter.text = TextSpan(
//         text: '$degreeText ',
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(size.width / 2 - textPainter.width / 2,
//             yPos - textPainter.height / 2),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }

//   String getPlanetNameForAzimuth(
//       double azimuth, List<Map<String, dynamic>> planetData, int i) {
//     String planetName = '';
//     for (var data in planetData) {
//       double dataAzimuth = data['azimuth'];
//       if ((dataAzimuth - 5) <= azimuth && azimuth <= (dataAzimuth + 5)) {
//         planetName = data['name'];
//         break;
//       }
//     }
//     return planetName;
//   }
// }
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double azimuth;
  final double screendwith;
  final List<Map<String, dynamic>> planetData;
  final double altitude;

  GridPainter(this.azimuth, this.screendwith, this.planetData, this.altitude);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()..color = Colors.black;
    final Paint linePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;
    final double lineHeight = size.height;
    final double lineWidth = size.width;

    final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, lineWidth, lineHeight),
      backgroundPaint,
    );

    // Dessiner les lignes de la grille verticales
    for (int i = 0; i <= 360; i++) {
      final double xPos = halfWidth + (azimuth - i) * (lineWidth / 50);

      canvas.drawLine(
        Offset(xPos, 0),
        Offset(xPos, lineHeight),
        linePaint,
      );

      if (i % 10 == 0) {
        final String degreeText = i.toString();
        textPainter.text = TextSpan(
          text: '$degreeText',
          style: textStyle,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(xPos - textPainter.width / 2, halfHeight - 20),
        );
      }
    }

    // Dessiner les lignes de la grille horizontales
    for (int i = -90; i <= 90; i++) {
      final double yPos = halfHeight - (altitude - i) * (lineHeight / 100);

      canvas.drawLine(
        Offset(0, yPos),
        Offset(lineWidth, yPos),
        linePaint,
      );

      if (i % 10 == 0) {
        final String degreeText = i.toString();
        textPainter.text = TextSpan(
          text: '$degreeText',
          style: textStyle,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
              halfWidth - textPainter.width / 2, yPos - textPainter.height / 2),
        );
      }
    }

    // Dessiner les noms des planètes
    for (var data in planetData) {
      final double dataAzimuth = data['azimuth'];
      final double dataAltitude = data['altitude'];
      final String planetName = data['name'];
      // print(data);
      final double xPos =
          halfWidth + (azimuth - dataAzimuth) * (lineWidth / 50);
      final double yPos =
          halfHeight - (altitude - dataAltitude) * (lineHeight / 100);

      textPainter.text = TextSpan(
        text: planetName,
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xPos - textPainter.width / 2, yPos - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
