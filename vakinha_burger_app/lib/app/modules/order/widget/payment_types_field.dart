import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';

import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_style.dart';
import '../../../models/payment_type_model.dart';

class PaymentTypesField extends StatelessWidget {
  final List<PaymentTypeModel> paymentTypes;
  final ValueChanged<int> onChanged;
  final bool valid;
  final String valueSelected;

  const PaymentTypesField({
    super.key,
    required this.paymentTypes,
    required this.onChanged,
    required this.valid,
    required this.valueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forma de pagamento',
            style: context.textStyles.textRegular.copyWith(
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
            ),
          ),
          SmartSelect.single(
            title: '',
            selectedValue: valueSelected,
            modalType: S2ModalType.bottomSheet,
            onChange: (selected) {
              onChanged(int.parse(selected.value));
            },
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? '',
                            style: context.textStyles.textRegular,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: const Divider(
                        color: Colors.red,
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Selecione uma forma de pagamento',
                          style: context.textStyles.textRegular.copyWith(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom(
              source: paymentTypes.map((p) => {'value': p.id.toString(), 'title': p.name}).toList(),
              // [
              //   {'value': 'VA', 'title': 'Vale Alimentação'},
              //   {'value': 'VR', 'title': 'Vale Refeição'},
              //   {'value': 'CC', 'title': 'Cartão de Crédito'},
              //   {'value': 'PIX', 'title': 'PIX'},
              // ],
              title: (index, item) => item['title'] ?? '',
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          ),
        ],
      ),
    );
  }
}
