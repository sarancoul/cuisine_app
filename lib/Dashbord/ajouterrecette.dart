import 'package:flutte_cuisine/Dashbord/ajouterrecette_seconde.dart';
import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/Model/Recette_Model.dart';
import 'package:flutte_cuisine/Service/HtppUploadFileService.dart';
import 'package:flutte_cuisine/provider/util_provider.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AjouterRecetteDash extends StatefulWidget {
  Recette? recette;
  AjouterRecetteDash({super.key, this.recette});

  @override
  State<AjouterRecetteDash> createState() => _AjouterRecetteDashState();
}

class _AjouterRecetteDashState extends State<AjouterRecetteDash> {
  List ingredients = [1];
  bool initReader = true;
  var _image;
  var _video;
  var editImg = false;
  var editVideo = false;
  var newR = true;
  // final Uint8List _webImage = Uint8List(8);
  final picker = ImagePicker();
  late Recette recette;
  final TextEditingController _nameRecette = TextEditingController();
  final TextEditingController _descriptionRecette = TextEditingController();
  //final TextEditingController _imageRecette = TextEditingController();
  //final TextEditingController _videoRecette = TextEditingController();
  List<Ingredient> _ingredientList = [];
  var _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Recette? recetteOld = context.read<UtilProvider>().recette;
    print("building");
    print(recetteOld.description);
    print(recetteOld != null);
    // ignore: unnecessary_null_comparison
    if (_image == null && recetteOld != null && recetteOld.nom != null) {
      print("building checking");
      if (recetteOld.photo is XFile) {
        // recetteOld.photo = recetteOld.photo.path;
      }
      if (recetteOld.video is XFile) {
        recetteOld.video = recetteOld.video.path;
      }
      recetteOld.ingredientList ??= [];
      _nameRecette.text = recetteOld.nom!;
      _descriptionRecette.text = recetteOld.description!;
      _image = recetteOld.photo is XFile
          ? recetteOld.photo
          : apiImageUrl + recetteOld.photo;
      _video = apiVideoUrl + recetteOld.video;
      _ingredientList = recetteOld.ingredientList!;
      newR = false;
      //_controller =
    }

    print("building 2");
    _controller = _video is String
        ? VideoPlayerController.networkUrl(Uri.parse(_video))
        : Image.asset("assets/images/iconeVideo.png");
    if (_controller is VideoPlayerController) {
      _controller.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (initReader) {
          setState(() {
            initReader = false;
          });
        }
      });
    }

    print(_image is String);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 0),
                Image.asset(
                  "assets/images/icone.png",
                  height: 50,
                  width: 200,
                ),
                const Text(
                  "Ajouter une recette",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextFormField(
                              controller: _nameRecette,
                              decoration: const InputDecoration(
                                hintText: 'Nom de la recette recette',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextFormField(
                              controller: _descriptionRecette,
                              decoration: const InputDecoration(
                                hintText: 'Déscription',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 243, 243),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  showOptions();
                                  //debugPrint(_image!.path);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: _image != null
                                      ? Image.network(_image is String
                                          ? _image
                                          : _image!.path)
                                      : Image.asset(
                                          "assets/images/iconeImage.png"),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !newR,
                            child: Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20))),
                                child: InkWell(
                                  onTap: () => editImg
                                      ? HttpUploadService.updateImage(
                                          photoName: recetteOld.photo,
                                          image: _image)
                                      : showOptions(),
                                  child: Icon(
                                    editImg ? Icons.save : Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 243, 243),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              showOptions(img: false);
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: _controller is VideoPlayerController
                                      ? VideoPlayer(_controller)
                                      : Image.asset(
                                          "assets/images/iconeVideo.png"),
                                ),
                                Visibility(
                                  visible: !newR,
                                  child: Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: InkWell(
                                        onTap: () => editVideo
                                            ? HttpUploadService.updateVideo(
                                                videoName: recetteOld.video,
                                                video: _video)
                                            : showOptions(img: false),
                                        child: Icon(
                                          editVideo ? Icons.save : Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: const EdgeInsets.all(10),
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              print("----------------------");
                              print(_nameRecette.text);
                              print(_image);
                              print(recetteOld.id);
                              // RecetteService(recette:
                              recette = Recette(
                                  // id: recetteOld!.id,
                                  nom: _nameRecette.text,
                                  description: _descriptionRecette.text,
                                  photo: _image,
                                  video: _video!,
                                  ingredientList: _ingredientList);
                              if (recetteOld.id != null) {
                                recette.id = recetteOld.id;
                              }
                              debugPrint('la recette : ${recette.description}');
                              //);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           AjouterRecetteDashSecondePage(
                              //               recette: recette),
                              //     ));

                              print("j'appuie sur suivant");
                              print(recette.toJson());
                              context.read<UtilProvider>().setRecette(recette);
                              context
                                  .read<UtilProvider>()
                                  .setdashboardCurrentIndex(UtilProvider()
                                      .getIndex(AjouterRecetteSecondePageDash));
                              // widget.changePage(recette);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Suivant',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //avoir une video depuis la galerie
  Future getVideoFromGallery() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    // picker.get

    setState(() {
      if (pickedFile != null) {
        _video = pickedFile;
        editVideo = true;
        // File(pickedFile.path);
      }
    });
  }

  //avoir une video depuis la camera
  Future getVideoFromCamera() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _video = pickedFile;
        editVideo = true;
        //  File(pickedFile.path);
      }
    });
  }

  //fonction mise en place pour avoir une photo depuis la galerie
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // picker.get
    //var f = null;
    // if (pickedFile != null) f = await pickedFile.readAsBytes();

    setState(() {
      if (pickedFile != null) {
        print("je change de valeur");
        _image = pickedFile;
        editImg = true;

        print("voici le nom de la photo => ${pickedFile.path}");
      }
    });
  }

  //Ifonction mise en place pour avoir une photo depuis la camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        editImg = true;
        // File(pickedFile.path);
      }
    });
  }

  Future showOptions({img = true}) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text("Gallery"),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              if (!img) {
                getVideoFromGallery();
              } else {
                getImageFromGallery();
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              if (!img) {
                getVideoFromCamera();
              } else {
                getImageFromCamera();
              }
            },
          ),
        ],
      ),
    );
  }

  // Dismissible ajouterIngredient(int index) {
  //   return Dismissible(
  //     key: GlobalKey(),
  //     direction: ingredients.length > 1
  //         ? DismissDirection.startToEnd
  //         : DismissDirection.none,
  //     onDismissed: (direction) {
  //       setState(() {
  //         ingredients.removeAt(index);
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width * 0.8,
  //         // height: 100,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //         child: Row(
  //           children: [
  //             const Icon(Icons.drag_indicator),
  //             Expanded(
  //               child: Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: 5),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: const TextField(
  //                   decoration: InputDecoration(
  //                     hintText: 'Ingrédient',
  //                     border: InputBorder.none,
  //                     contentPadding: EdgeInsets.all(10),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: 5),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: const TextField(
  //                   decoration: InputDecoration(
  //                     hintText: 'Prix',
  //                     border: InputBorder.none,
  //                     contentPadding: EdgeInsets.all(10),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Expanded(child: TextFormField()),
  //             //Expanded(child: TextFormField())
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
