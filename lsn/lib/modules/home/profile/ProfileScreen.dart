import 'dart:io';

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lsn/base/screen/BaseScreen.dart';
import 'package:lsn/base/screen/Screens.dart';
import 'package:lsn/base/style/BaseStyle.dart';
import 'package:lsn/component/FeatureComponent.dart';
import 'package:lsn/component/ProfileComponent.dart';
import 'package:lsn/items/CollectionItem.dart';
import 'package:lsn/util/DialogUtil.dart';

class ProfileScreen extends BaseScreen {
  File file;

  @override
  Widget onInitBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// Background top
        _backgroundTop(),

        /// Personal
        _content(),
      ],
    );
  }

  Widget _content() {
    return Positioned(
        child: Container(
            child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        /// Personal
        _personal(),

        /// Show collection
        _showCollection(),
      ],
    )));
  }

  Widget _personal() {
    return Container(
        margin:
            EdgeInsets.only(top: margin100, right: margin40, left: margin40),
        child: Stack(
          children: <Widget>[
            /// Card info
            _cardInfo(),

            /// Avatar
            _avatar(),
          ],
        ));
  }

  Widget _subInfo() {
    return Container(
        margin: EdgeInsets.only(
            left: margin20, right: margin20, top: margin10, bottom: margin20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Post
            InkWell(
                onTap: () {
                  pushScreen(
                      context,
                      BaseWidget(
                        screen: Screens.VIEW_POST,
                      ));
                },
                child: Column(
                  children: <Widget>[
                    Text('20', style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                        child: Text('POSTS',
                            style: TextStyle(
                                color: Colors.black45, fontSize: font12))),
                  ],
                )),

            /// Subscriber
            Expanded(
              child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Text('2k', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                          child: Text('SUBSCRIBERS',
                              style: TextStyle(
                                  color: Colors.black45, fontSize: font12))),
                    ],
                  )),
            ),

            /// Following
            InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Text('12', style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      child: Text('FOLLOWING',
                          style: TextStyle(
                              color: Colors.black45, fontSize: font12))),
                ],
              ),
            )
          ],
        ));
  }

  Widget _backgroundTop() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(color: Colors.teal[200]),
        height: height150,
      ),
    );
  }

  Future _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    setState(() {
      file = image;
    });

//    await CompressUtil().compressPath(file.path);
  }

  Future _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
//    await CompressUtil().compressPath(image.path);

    setState(() {
      file = image;
    });
  }

  ImageProvider get _getImageFile {
    ImageProvider photo;
    if (file == null) {
      photo = AssetImage('assets/images/admin.jpg');
    } else {
      photo = FileImage(File(file.path));
    }
    return photo;
  }

  Widget _avatar() {
    return FractionalTranslation(
      translation: Offset(0.0, -0.5),
      child: Align(
        child: InkWell(
            onTap: () {
              DialogUtil().showPhotoDialog(context,

                  /// View avatar
                  onView: () {},

                  /// Open camera
                  onCamera: () async => await _openCamera(),

                  /// Open gallery
                  onGallery: () async => await _openGallery());
            },
            child: Container(
                height: height100,
                width: width100,
                constraints:
                    BoxConstraints.expand(height: height100, width: width100),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: width1, color: whiteColor),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: _getImageFile)),
                child: Container(
                    height: height25,
                    width: width25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                        border: Border.all(width: width1, color: whiteColor)),
                    child: Icon(
                      Icons.add_a_photo,
                      size: size15,
                    )))),
        alignment: FractionalOffset(0.5, 0.0),
      ),
    );
  }

  Widget _showCollection() {
    return Container(
      margin: EdgeInsets.only(top: margin10),
      color: whiteColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.only(
                          top: margin10, left: margin20, bottom: margin10),
                      child: Text(
                        'Collection',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
              InkWell(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.only(
                          top: margin10, right: margin20, bottom: margin10),
                      child: Text(
                        'Create new',
                        style: TextStyle(color: blueColor),
                      ))),
            ],
          ),

          /// Photos
          Container(
              color: whiteColor,
              height: height150,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
//                  Image.network(
//                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRwlwvk3IDwOXiIQ4SVjpbz2rFmmNo2lbhzwp3JtttqJ_EIZWyo',
//                    width: 150,
//                  ),

                  CollectionItem(),
                  CollectionItem(),
                  CollectionItem(),
                ],
              ))
        ],
      ),
    );
  }

  Widget _cardInfo() {
    return Card(
        elevation: elevation4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius8))),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              children: <Widget>[
                /// Distance
                SizedBox(height: height30),

                /// Name
                Container(
                    margin: EdgeInsets.only(top: margin20),
                    child: Text('Jack Le',
                        style: TextStyle(
                            fontSize: font16, fontWeight: FontWeight.bold))),

                /// Description

                Container(
                    decoration: BoxDecoration(color: desColor),
                    padding: EdgeInsets.all(padding10),
                    margin: EdgeInsets.only(
                        top: margin5, left: margin20, right: margin20),
                    child: Text(
                      'I love coding, i like to create new products to deserve living demand people.',
                    )),

                /// Sub info
                _subInfo(),
              ],
            ),
          ],
        ));
  }

  Widget _showFeature() {
    return Expanded(
        child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        /// Line
        Divider(color: greyColor, height: 1.0),

        /// Edit profile
        FeatureComponent(
          text: 'Edit profile',
          icon: Icon(Icons.edit),
          onTap: () {
            pushScreen(
                context,
                BaseWidget(
                  screen: Screens.EDIT_PROFILE,
                ));
          },
        ),

        /// New features
        FeatureComponent(
          text: 'News features',
          onTap: () {
            pushScreen(
                context,
                BaseWidget(
                  screen: Screens.NEW_FEATURE,
                ));
          },
        ),
      ],
    ));
  }

  Widget _showDetail() {
    return Container(
        color: whiteColor,
        margin: EdgeInsets.only(top: margin10),
        child: ConfigurableExpansionTile(
            initiallyExpanded: false,
            animatedWidgetFollowingHeader:
                Icon(Icons.expand_more, color: whiteColor),
            headerExpanded: Flexible(
                child: Container(
                    padding: EdgeInsets.all(padding10),
                    alignment: Alignment.center,
                    child: Text(
                      'Hide detail',
                      style: TextStyle(color: whiteColor, fontSize: font16),
                    ))),
            header: Flexible(
                child: Container(
                    padding: EdgeInsets.all(padding10),
                    alignment: Alignment.center,
                    child: Text('Show detail',
                        style:
                            TextStyle(color: whiteColor, fontSize: font16)))),
            headerBackgroundColorStart: Colors.teal[200],
            headerBackgroundColorEnd: Colors.teal[200],
            children: [
              /// Phone number
              ProfileComponent(
                title: 'Phone',
                value: '093 693 xxxx',
              ),

              /// Day of birth
              ProfileComponent(
                title: 'Day of birth',
                value: '1997/02/06',
              ),

              /// Position
              ProfileComponent(
                title: 'Position',
                value: 'Mobile developer',
              ),

              /// Country
              ProfileComponent(
                title: 'Country',
                value: 'Viet Nam Country',
              ),
            ]));
  }

  @override
  BoxDecoration onInitBackground(BuildContext context) {
    return BoxDecoration(color: Colors.grey[100]);
  }
}