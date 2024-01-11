import 'package:flutter/material.dart';
import 'package:naqshrevision/src/bloc/revision/revision_bloc.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/theme/colors.dart';

class UpdateCartRevision extends StatelessWidget {
  final RevisionModel data;
  const UpdateCartRevision({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.card,
      body: StreamBuilder<RevisionModel>(
          stream: revisionBloc.getRevisionStream,
        builder: (context, snapshot) {
          return ListView.builder(itemBuilder: (ctx,index){
            return Container(
              child: Text(''),
            );
          });
        }
      ),
    );
  }
}
