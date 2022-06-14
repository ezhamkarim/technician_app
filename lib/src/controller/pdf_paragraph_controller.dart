import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:technician_app/src/controller/pdf_controller.dart';

import '../model/booking_model.dart';
import '../model/service_model.dart';

class PdfParagraphController {
  static List<Widget> buildBulletService(List<Service> services) {
    List<Widget> wijet = [];
    for (var element in services) {
      wijet.add(Bullet(text: element.name));
    }
    return wijet;
  }

  static Future<File> generate(
      String headerTitle, List<Booking> booking) async {
    final pdf = Document();

    // final customFont =
    //     Font.ttf(await rootBundle.load('assets/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildCustomHeader(headerTitle),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          // Paragraph(
          //   text:
          //       'This is my custom font that displays also characters such as €, Ł, ...',
          //   style: TextStyle(font: customFont, fontSize: 20),
          // ),
          // buildCustomHeadline(),
          // buildLink(),
          // ...booking.map((e) => buildBulletPoints(booking)),
          ...buildBulletPoints(booking),
          // Header(child: Text('My Headline')),
          // Paragraph(text: LoremText().paragraph(60)),
          // Paragraph(text: LoremText().paragraph(60)),
          // Paragraph(text: LoremText().paragraph(60)),
          // Paragraph(text: LoremText().paragraph(60)),
          // Paragraph(text: LoremText().paragraph(60)),
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: const TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );
    return PdfController.saveDocument(name: '$headerTitle.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader(String headerTitle) => Container(
        padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.purple)),
        ),
        child: Row(
          children: [
            Text(
              headerTitle,
              style: const TextStyle(fontSize: 20, color: PdfColors.purple),
            ),
          ],
        ),
      );
  static Widget buildCustomHeader2(String headerTitle, int index) => Container(
        padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        child: Row(
          children: [
            Text(
              index.toString(),
              style: const TextStyle(fontSize: 20, color: PdfColors.black),
            ),
            SizedBox(width: 3 * PdfPageFormat.mm),
            Text(
              headerTitle,
              style: const TextStyle(fontSize: 20, color: PdfColors.black),
            ),
          ],
        ),
      );
  static Widget buildCustomHeaderService(
          String headerTitle, List<Service> service) =>
      Container(
        padding: const EdgeInsets.only(bottom: 10 * PdfPageFormat.mm),
        child: Column(
          children: [
            Row(children: [
              SizedBox(width: 3 * PdfPageFormat.mm),
              Text(
                headerTitle,
                style: const TextStyle(fontSize: 16, color: PdfColors.black),
              ),
            ]),
            ...buildBulletService(service)
          ],
        ),
      );
  static Widget buildTotal(String headerTitle, double total) => Container(
        padding: const EdgeInsets.only(bottom: 10 * PdfPageFormat.mm),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                headerTitle,
                style: const TextStyle(fontSize: 16, color: PdfColors.black),
              ),
              Text(
                'RM ${total.toString()}',
                style: const TextStyle(fontSize: 16, color: PdfColors.black),
              ),
            ]),
          ],
        ),
      );
  static Widget buildCustomHeadline() {
    return Header(
        padding: const EdgeInsets.all(4),
        child: Row(children: [
          Text(
            'My Third Headline',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
        ]
            // decoration: const BoxDecoration(color: PdfColors.red),
            ));
  }

  static Widget buildLink() => UrlLink(
        destination: 'https://flutter.dev',
        child: Text(
          'Go to flutter.dev',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          ),
        ),
      );

  static List<Widget> buildBulletPoints(List<Booking> booking) {
    List<Widget> wijet = [];
    double total = 0;
    for (var i = 0; i < booking.length; i++) {
      wijet.add(buildCustomHeader2(booking[i].id, i + 1));
      wijet.add(buildCustomHeaderService('Service', booking[i].services));
      wijet.add(buildTotal('Total', booking[i].total));
      // wijet.add(Bullet(text: booking[i].id));
      total = total + booking[i].total;
    }
    wijet.add(buildTotal('General Total', total));
    return wijet;
  }
}
