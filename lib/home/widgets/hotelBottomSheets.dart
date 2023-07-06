import 'package:flutter/material.dart';

class HotelCancellationPolicy extends StatelessWidget {
  const HotelCancellationPolicy({
    super.key,
    required this.charge,
    required this.chargeType,
    required this.from,
    required this.to,
  });

  final double charge;
  final int chargeType;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Wrap(
        children: <Widget>[
          Center(
              child: Container(
                  height: 4.0, width: 50.0, color: const Color(0xFF32335C))),
          const SizedBox(
            height: 10.0,
          ),
          Column(
            children: [
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctxt, int i) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Charge: $charge",
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "ChargeType: $chargeType",
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "From: $from",
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "To: $to",
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HotelPriceBreakdown extends StatelessWidget {
  const HotelPriceBreakdown({
    super.key,
    required this.roomPrice,
    required this.tax,
    required this.extraGuestCharge,
    required this.childCharge,
    required this.otherCharges,
    required this.discount,
    required this.publishedPrice,
    required this.publishedPriceRoundOff,
    required this.offeredPrice,
    required this.offeredPriceRoundOff,
    required this.agentCommission,
    required this.agentMarkup,
    required this.serviceTax,
    required this.tcs,
    required this.tds,
    required this.serviceCharge,
    required this.totalGstAmount,
  });

  final dynamic roomPrice;
  final dynamic tax;
  final dynamic extraGuestCharge;
  final dynamic childCharge;
  final dynamic otherCharges;
  final dynamic discount;
  final dynamic publishedPrice;
  final dynamic publishedPriceRoundOff;
  final dynamic offeredPrice;
  final dynamic offeredPriceRoundOff;
  final dynamic agentCommission;
  final dynamic agentMarkup;
  final dynamic serviceTax;
  final dynamic tcs;
  final dynamic tds;
  final dynamic serviceCharge;
  final dynamic totalGstAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Wrap(
        children: <Widget>[
          Center(
              child: Container(
                  height: 4.0, width: 50.0, color: const Color(0xFF32335C))),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "RoomPrice: ${roomPrice}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Tax: ${tax}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ExtraGuestCharge: ${extraGuestCharge}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ChildCharge: ${childCharge}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "OtherCharges: ${otherCharges}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Discount: ${discount}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "PublishedPrice: ${publishedPrice}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "PublishedPriceRoundedOff: ${publishedPriceRoundOff}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "OfferedPrice: ${offeredPrice}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "OfferedPriceRoundedOff: ${offeredPriceRoundOff}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "AgentCommission: ${agentCommission}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "AgentMarkUp: ${agentMarkup}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ServiceTax: ${serviceTax}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "TCS: ${tcs}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "TDS: $tds",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ServiceCharge: ${serviceCharge}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "TotalGSTAmount: ${totalGstAmount}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
