// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/bloc/barcode/barcode_bloc.dart';
import 'package:naqshrevision/src/bloc/product/product_bloc.dart';
import 'package:naqshrevision/src/bloc/revision/revision_bloc.dart';
import 'package:naqshrevision/src/bloc/skl2Base/skl2_bloc.dart';
import 'package:naqshrevision/src/dialog/center_dialog.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/theme/fonts.dart';
import 'package:naqshrevision/src/ui/home/revesion/add_revision_screen.dart';
import 'package:naqshrevision/src/ui/home/revision_detail/revision_detail_screen.dart';
import 'package:naqshrevision/src/utils/cache.dart';

import '../../theme/colors.dart';
final priceFormat = NumberFormat("#,##0", "ru");
final priceFormatUsd = NumberFormat("#,##0.00", "en");
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Repository _repository = Repository();
  @override
  void initState() {
    revisionBloc.getAllRevision();
    productBloc.getAllProduct('');
    barcodeBloc.getBarcodeAll();
    skl2BaseBloc.getAllSkl2();
    super.initState();
  }
  @override
  void dispose() {
    revisionBloc.getAllRevision();
    productBloc.getAllProduct('');
    barcodeBloc.getBarcodeAll();
    skl2BaseBloc.getAllSkl2();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: false,
        title: Text(CacheService.getName(),style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColor.background,
        actions: [
          IconButton(onPressed: (){
            CenterDialog.showLogoutDialog(context);
          }, icon: const Icon(Icons.logout,color: AppColor.red,))
        ],
      ),
      body: StreamBuilder<RevisionModel>(
        stream: revisionBloc.getRevisionStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!.data;
            return Column(
              children: [
                Expanded(child: ListView.builder(
                  itemCount: data.length,
                    itemBuilder: (ctx,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SlidableAction(
                                  onPressed: (i)async{
                                    HttpResult res = await _repository.deleteRevision(data[index].id);
                                    CenterDialog.showCircularDialog(context);
                                    if(res.result['status'] == true){
                                     await revisionBloc.getAllRevision();
                                     Navigator.pop(context);
                                    }
                                    else{
                                      Navigator.pop(context);
                                    }
                                  },
                                  backgroundColor: AppColor.card,
                                  icon: Icons.delete,
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: AppColor.primary,
                                ),
                                SlidableAction(
                                  onPressed: (i)async{
                                    await _repository.lockRevision(data[index].id, 1);
                                    await revisionBloc.getAllRevision();
                                  },
                                  backgroundColor: AppColor.card,
                                  icon: Icons.lock,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: AppColor.primary,
                                ),
                                SlidableAction(
                                  onPressed: (i)async{
                                    await _repository.lockRevision(data[index].id, 0);
                                    await revisionBloc.getAllRevision();
                                  },
                                  backgroundColor: AppColor.card,
                                  icon: Icons.lock_open,
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            return RevisionDetailScreen(data: data[index], ndoc: data[index].ndoc,);
                          }));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.card,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data[index].pr ==1? Row(
                                    children: [
                                      const Icon(Icons.lock,color: AppColor.red,),
                                      Text("№${data[index].ndoc}",style: AppStyle.medium(AppColor.red),),
                                    ],
                                  ) : Text("№${data[index].ndoc}",style: AppStyle.medium(AppColor.black),),
                                  Text(data[index].vaqt.substring(10),style: AppStyle.medium(AppColor.black),),
                                ],
                              ),
                              SizedBox(height: 12.h,),
                              Text("Ombor summasi:",style: AppStyle.medium(AppColor.black),),
                              Wrap(
                                children: [
                                  Text("${priceFormat.format(data[index].sm)} so'm | ",style: AppStyle.medium(AppColor.green),),
                                  Text("${priceFormatUsd.format(data[index].smS)} \$",style: AppStyle.medium(AppColor.green),),
                                ],
                              ),
                              SizedBox(height: 12.h,),
                              Text("Qayta hisoblangan summa:",style: AppStyle.medium(AppColor.black),),
                              Wrap(
                                children: [
                                  Text("${priceFormat.format(data[index].nSm)} so'm | ",style: AppStyle.medium(AppColor.red),),
                                  Text("${priceFormatUsd.format(data[index].nSmS)} \$",style: AppStyle.medium(AppColor.red),),
                                ],
                              ),
                              SizedBox(height: 12.h,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }))
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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
            return const AddRevisionScreen();
          }));
        },
        backgroundColor: AppColor.green,
        child: const Icon(Icons.add_circle,color: Colors.white,),
      ),
    );
  }
}
