import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeProvider provider;

  @override
  void initState() {
    provider = Provider.of<HomeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Upload"),
        centerTitle: true,
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, _) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return buildBottomSheet();
                        });
                  },
                  child: const Text("Select Image")),
            ),
            if (provider.isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black38,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
          ],
        );
      }),
    );
  }

  Widget buildBottomSheet() {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: Column(
        children: [
          const Divider(
            height: 1,
            color: Colors.blue,
          ),
          ListTile(
            onTap: () {
              provider.pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
            title: const Text("Camera"),
            leading: const Icon(
              Icons.camera,
              color: Colors.blue,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.blue,
          ),
          ListTile(
            onTap: () {
              provider.pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
            title: const Text("Gallery"),
            leading: const Icon(
              Icons.photo,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
