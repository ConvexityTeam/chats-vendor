import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    this.name,
    this.qty,
    this.amount,
    this.onDelete,
    this.onQtyChange,
  }) : super(key: key);

  final String? name;
  final int? qty;
  final double? amount;
  final Function()? onDelete;
  final Function(int?)? onQtyChange;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int qty;
  late double amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qty = widget.qty!;
    amount = widget.amount!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: TEXT(
              text: widget.name!.length <= 7
                  ? widget.name!
                  : widget.name!.substring(0, 5) + '...',
            ),
          ),
          amountControls(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TEXT(text: amount.toString()),
          )),
          GestureDetector(
            onTap: () {
              widget.onDelete!();
            },
            child: Icon(
              Icons.close,
              color: Colors.redAccent[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget amountControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            child: FittedBox(
                child: Icon(
              Icons.remove,
              color: Colors.black,
            )),
            onPressed: () {
              var newQty = qty - 1;
              if (newQty <= 1) {
                widget.onQtyChange!(1);
                setState(() {
                  qty = 1;
                  amount = 1 * widget.amount!;
                });
              } else {
                widget.onQtyChange!(newQty);
                setState(() {
                  qty = newQty;
                  amount = widget.amount! * newQty;
                });
              }
            },
            style: ButtonStyle(
              // padding: MaterialStateProperty.all(EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Color.fromRGBO(23, 206, 137, 1)),
              )),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TEXT(
            text: qty.toString(),
            fontFamily: 'Gilroy-medium',
            fontSize: 19,
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            child: FittedBox(
                child: Icon(
              Icons.add,
              color: Colors.black,
            )),
            onPressed: () {
              var newQty = qty + 1;
              widget.onQtyChange!(newQty);
              setState(() {
                qty = newQty;
                amount = widget.amount! * newQty;
              });
            },
            style: ButtonStyle(
              // padding: MaterialStateProperty.all(EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Color.fromRGBO(23, 206, 137, 1)),
              )),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
