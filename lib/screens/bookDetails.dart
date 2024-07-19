import 'package:flutter/material.dart';
import 'package:fllutter/constantsHelpers/AppColors.dart'; // Custom colors defined in the colors.dart class
import 'package:fllutter/screens/pdfScreen.dart'; //This widget is used to retrive and view the pdf
import '../constantsHelpers/book.dart'; //this class is used to store book details

class BookDetailsScreen extends StatefulWidget {
  final Book book;
  final String isbn;

  const BookDetailsScreen({Key? key, required this.book, required this.isbn})
      : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late FocusNode _readButtonFocusNode;
  late FocusNode _continueReadingButtonFocusNode;

  @override
  void initState() {
    super.initState();
    _readButtonFocusNode = FocusNode();
    _continueReadingButtonFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _readButtonFocusNode.dispose();
    _continueReadingButtonFocusNode.dispose();
    super.dispose();
  }

  void openPdfViewer(BuildContext context) async {
    String isbnNumber =
        widget.isbn; //This is used to retrive particular book from the internet
    if (isbnNumber.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            isbn: widget.isbn,
          ),
        ),
      );
    } else {
      // Handle case where pdfPath is empty or invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid Pdf'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          widget.book.title,
          style: TextStyle(color: Color.fromARGB(255, 122, 164, 212)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Card(
          color: AppColors.backgroundColor,
          elevation: 8.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  child: Image.network(
                    widget.book.coverImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Authors: ${widget.book.authors.join(', ')}',
                        style: TextStyle(
                            fontSize: 18.0, color: AppColors.textColor),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Publisher: ${widget.book.publisher}',
                        style: TextStyle(
                            fontSize: 18.0, color: AppColors.textColor),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Subject: ${widget.book.subject}',
                        style: TextStyle(
                            fontSize: 18.0, color: AppColors.textColor),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'ISBN: ${widget.book.isbn}', // Display the ISBN
                        style: TextStyle(
                            fontSize: 18.0, color: AppColors.textColor),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Reads: ${widget.book.reads}',
                        style: TextStyle(
                            fontSize: 18.0, color: AppColors.textColor),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Focus(
                            focusNode: _readButtonFocusNode,
                            onFocusChange: (hasFocus) {
                              setState(() {});
                            },
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonColor,
                                side: BorderSide(
                                  color: _readButtonFocusNode.hasFocus
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : Colors.transparent,
                                  width:
                                      _readButtonFocusNode.hasFocus ? 4.0 : 0.0,
                                ),
                                elevation:
                                    _readButtonFocusNode.hasFocus ? 12.0 : 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                shadowColor: _readButtonFocusNode.hasFocus
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                              onPressed: () {
                                openPdfViewer(context);
                              },
                              child: Text(
                                'Read',
                                style: TextStyle(
                                  color: _readButtonFocusNode.hasFocus
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(
                                          255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
