import 'dart:ui';

import 'package:contacts_service/contacts_service.dart';
import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/widget/touchables/touchable_opacity.dart';
import 'package:dukka/feature/dashboard/presentation/widget/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactBottomModal extends StatelessWidget {
  const ContactBottomModal({
    Key? key,
    required this.contacts,
    required this.onSelect,
  }) : super(key: key);
  final List<Contact> contacts;
  final Function(Contact) onSelect;
  static Future<String?> show({
    required BuildContext context,
    required List<Contact> contacts,
    required Function(Contact) onSelect,
  }) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      routeSettings: const RouteSettings(name: '/add/bottomsheet'),
      builder: (context) {
        return ContactBottomModal(
          contacts: contacts,
          onSelect: onSelect,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1.5,
        sigmaY: 1.5,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            const HeaderWidget(title: 'Select contacts'),
            const Gap(20),
            Expanded(
              child: ListView.separated(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return TouchableOpacity(
                    onTap: () {
                      onSelect(contact);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.blueColor10,
                          child: TextBold(
                            '${contact.displayName![0]}${contact.displayName![1]}',
                            color: AppColors.blueColor,
                            fontSize: 15,
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextBold(
                                '${contact.displayName}',
                              ),
                              const Gap(5),
                              TextRegular(
                                '${contact.phones!.first.value}',
                                color: AppColors.redColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: const [
                        Gap(20),
                        Divider(
                          color: AppColors.blackColor10,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
