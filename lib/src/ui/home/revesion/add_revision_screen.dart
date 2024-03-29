// ignore_for_file: use_build_context_synchronously

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/bloc/product/product_bloc.dart';
import 'package:naqshrevision/src/model/barcode/barcode_model.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:naqshrevision/src/theme/colors.dart';
import 'package:naqshrevision/src/theme/fonts.dart';

import '../../../dialog/center_dialog.dart';
import 'cart_screen.dart';

class AddRevisionScreen extends StatefulWidget {
  const AddRevisionScreen({super.key});

  @override
  State<AddRevisionScreen> createState() => _AddRevisionScreenState();
}

class _AddRevisionScreenState extends State<AddRevisionScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    productBloc.getAllProduct('');
    super.initState();
  }
  final Repository _repository =Repository();
  num price = 0,count = 0;
  int priceUsd = 0,idPrice = 0,barCodeId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.background,
        appBar: AppBar(
          foregroundColor: AppColor.black,
          title: CupertinoSearchTextField(
            style: TextStyle(color: AppColor.black),
            onChanged: (i)async{
              await productBloc.getAllProduct(i);
            },
            backgroundColor: AppColor.grey,
            placeholder: 'Izlash',
          ),
          actions: [
            IconButton(
              autofocus: true,
                onPressed: ()async{
                  setState(() => barCodeId = 0);
                  final scanResult = await BarcodeScanner.scan(
                options: const ScanOptions(
                  strings: {
                    'cancel': "Bekor qilish",
                    'flash_on': "Yoqish",
                    'flash_off': "O'chirish",
                  },
                ),
              );
              List<BarcodeResult> barcode = await _repository.getBarcode();
              List<BaseListResult> baseList = await _repository.getProductBase('');
              for (int i = 0; i < baseList.length; i++) {
                price = 0;
                priceUsd = 0;
                if (baseList[i].snarhi != 0) {
                  price = baseList[i].snarhi;
                } else {
                  price = baseList[i].snarhiS;
                  priceUsd = 1;
                }
                for (int j = 0; j < barcode.length; j++) {
                  if (scanResult.rawContent == barcode[j].shtr && barcode[j].idSkl2 == baseList[i].idSkl2) {
                    setState(() => barCodeId = 1);
                    CenterDialog.showCenterDialog(
                        context,
                        BaseListResult(
                          id: baseList[i].id,
                          name: baseList[i].name,
                          idSkl2: baseList[i].idSkl2,
                          idTip: baseList[i].idTip,
                          idFirma: baseList[i].idFirma,
                          idEdiz: baseList[i].idEdiz,
                          narhi: baseList[i].narhi,
                          narhiS: baseList[i].narhiS,
                          snarhi: baseList[i].snarhi,
                          snarhiS: baseList[i].snarhiS,
                          snarhi1: baseList[i].snarhi1,
                          snarhi1S: baseList[i].snarhi1S,
                          snarhi2: baseList[i].snarhi2,
                          snarhi2S: baseList[i].snarhi2S,
                          ksoni: baseList[i].ksoni,
                          ksm: baseList[i].ksm,
                          ksmS: baseList[i].ksmS,
                          psoni: baseList[i].psoni,
                          psm: baseList[i].psm,
                          psmS: baseList[i].psmS,
                          rsoni: baseList[i].rsoni,
                          rsm: baseList[i].rsm,
                          rsmS: baseList[i].rsmS,
                          hsoni: baseList[i].hsoni,
                          hsm: baseList[i].hsm,
                          hsmS: baseList[i].hsmS,
                          vsoni: baseList[i].vsoni,
                          vsm: baseList[i].vsm,
                          vsmS: baseList[i].vsmS,
                          vzsoni: baseList[i].vzsoni,
                          vzsm: baseList[i].vzsm,
                          vzsmS: baseList[i].vzsmS,
                          psksoni: baseList[i].psksoni,
                          psksm: baseList[i].psksm,
                          psksmS: baseList[i].psksmS,
                          rsksoni: baseList[i].rsksoni,
                          rsksm: baseList[i].rsksm,
                          rsksmS: baseList[i].rsksmS,
                          osoni: baseList[i].osoni,
                          osm: baseList[i].osm,
                          osmS: baseList[i].osmS,
                          osmT: baseList[i].osmT,
                          osmTS: baseList[i].osmTS,
                          ksmT: baseList[i].ksmT,
                          ksmTS: baseList[i].ksmTS,
                          yil: baseList[i].yil,
                          oy: baseList[i].oy,
                          idSkl0: baseList[i].idSkl0,
                          foyda: baseList[i].foyda,
                          foydaS: baseList[i].foydaS,
                          soni: baseList[i].soni,
                          vz: baseList[i].vz,
                          photo: baseList[i].photo,
                        ),
                        price,
                        priceUsd,
                        baseList[i].osoni.toDouble());
                  }
                }
              }
                  if(barCodeId <1){
                    CenterDialog.successBarcodeDialog(context, "");
                  }
            }, icon:const Icon(Icons.qr_code_scanner)),
            // IconButton(onPressed: (){}, icon:const Icon(Icons.search_rounded))
          ],
          backgroundColor: AppColor.background,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Container(
              padding: EdgeInsets.only(left: 16.w,right: 16,bottom: 8),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextField(
                controller: commentController,
                onChanged: (i){
                  commentController.text = commentController.text;
                  setState(() {});
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Izoh yozing",
                  hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder<List<BaseListResult>>(
          stream: productBloc.getProductStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!;
              return Stack(
                children: [
                  ListView.builder(
                    controller: scrollController,
                    itemCount: data.length,
                      itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: (){
                        price = 0;
                        priceUsd = 0;
                          if (data[index].snarhi != 0) {
                            price = data[index].snarhi;
                          } else {
                            price = data[index].snarhiS;
                            priceUsd = 1;
                        }
                        CenterDialog.showCenterDialog(context,data[index],price,priceUsd,data[index].osoni.toDouble());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8), color: AppColor.card),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    data[index].name,
                                    style: AppStyle.medium(AppColor.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 100.h,
                                  child: double.parse(data[index].osoni.toString().replaceAll(".", "")) %10 == 0?Text(
                                    "${data[index].osoni.toInt()} qoldiq",
                                    textAlign: TextAlign.end,
                                    style: AppStyle.medium(AppColor.black),
                                  ):Text("${data[index].osoni} qoldiq", textAlign: TextAlign.end, style: AppStyle.medium(AppColor.black),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      builder: (BuildContext context, ScrollController scrollController){
                        return ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(25)),
                            child: CartScreen(scrollController: scrollController,count: count, comment: commentController.text,));
                      }),
                ],
              );
            }
            return Center(
              child: Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.card,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: CupertinoActivityIndicator(color: AppColor.black,),
                ),
              ),
            );
          }
        ));
  }
}
