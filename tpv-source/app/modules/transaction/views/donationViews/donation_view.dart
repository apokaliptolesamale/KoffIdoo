import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../widgets/utils/loading.dart';
import '../../bindings/donation_binding.dart';
import '../../controllers/donation_controller.dart';
import '../../domain/models/donation_model.dart';
import '../../widgets/donation_widgets/custom_appBar.dart';
import 'donar_view.dart';

class DonationView extends GetResponsiveView<DonationController> {
  DonationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DonationController>(
      builder: ((controller) => Scaffold(
            body: CustomScrollView(
              slivers: [
                const DonationCustomAppBar(
                  title: 'Donaciones',
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                      height: size.height / 1,
                      child: FutureBuilder(
                          future: controller.getDonations(),
                          builder: ((context,
                              AsyncSnapshot<
                                      Either<Failure,
                                          EntityModelList<DonationModel>>>
                                  snapshot) {
                            if (!snapshot.hasData) {
                              return Loading(
                                text: "Cargando donaciones...",
                                backgroundColor: Colors.lightBlue.shade700,
                                animationColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightBlue.withOpacity(0.8)),
                                containerColor:
                                    Colors.lightBlueAccent.withOpacity(0.2),
                              );
                            } else {
                              //late DonationModel don;
                              if (snapshot.data!.isRight()) {
                                return snapshot.data!.fold((l) => AlertDialog(),
                                    (r) {
                                  List<DonationModel> list = r.getList();
                                  return ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: ((context, index) {
                                        /*  for (var i = 0; i < list.length; i++) {
                                          log('EStas son las donaciones==> ${don = r.getList()[index]}');
                                           //donar.donation[index];
                                        } */
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                list[index].title.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(list[index]
                                                  .createdAt!
                                                  .replaceRange(10, null, '')
                                                  .replaceAll('-', '/')),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                              onTap: () {
                                                Get.to(() => DonarView(),
                                                    binding: DonationBinding(),
                                                    arguments: list[index]);
                                                /* Get.toNamed(
                                                '/donation', // Routes.getInstance.getByRoute(DonationPageImpl.builder().name).name,
                                                arguments: aux =
                                                    donar.donation[index]); */
                                              },
                                            ),
                                            Divider(),
                                          ],
                                        );
                                      }));
                                });
                                //late Donation aux;
                              }
                              //var donar = snapshot.data as DonationList;
                            }
                            return AlertDialog();
                          }))),
                ]))
              ],
            ),
          )),
    );
  }
}
