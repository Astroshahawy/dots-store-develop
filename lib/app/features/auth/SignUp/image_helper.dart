import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic openImagePicker({
  BuildContext? context,
  Function()? onGalleryTapped,
  Function()? onCameraTapped,
}) {
  showCupertinoModalPopup(
      context: context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: const Text(
//              translator.currentLanguage == "en" ? "Cancel" :
              "الغاء",
              style: TextStyle(),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            CupertinoButton(
                onPressed: onCameraTapped,
                child: const Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.photo_camera_solid,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
//                      translator.currentLanguage == "en"
//                          ? "Camera"
//                          :
                      "الكاميرا",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
            CupertinoButton(
                onPressed: onGalleryTapped,
                child: const Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_photo,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
//                      translator.currentLanguage == "en"
//                          ? "Gallery"
//                          :
                      "الاستوديو",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
          ],
        );
      });
}

dynamic openImageTabletAndMobilePicker({
  BuildContext? context,
  Function()? onGalleryTapped,
  Function()? onCameraTapped,
}) {
  showCupertinoModalPopup(
      context: context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: const Text(
//              translator.currentLanguage == "en" ? "Cancel" :
              "الغاء",
              style: TextStyle(),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            CupertinoButton(
                onPressed: onCameraTapped,
                child: const Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.photo_camera_solid,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
//                      translator.currentLanguage == "en"
//                          ? "Camera"
//                          :
                      "الكاميرا",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
            CupertinoButton(
                onPressed: onGalleryTapped,
                child: const Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_photo,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
//                      translator.currentLanguage == "en"
//                          ? "Gallery"
//                          :
                      "الاستوديو",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
          ],
        );
      });
}
