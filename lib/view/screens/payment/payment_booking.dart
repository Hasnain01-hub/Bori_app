// ignore_for_file: file_names, annotate_overrides, prefer_const_constructors, override_on_non_overriding_member, avoid_print, unused_field, avoid_unnecessary_containers, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Payment_booking extends StatefulWidget {
  final fees;
  
  final name;
  final email;
  final phone;
  final address;
  final date;
  final fromtime;
  final totime;

  const Payment_booking({Key? key, this.fees,this.address,this.date,this.fromtime,this.totime,this.email,this.name,this.phone}) : super(key: key);

  @override
  _Payment_bookingState createState() => _Payment_bookingState();
}

bool isLoading = true; //this can be declared outside the class

class _Payment_bookingState extends State<Payment_booking> {
  double progress = 0;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  String? selectedUrl;
  void initState() {
    createRequest();

    print(selectedUrl);

    super.initState();
    //creating the HTTP request
  }

  Future createRequest() async {
    Map<String, String> body = {
      "amount": widget.fees, //amount to be paid
      "purpose": "Booking",
      "buyer_name": widget.name ??'dummy',
      "email": widget.email ??'dummy@gmail.com',
      "phone": widget.phone ??'7878787878',
      "allow_repeated_payments": "true",
      "send_email": "true",
      "send_sms": "true",
      // "redirect_url": "https://www.google.com/",
      //Where to redirect after a successful payment.
      // "webhook": "https://www.google.com/",
    };
//First we have to create a Payment_Request.
//then we'll take the response of our request.
    var resp = await http.post(
        Uri.parse("https://test.instamojo.com/api/1.1/payment-requests/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "test_471c4569e7c0bbec66bacecaea1",
          "X-Auth-Token": "test_dbd4f9391fd3909c0736a61506d"
        },
        body: body);
    if (json.decode(resp.body)['success'] == true) {
//If request is successful take the longurl.
      setState(() {
        isLoading = false; //setting state to false after data loaded

        selectedUrl =
            json.decode(resp.body)["payment_request"]['longurl'].toString() +
                "?embed=form";
        print(selectedUrl);
      });
      // print(json.decode(resp.body)['message'].toString());
//If something is wrong with the data we provided to
//create the Payment_Request. For Example, the email is in incorrect format, the payment_Request creation will fail.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Pay"),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? //check loadind status
              CircularProgressIndicator()
              : InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.tryParse(selectedUrl!),
                  ),

                  // javascriptMode: JavascriptMode.unrestricted,

                  onWebViewCreated: (InAppWebViewController webViewController) {
                    // _controller.complete(webViewController);
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onUpdateVisitedHistory: (_, Uri? uri, __) {
                    String url = uri.toString();
                    print(uri);
                    // uri containts newly loaded url
                    if (mounted) {
                      if (url.contains('https://www.google.com/')) {
                        //Take the payment_id parameter of the url.
                        String? paymentRequestId =
                            uri?.queryParameters['payment_id'];
                        print("value is: " + paymentRequestId.toString());
                        //calling this method to check payment status
                        _checkPaymentStatus(paymentRequestId.toString());
                      }
                    }
                  },
                ),
        ),
      ),
    );
  }

  _checkPaymentStatus(String id) async {
    var response = await http.get(
        Uri.parse("https://test.instamojo.com/api/1.1/payments/$id/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "test_471c4569e7c0bbec66bacecaea1",
          "X-Auth-Token": "test_dbd4f9391fd3909c0736a61506d"
        });
    var realResponse = json.decode(response.body);
    print(realResponse);
    if (realResponse['success'] == true) {
      if (realResponse["payment"]['status'] == 'Credit') {
        print('sucesssssssssssful');
        var uuid = Uuid();
        var rand=uuid.v1();
        FirebaseFirestore.instance
              .collection("Booking")
    .doc(rand)
        .set({
    "Name": widget.name,
    "Phone": widget.phone,       
     "email":widget.email,
    "date":widget.date,
    "Address": widget.address,
    "time":widget.fromtime+"-"+widget.totime,
    "fees":widget.fees,
    }).then((value) => print("Booking Document Added"))
        .catchError((error) => print(
    "Failed to add user: $error"));
    
//payment is successful.
      } else {
        print('failed');
//payment failed or pending.
      }
    } else {
      print("PAYMENT STATUS FAILED");
    }
  }
}
