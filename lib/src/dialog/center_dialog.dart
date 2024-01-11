// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/theme/colors.dart';
import 'package:naqshrevision/src/theme/fonts.dart';
import 'package:naqshrevision/src/ui/home/home_screen.dart';
import 'package:naqshrevision/src/ui/login/login_screen.dart';
import 'package:naqshrevision/src/utils/cache.dart';

import '../bloc/cart/cart_bloc.dart';

class CenterDialog {
  static void showCenterDialog(
      BuildContext context, BaseListResult data, num price, int priceUsd,double count) {
    TextEditingController controllerCount = TextEditingController();
    TextEditingController controllerPrice = TextEditingController(text: priceUsd == 0?priceFormat.format(price):priceFormatUsd.format(price));
    TextEditingController controllerTotal = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: 400.w,
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
              backgroundColor: AppColor.card,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                data.name,
                style: AppStyle.large(AppColor.black),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 400.w,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0.w, bottom: 8),
                      child: Text(
                        "Soni / Kg",
                        style: AppStyle.medium(AppColor.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: MediaQuery.of(context).size.width,
                      height: 50.w,
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: AppColor.black),
                        controller: controllerCount,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (i){
                          if(int.parse(data.osoni.toString().replaceAll(".", "")) % 10 == 0){
                            try{
                              controllerTotal.text = priceUsd==0?priceFormat.format(double.parse(i)*price):priceFormatUsd.format(double.parse(i)*price);
                            }catch(_){
                              controllerTotal.text = '';
                            }
                          }
                          else{
                            try{
                              controllerTotal.text = priceUsd==0?priceFormat.format(int.parse(i)*price.toInt()):priceFormatUsd.format(double.parse(i)*price);
                            }catch(_){
                              controllerTotal.text = '';
                            }
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Soni / Kg",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0.w, bottom: 8, top: 8),
                      child: Text(
                        "Narxi",
                        style: AppStyle.medium(AppColor.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: MediaQuery.of(context).size.width,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade600)),
                      child: TextField(
                        style: TextStyle(color: AppColor.black),
                        controller: controllerPrice,
                        decoration:  InputDecoration(
                          suffixStyle: TextStyle(color: AppColor.black),
                          enabled: false,
                          suffixText: priceUsd==1?"\$":"so'm",
                          hintText: "Narxi",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0.w, bottom: 8, top: 8),
                      child: Text(
                        "Jami",
                        style: AppStyle.medium(AppColor.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: MediaQuery.of(context).size.width,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade600)),
                      child: TextField(
                        style: TextStyle(color: AppColor.black),
                        controller: controllerTotal,
                        decoration:  InputDecoration(
                            enabled: false,
                            hintText: "Jami",
                            suffixStyle: TextStyle(color: AppColor.black),
                            suffixText: priceUsd==1?"\$":"so'm",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              width: MediaQuery.of(context).size.width,
                              height: 47.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.red),
                              child: Text(
                                "Bekor qilish",
                                style: AppStyle.large(AppColor.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async{
                              Repository repo = Repository();
                              BaseListResult dataBase = BaseListResult(
                                id: data.id,
                                name: data.name,
                                idSkl2: data.idSkl2,
                                idTip: data.idTip,
                                idFirma: data.idFirma,
                                idEdiz: data.idEdiz,
                                narhi: data.narhi,
                                narhiS: data.narhiS,
                                snarhi: data.snarhi,
                                snarhiS: data.snarhiS,
                                snarhi1: data.snarhi1,
                                snarhi1S: data.snarhi1S,
                                snarhi2: data.snarhi2,
                                snarhi2S: data.snarhi2S,
                                ksoni: data.ksoni,
                                ksm: data.ksm,
                                ksmS: data.ksmS,
                                psoni: data.psoni,
                                psm: data.psm,
                                psmS: data.psmS,
                                rsoni: data.rsoni,
                                rsm: data.rsm,
                                rsmS: data.rsmS,
                                hsoni: data.hsoni,
                                hsm: data.hsm,
                                hsmS: data.hsmS,
                                vsoni: data.vsoni,
                                vsm: data.vsm,
                                vsmS: data.vsmS,
                                vzsoni: data.vzsoni,
                                vzsm: data.vzsm,
                                vzsmS: data.vzsmS,
                                psksoni: data.psksoni,
                                psksm: data.psksm,
                                psksmS: data.psksmS,
                                rsksoni: data.rsksoni,
                                rsksm: data.rsksm,
                                rsksmS: data.rsksmS,
                                osoni: double.parse(controllerCount.text),
                                osm: data.osm,
                                osmS: data.osmS,
                                osmT: data.osmT,
                                osmTS: data.osmTS,
                                ksmT: data.ksmT,
                                ksmTS: data.ksmTS,
                                yil: data.yil,
                                oy: data.oy,
                                idSkl0: data.idSkl0,
                                foyda: data.foyda,
                                foydaS: data.foydaS,
                                soni: data.soni,
                                vz: count,
                                photo: data.photo,
                              );
                              await repo.saveCart(dataBase);
                              cartBloc.getCartAll();
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              width: MediaQuery.of(context).size.width,
                              height: 47.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.green),
                              child: Text(
                                "Saqlash",
                                style: AppStyle.large(AppColor.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showCircularDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
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
      ),
    );
  }

  static void showDocumentDetail(BuildContext context,RevisionResult data){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        elevation: 0,
        backgroundColor: AppColor.card,
        insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Text("Hujjat raqami №${data.ndoc}",style: AppStyle.medium(AppColor.black),textAlign: TextAlign.center,),
        content: SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [

                ],
              )
            ],
          ),
        ),
      );
    });
  }

  static void showLogoutDialog(BuildContext context){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 14),
        backgroundColor: AppColor.card,
        title: Text("Xisobdan chiqish",style: AppStyle.large(AppColor.black),),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 150.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Rostan ham xisobdan chiqmoqchimisz?",textAlign: TextAlign.center,style: AppStyle.medium(AppColor.black),)),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.red
                        ),
                        child: Text("Yo'q",style: AppStyle.large(AppColor.black),),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{
                        Repository r = Repository();
                        await CacheService.clear();
                        await r.clearProduct();
                        await r.clearBarcode();
                        await r.clearSkl2Base();
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                          return const LoginScreen();
                        }));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.green
                        ),
                        child: Text("Ha",style: AppStyle.large(AppColor.black),),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
      );
    });
  }
}
// PATCH  {"ID":111,"PROV":1}  rev0_prov?DB=002&JWT=""
