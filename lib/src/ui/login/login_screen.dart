// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/theme/colors.dart';
import 'package:naqshrevision/src/theme/fonts.dart';
import 'package:naqshrevision/src/ui/home/home_screen.dart';
import 'package:naqshrevision/src/utils/cache.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
TextEditingController _controllerName = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();
TextEditingController _controllerBase = TextEditingController();
Repository _repository = Repository();
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.card,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding:  EdgeInsets.only(left: 16.0.w,bottom: 12.h),
            child: Text("Tizimga kirish",style: AppStyle.large(AppColor.black),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 16.0.w),
            child: Text("Ism kiriting",style: AppStyle.small(AppColor.black),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            child: TextField(
              controller: _controllerName,
              style: TextStyle(color: AppColor.black),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Ism",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 16.0.w,top: 8.h),
            child: Text("Parol kiriting",style: AppStyle.small(AppColor.black),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            child: TextField(
              controller: _controllerPassword,
              style: TextStyle(color: AppColor.black),
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Parol raqami",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 16.0.w,top: 9.h),
            child: Text("Baza raqam kiriting",style: AppStyle.small(AppColor.black),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            child: TextField(
              controller: _controllerBase,
              style: TextStyle(color: AppColor.black),
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Baza raqami",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: ()async{
              HttpResult res = await _repository.login(_controllerName.text, _controllerPassword.text, _controllerBase.text);
              if(res.result["status"] == true){
                CacheService.id(res.result["id"]);
                CacheService.saveToken(res.result["jwt"]);
                CacheService.saveClientName(_controllerName.text);
                CacheService.savePassword(_controllerPassword.text);
                CacheService.saveDb(_controllerBase.text);
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                  return const HomeScreen();
                }));
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.green
              ),
              height: 50.w,
              child: Text("Kirish",style: AppStyle.large(AppColor.black),),
            ),
          ),
          SizedBox(height: 24.w,)
        ],
      ),
    );
  }
}
