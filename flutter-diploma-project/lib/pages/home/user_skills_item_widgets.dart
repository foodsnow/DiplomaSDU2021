import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:diploma_flutter_app/widgets/user_profile_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UserSkillsItemWidget extends StatefulWidget {
  final Developer developer;

  const UserSkillsItemWidget({this.developer});

  @override
  createState() => _UserSkillsItemWidget();
}

class _UserSkillsItemWidget extends State<UserSkillsItemWidget> {
  var isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.developer.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 238,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getTopIsFavoriteWidget(),
            getUserTitleAndDesc(
                "${widget.developer.user.surname} ${widget.developer.user.name}",
                widget.developer.stacksId != null
                    ? widget.developer.stacksId.title
                    : ""),
            getSkillsList(widget.developer.skillsId),
            getStarsAndPrice(widget.developer.rating,
                widget.developer.ratingCount, widget.developer.price),
          ],
        ),
      ),
    );
  }

  Widget getTopIsFavoriteWidget() {
    return Container(
      constraints: BoxConstraints.expand(height: 101, width: double.infinity),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ux_image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: IconButton(
          icon: isFavorite
              ? SvgPicture.asset('assets/icons/heart_icon.svg')
              : SvgPicture.asset('assets/icons/heart_inactive_icon.svg'),
          onPressed: () {
            setState(() {
              print("DeveloperId + ${widget.developer.id}");
              isFavorite = !isFavorite;
              BlocProvider.of<HomeCubit>(context)
                ..chooseFavoriteDeveloper(widget.developer.id, isFavorite);
            });
          }),
    );
  }
}
