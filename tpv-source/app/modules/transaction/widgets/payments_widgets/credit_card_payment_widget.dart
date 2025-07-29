import '/app/modules/card/domain/models/card_model.dart';
import 'package:flutter/material.dart';

class CreditCardDropdown extends StatefulWidget {
  final List<CardModel> cards;
  final CardModel initialCard;
  final BuildContext context;
  final void Function(CardModel) onCardSelected;

  CreditCardDropdown({
    required this.cards,
    required this.initialCard,
    required this.onCardSelected,
    required this.context,
  });

  @override
  _CreditCardDropdownState createState() => _CreditCardDropdownState();
}

class _CreditCardDropdownState extends State<CreditCardDropdown> {
  CardModel? card;

  @override
  void initState() {
    super.initState();
    card = widget.initialCard;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.4,
      child: DropdownButton<CardModel>(
        icon: Icon(Icons.arrow_forward_ios),
        iconSize: 15,
        value: card,
        onChanged: (CardModel? newValue) {
          setState(() {
            card = newValue;
            widget.onCardSelected(card!);
          });
        },
        items: widget.cards.map<DropdownMenuItem<CardModel>>((CardModel card) {
          String imageAsset;
          switch (card.bankName) {
            case "Banco Popular de Ahorro (BPA)":
              imageAsset = "assets/images/backgrounds/enzona/bpa.png";
              break;
            case "Banco Metropolitano S.A":
              imageAsset = "assets/images/backgrounds/enzona/banmet.png";
              break;
            case "Banco Internacional de Comercio S.A.(BICSA)":
              imageAsset = "assets/images/backgrounds/enzona/bicsa.png";
              break;
            case "Banco de Crédito y Comercio (BANDEC)":
              imageAsset = "assets/images/backgrounds/enzona/bandec.png";
              break;
            default:
              imageAsset = "assets/images/backgrounds/enzona/banmet.png";
              break;
          }

          return DropdownMenuItem<CardModel>(
            alignment: Alignment.center,
            value: card,
            child: Container(
                width: size.width * 0.8,
                height: size.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width / 80),
                        child: Image.asset(
                          imageAsset,
                          width: size.width / 20,
                          height: size.height / 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: size.width * 0.6,
                        height: size.height * 0.1,
                        child: Center(
                          child: Text(
                            card.cardholder,
                            style: TextStyle(fontSize: size.width * 0.03),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: size.width * 0.1,
                        height: size.height * 0.1,
                        child: Center(
                          child: Text(
                            ' (${card.last4}) ${card.currency.toUpperCase()}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),

                    /* Icon(
                      card == card ? Icons.check : null,
                      color: Theme.of(context).primaryColor,
                      size: MediaQuery.of(context).size.width*0.05
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.1,),*/
                  ],
                ) /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                      Expanded(
                        flex: 10,
                        child: Image.asset(
                          imageAsset,
                          height: 20,
                          width: 30
                        ),
                      ),
                   // SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  Expanded(
                    flex: 8,
                    child: Text(
                      '${card.cardholder} - ${card.last4}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ), SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  Expanded(
                    flex: 8,
                    child: Icon(
                      card == card ? Icons.check : null,
                      color: Theme.of(context).primaryColor,
                    ))
                ],
              ),*/
                ),
          );
        }).toList(),
      ),
    );
  }
}
