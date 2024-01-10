// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/bloc/cart/cart_bloc.dart';
import 'package:naqshrevision/src/bloc/product/product_bloc.dart';
import 'package:naqshrevision/src/dialog/center_dialog.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/utils/cache.dart';

import '../../../bloc/revision/revision_bloc.dart';
import '../../../theme/colors.dart';
import '../../../theme/fonts.dart';

class CartScreen extends StatefulWidget {
  final num count,oldSummaUzs,oldSummaUsd;
  final ScrollController scrollController;

  const CartScreen({super.key, required this.scrollController, required this.count, required this.oldSummaUzs, required this.oldSummaUsd});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    cartBloc.getCartAll();
    super.initState();
  }

  bool isLoading = false;

  final Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.card,
      body: StreamBuilder<List<BaseListResult>>(
          stream: cartBloc.getCartStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double newTotalUzs = 0;
              double totalSumUzs = 0;
              double totalSumUsd = 0;
              double newTotalUsd = 0;
              var data = snapshot.data!;
              for(int i = 0; i<data.length;i++){
                if (data[i].snarhi != 0) {
                  newTotalUzs = data[i].snarhi.toDouble() *data[i].osoni ;
                  totalSumUzs = data[i].snarhi.toDouble() *num.parse(data[i].vz) ;
                } else {
                  newTotalUsd += data[i].snarhiS * data[i].osoni;
                  totalSumUsd = data[i].snarhiS.toDouble() *num.parse(data[i].vz) ;
                }
              }
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    width: 100,
                    height: 5,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: ListView.builder(
                        controller: widget.scrollController,
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (i) async {
                                      await _repository.deleteCart(data[index]);
                                      await cartBloc.getCartAll();
                                    },
                                    icon: Icons.delete,
                                    backgroundColor: AppColor.red,
                                    label: "O'chirish",
                                  )
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: index%2==0?AppColor.card:AppColor.grey),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data[index].name,
                                            style:
                                                AppStyle.medium(Colors.red),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child:int.parse(data[index].osoni.toString().replaceAll(".", "")) %10 == 0?Text(
                                            "${data[index].osoni.toInt()} qoldiq",
                                            textAlign: TextAlign.end,
                                            style: AppStyle.medium(AppColor.red),
                                          ):Text("${data[index].osoni} qoldiq", textAlign: TextAlign.end, style: AppStyle.medium(AppColor.red),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  GestureDetector(
                    onTap: () async {
                            CenterDialog.showCircularDialog(context);
                            List<SklRevTov> sklRevTov = [];
                            for (int i = 0; i < data.length; i++) {
                              SklRevTov skl = SklRevTov(
                                id: data[i].id,
                                idSkl2: data[i].idSkl2,
                                soni: double.parse(data[i].vz),
                                nSoni: data[i].osoni.toDouble(),
                                fSoni: double.parse(data[i].vz) - data[i].osoni,
                                narhi: data[i].narhi,
                                narhiS: data[i].narhiS.toDouble(),
                                snarhi: data[i].snarhi.toInt(),
                                snarhiS: data[i].snarhiS.toDouble(),
                                snarhi1: data[i].snarhi.toInt(),
                                snarhi1S: data[i].snarhi1S.toDouble(),
                                snarhi2: data[i].snarhi2.toInt(),
                                snarhi2S: data[i].snarhi2S.toDouble(),
                                name: data[i].name,
                              );
                              sklRevTov.add(skl);
                            }
                            RevisionResult revision = RevisionResult(
                              id: 0,
                              sana: DateTime.now(),
                              ndoc: '999',
                              izoh: '',
                              sm: totalSumUzs,
                              smS: totalSumUsd,
                              idHodim: CacheService.getId(),
                              pr: 0,
                              yil: DateTime.now().year.toString(),
                              oy: DateTime.now().month.toString(),
                              idSkl: 1,
                              vaqt: DateTime.now().toString(),
                              f1: 0,
                              f2: 0,
                              nSm: newTotalUzs,
                              nSmS: newTotalUsd,
                              st: 1,
                              sklRevTov: sklRevTov,
                            );
                            HttpResult res = await _repository.sendRevision(revision);
                            if(res.result["status"] == true){
                              Navigator.pop(context);
                              Navigator.pop(context);
                              await revisionBloc.getAllRevision();
                              await productBloc.getAllProduct('');
                              await _repository.clearCart();
                            }
                            else{
                              Navigator.pop(context);
                            }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: MediaQuery.of(context).size.width,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.green),
                      child: Text(
                        "Saqlash",
                        style: AppStyle.large(AppColor.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.w,)
                ],
              );
            }
            return Container();
          }),
    );
  }
}
