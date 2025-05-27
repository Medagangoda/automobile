import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductsScreen extends StatefulWidget {
  static const String id = 'productsScreen';

  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final TextEditingController _sizeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  
  final List<String> _categoryList = [];

// uploading the values stored in the fire store database

  final List<String> _sizeList = [];
  String? selectedCategory;
  late String productName;
  late num productPrice;
  late num discount;
  late num quantity;
  late String description;

  bool _isEntered = false;

  final List<Uint8List> _images = [];
  final List<String> _imagesUrls = [];

  chooseImage() async {
    final pickedImages = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (pickedImages == null) {
     // print('No Image Picked');
    } else {
      setState(() {
        for (var file in pickedImages.files) {
          _images.add(file.bytes!);
        }
      });
    }
  }

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querysnapshot) {
      for (var doc in querysnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategories();
    // TODO: implement initState
    super.initState();
  }

  //upload product images
  uploadImageToStorage() async {
    for (var img in _images) {
      Reference ref =
          _firebaseStorage.ref().child('productImages').child(Uuid().v4());
      await ref.putData(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imagesUrls.add(value);
          });
        });
      });
    }
  }

  // function to upload product firebase
  uploadData() async {
    setState(() {
      _isLoading = true;
    });
    await uploadImageToStorage();
    if (_imagesUrls.isNotEmpty) {
      final productId = Uuid().v4();
      await _firestore.collection('products').doc(productId).set({
        'productId': productId,
        'productName': productName,
        'productPrice': productPrice,
        'discount': discount,
        'quantity': quantity,
        'description': description,
        'category': selectedCategory,
        'productSize': _sizeList,
        'productImage': _imagesUrls,
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
          _formKey.currentState!.reset();
          _imagesUrls.clear();
          _images.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // over size controll widged
      child: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  productName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Faild';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter product name',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    onChanged: (value) {
                      productPrice = double.parse(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Faild';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter product Price',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: buildDropdownField(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  discount = int.parse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Faild';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Discount Price',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Faild';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  description = value;
                },
                maxLength: 800,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Faild';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter Description',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _sizeController,
                        onChanged: (value) {
                          setState(() {
                            _isEntered = true;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Add Size',
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _isEntered == true
                      ? Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _sizeList.add(_sizeController.text);
                                _sizeController.clear();
                              });
                            },
                            child: Text('Add'),
                          ),
                        )
                      : const Text(''),
                ],
              ),
              _sizeList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _sizeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _sizeList.removeAt(index);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _sizeList[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : Text(''),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                itemCount: _images.length + 1,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                              onPressed: () {
                                chooseImage();
                              },
                              icon: const Icon(Icons.add)),
                        )
                      : Image.memory(_images[index - 1]);
                },
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    uploadData();
                  } else {
                    print('bad status');
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: _isLoading? const CircularProgressIndicator(color: Colors.white) :Center(
                    child: Text(
                      'Upload Product',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Select Category',
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: _categoryList.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedCategory = value;
          });
        }
      },
    );
  }
}
