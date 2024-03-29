import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/bloc/product/product_bloc.dart';
import 'package:naqshrevision/src/dialog/center_dialog.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/theme/colors.dart';
import 'package:naqshrevision/src/theme/fonts.dart';
import 'package:naqshrevision/src/ui/home/update_revision/cart_update_revision.dart';

class UpdateRevisionScreen extends StatefulWidget {
  final RevisionModel data;
  const UpdateRevisionScreen({super.key, required this.data});

  @override
  State<UpdateRevisionScreen> createState() => _UpdateRevisionScreenState();
}

class _UpdateRevisionScreenState extends State<UpdateRevisionScreen> {
  final Repository _repository = Repository();
  ScrollController scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();
  num price = 0,count = 0;
  int priceUsd = 0,idPrice = 0;
  @override
  void initState() {
    productBloc.getAllProduct('');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
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
                                        child: int.parse(data[index].osoni.toString().replaceAll(".", "")) %10 == 0?Text(
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
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                              child: UpdateCartRevision(data: widget.data,));
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
