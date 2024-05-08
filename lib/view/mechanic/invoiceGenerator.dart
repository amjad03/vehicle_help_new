import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:pdf/widgets.dart';

class InvoiceGeneratorScreen extends StatefulWidget {
  @override
  _InvoiceGeneratorScreenState createState() => _InvoiceGeneratorScreenState();
}

class _InvoiceGeneratorScreenState extends State<InvoiceGeneratorScreen> {
  final TextEditingController _customerNameController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final List<Item> _items = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _customerNameController,
                  decoration: InputDecoration(labelText: 'Customer Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter customer name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: itemController,
                  decoration: InputDecoration(
                    hintText: 'Particulars',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.inventory_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.inventory_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                // ElevatedButton(
                //   onPressed: _addItem(itemController.text.toString(), double.parse(priceController.text)),
                //   child: Text('Add Item'),
                // ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => _addItem(itemController.text.toString(), priceController.text),
                    child: Text('Add Item'),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_items[index].name),
                      subtitle: Text('₹${_items[index].price.toStringAsFixed(2)}'),
                    );
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _generateInvoice,
                    child: Text('Generate Invoice'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _addItem(String item, double price) {
  //   setState(() {
  //     _items.add(Item(name: '$item', price: price));
  //   });
  // }

  void _addItem(String item, String price) {
    if (item.isNotEmpty && double.tryParse(price) != null) {
      setState(() {
        _items.add(Item(name: item, price: double.parse(price)));
        itemController.clear();
        priceController.clear();
      });
    } else {
      // Show an error message or handle invalid input
    }
  }


  // Future<void> _generateInvoice() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }
  //
  //   final pdf = pw.Document();
  //
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Container(
  //           padding: pw.EdgeInsets.all(20),
  //           child: pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             children: [
  //               pw.Text(
  //                 'Invoice',
  //                 style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
  //               ),
  //               pw.SizedBox(height: 20),
  //               pw.Text('Customer: ${_customerNameController.text}'),
  //               pw.SizedBox(height: 10),
  //               pw.Text('Date: ${DateTime.now().toString()}'),
  //               pw.SizedBox(height: 20),
  //               pw.Text(
  //                 'Items:',
  //                 style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
  //               ),
  //               for (var item in _items)
  //                 pw.Text('${item.name} - ₹${item.price.toStringAsFixed(2)}'),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //
  //   final String dir = (await getApplicationDocumentsDirectory()).path;
  //   final String path = '$dir/invoice.pdf';
  //   final File file = File(path);
  //   await file.writeAsBytes(await pdf.save());
  //
  //   // Open the PDF file
  //   // You can use any PDF viewer or share the file as needed
  //   // For example, you can use the `open_file` package to open the PDF:
  //   // OpenFile.open(path);
  // }

  Future<void> _generateInvoice() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pdf = pw.Document();
    var data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    var myFont = pw.Font.ttf(data);
    // var myStyle = TextStyle(font: myFont);

    // Define font fallbacks
    // final fontFallback = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              pw.Text(
              'Invoice',
              style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  font: myFont
                  // font: pw.Font.ttf(await rootBundle.load("fonts/arial.ttf")), // Use the custom font
            ),
          ),
          // Other text elements...
          ],
          ),
          );
        },
      ),
    );


    // final String dir = (await getApplicationDocumentsDirectory()).path;
    // final String path = '$dir/invoice.pdf';
    // final File file = File(path);
    // await file.writeAsBytes(await pdf.save());
    // Get the downloads directory
    final Directory? downloadsDirectory = await getExternalStorageDirectory();
    final String downloadsPath = downloadsDirectory!.path;

// Define the file path
    final String filePath = '$downloadsPath/invoice.pdf';

// Write the PDF file to the downloads directory
    final File file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    print("Successfully saved in: $downloadsPath");
// Open the PDF file using the default PDF viewer
//     OpenFile.open(filePath);
//     await launchUrl(Uri.parse(filePath));
    print(filePath);
    // Open the PDF file
    // You can use any PDF viewer or share the file as needed
    // For example, you can use the `open_file` package to open the PDF:
    // OpenFile.open(path);
  }
}

class Item {
  final String name;
  final double price;

  Item({required this.name, required this.price});
}


// import 'package:flutter/material.dart';
// import 'package:invoiceninja/invoiceninja.dart';
// // import 'package:invoiceninja/models/client.dart';
// // import 'package:invoiceninja/models/invoice.dart';
// // import 'package:invoiceninja/models/product.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// class InvoiceGeneratorScreen extends StatefulWidget {
//   InvoiceGeneratorScreen({Key? key}) : super(key: key);
//
//   @override
//   _InvoiceGeneratorScreenState createState() => _InvoiceGeneratorScreenState();
// }
//
// class _InvoiceGeneratorScreenState extends State<InvoiceGeneratorScreen> with WidgetsBindingObserver {
//   List<Product> _products = [];
//
//   String _email = '';
//   Product? _product;
//   Invoice? _invoice;
//
//   @override
//   initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//
//     InvoiceNinja.configure(
//       // Set your company key or use 'KEY' to test
//       // The key can be generated on Settings > Client Portal
//       'KEY',
//       url: 'https://demo.invoiceninja.com', // Set your selfhost app URL
//       debugEnabled: true,
//     );
//
//     InvoiceNinja.products.load().then((products) {
//       setState(() {
//         _products = products;
//       });
//     });
//   }
//
//   void _createInvoice() async {
//     if (_product == null) {
//       return;
//     }
//
//     var client = Client.forContact(email: _email);
//     client = await InvoiceNinja.clients.save(client);
//
//     var invoice = Invoice.forClient(client, products: [_product!]);
//     invoice = await InvoiceNinja.invoices.save(invoice);
//
//     setState(() {
//       _invoice = invoice;
//     });
//   }
//
//   void _viewPdf() {
//     if (_invoice == null) {
//       return;
//     }
//
//     launch(
//       'https://docs.google.com/gview?embedded=true&url=${_invoice!.pdfUrl}',
//       forceWebView: true,
//     );
//   }
//
//   void _viewPortal() {
//     if (_invoice == null) {
//       return;
//     }
//
//     final invitation = _invoice!.invitations.first;
//     launch(invitation.url);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     if (_invoice == null || state != AppLifecycleState.resumed) {
//       return;
//     }
//
//     final invoice = await InvoiceNinja.invoices.findByKey(_invoice!.key);
//
//     if (invoice.isPaid) {
//       // ...
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Ninja Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       suffixIcon: Icon(Icons.email),
//                     ),
//                     onChanged: (value) => setState(() => _email = value),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   DropdownButtonFormField<Product>(
//                     decoration: InputDecoration(
//                       labelText: 'Product',
//                     ),
//                     onChanged: (value) => setState(() => _product = value),
//                     items: _products
//                         .map((product) => DropdownMenuItem(
//                       child: Text(product.productKey),
//                       value: product,
//                     ))
//                         .toList(),
//                   ),
//                   SizedBox(height: 16),
//                   OutlinedButton(
//                     child: Text('Create Invoice'),
//                     onPressed: (_email.isNotEmpty && _product != null)
//                         ? () => _createInvoice()
//                         : null,
//                   ),
//                   OutlinedButton(
//                     child: Text('View PDF'),
//                     onPressed: (_invoice != null) ? () => _viewPdf() : null,
//                   ),
//                   OutlinedButton(
//                     child: Text('View Portal'),
//                     onPressed: (_invoice != null) ? () => _viewPortal() : null,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }