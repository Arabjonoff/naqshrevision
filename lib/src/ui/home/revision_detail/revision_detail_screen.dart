import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/theme/colors.dart';
import 'package:naqshrevision/src/theme/fonts.dart';
import 'package:naqshrevision/src/ui/home/home_screen.dart';

class RevisionDetailScreen extends StatefulWidget {
  final RevisionResult data;
  final String ndoc;

  const RevisionDetailScreen({super.key, required this.data, required this.ndoc});

  @override
  State<RevisionDetailScreen> createState() => _RevisionDetailScreenState();
}

class _RevisionDetailScreenState extends State<RevisionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.black,
        backgroundColor: AppColor.background,
        title: Text("№ ${widget.ndoc}"),
      ),
      body: ListView.builder(
          itemCount: widget.data.sklRevTov.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w,),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: AppColor.card),
              child: ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: AppColor.card,
                title: Text(
                  widget.data.sklRevTov[index].name,
                  style: AppStyle.medium(AppColor.black),
                ),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "Ombor",
                      style: TextStyle(fontSize: 16.5.h,color: AppColor.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Table(
                      border: TableBorder.all(color: AppColor.grey),
                      // Allows to add a border decoration around your table
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: AppColor.grey),
                            children: [
                              Text(
                                "Soni / Kg",
                                style: AppStyle.medium(AppColor.black),
                              ),
                              Text(
                                "So'm",
                                style: AppStyle.medium(AppColor.black),
                              ),
                              Text(
                                "Valyuta",
                                style: AppStyle.medium(AppColor.black),
                              )
                            ]),
                        TableRow(children: [
                          Text(
                            widget.data.sklRevTov[index].soni.toString(),
                            style: AppStyle.medium(AppColor.black),
                          ),
                          Text(
                            priceFormat.format(widget.data.sklRevTov[index].snarhi * widget.data.sklRevTov[index].soni),
                            style: AppStyle.medium(AppColor.black),
                          ),
                          Text(
                            priceFormatUsd.format(widget.data.sklRevTov[index].snarhiS * widget.data.sklRevTov[index].soni),
                            style: AppStyle.medium(AppColor.black),
                          )
                        ]),
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Revizya",
                      style: TextStyle(fontSize: 16.5.h,color: AppColor.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Table(
                      border: TableBorder.all(color: AppColor.grey),
                      // Allows to add a border decoration around your table
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: AppColor.grey),
                            children: [
                              Text(
                                "Soni / Kg",
                                style: AppStyle.medium(AppColor.black),
                              ),
                              Text(
                                "So'm",
                                style: AppStyle.medium(AppColor.black),
                              ),
                              Text(
                                "Valyuta",
                                style: AppStyle.medium(AppColor.black),
                              )
                            ]),
                        TableRow(children: [
                          Text(
                            widget.data.sklRevTov[index].nSoni.toString(),
                            style: AppStyle.medium(AppColor.black),
                          ),
                          Text(
                            priceFormat.format(widget.data.sklRevTov[index].snarhi * widget.data.sklRevTov[index].nSoni),
                            style: AppStyle.medium(AppColor.black),
                          ),
                          Text(
                            priceFormatUsd.format(widget.data.sklRevTov[index].snarhiS * widget.data.sklRevTov[index].nSoni),
                            style: AppStyle.medium(AppColor.black),
                          )
                        ]),
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Farqi",
                      style: TextStyle(fontSize: 16.5.h,color: AppColor.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Table(
                      border: TableBorder.all(color: AppColor.grey),
                      // Allows to add a border decoration around your table
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: AppColor.grey),
                            children: [
                              Text(
                                "Soni / Kg",
                                style: AppStyle.medium(AppColor.black),
                              ),
                              Text(
                                "So'm",
                                style: AppStyle.medium(AppColor.black),
                              ),
                              Text(
                                "Valyuta",
                                style: AppStyle.medium(AppColor.black),
                              )
                            ]),
                        TableRow(children: [
                          Text(
                            widget.data.sklRevTov[index].fSoni.toString(),
                            style: AppStyle.medium(AppColor.black),
                          ),
                          Text(
                            priceFormat.format(widget.data.sklRevTov[index].snarhi *  widget.data.sklRevTov[index].fSoni),
                            style: AppStyle.medium(AppColor.black),
                          ),
                          Text(
                            priceFormatUsd.format(widget.data.sklRevTov[index].snarhiS *  widget.data.sklRevTov[index].fSoni),
                            style: AppStyle.medium(AppColor.black),
                          )
                        ]),
                      ]),
                ],
                // children: [
                //   Text("Ombor",style: AppStyle.medium(AppColor.black),),
                //   Row(
                //     children: [
                //       Expanded(child: Text("Soni",style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text("So'm",style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text("\$",style: AppStyle.medium(AppColor.black),)),
                //     ],
                //   ),
                //   Row(
                //     children: [
                //       Expanded(child: Text(widget.data.sklRevTov[index].soni.toString(),style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text(priceFormat.format(widget.data.sklRevTov[index].snarhi),style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text(priceFormatUsd.format(widget.data.sklRevTov[index].snarhiS),style: AppStyle.medium(AppColor.black),)),
                //     ],
                //   ),
                //   Container(width: MediaQuery.of(context).size.width,height: 1,color:AppColor.grey,margin: EdgeInsets.symmetric(vertical: 4.w),),
                //   Text("Reviziya",style: AppStyle.medium(AppColor.black),),
                //   Row(
                //     children: [
                //       Expanded(child: Text("Soni",style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text("So'm",style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text("\$",style: AppStyle.medium(AppColor.black),)),
                //     ],
                //   ),
                //   Row(
                //     children: [
                //       Expanded(child: Text(widget.data.sklRevTov[index].soni.toString(),style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text(priceFormat.format(widget.data.sklRevTov[index].snarhi),style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text(priceFormatUsd.format(widget.data.sklRevTov[index].snarhiS),style: AppStyle.medium(AppColor.black),)),
                //     ],
                //   ),
                //   Container(width: MediaQuery.of(context).size.width,height: 1,color:AppColor.grey,margin: EdgeInsets.symmetric(vertical: 4.w),),
                //   Text("Farqi",style: AppStyle.medium(AppColor.black),),
                //   Row(
                //     children: [
                //       Expanded(child: Text("Soni",style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text("So'm",style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text("\$",style: AppStyle.medium(AppColor.black),)),
                //     ],
                //   ),
                //   Row(
                //     children: [
                //       Expanded(child: Text(widget.data.sklRevTov[index].soni.toString(),style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text(priceFormat.format(widget.data.sklRevTov[index].snarhi),style: AppStyle.medium(AppColor.black),)),
                //       Expanded(child: Text(priceFormatUsd.format(widget.data.sklRevTov[index].snarhiS),style: AppStyle.medium(AppColor.black),)),
                //     ],
                //   ),
                // ],
              ),
            );
          }),
    );
  }
}
