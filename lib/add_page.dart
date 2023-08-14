import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nisn = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();

  Future _simpan() async {
    final res = await http.post(
        Uri.parse('http://192.168.232.225/crudflutter/public/'),
        body: {"nisn": nisn.text, "nama": nama.text, "alamat": alamat.text});

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data'),
      ),
      body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Column(children: [
              TextFormField(
                controller: nisn,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nisn tidak boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Masukkan Nisn",
                    labelText: "NISN",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: nama,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Masukkan Nama",
                    labelText: "Nama",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: alamat,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alamat tidak boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Masukkan Alamat",
                    labelText: "Alamat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) => {
                          if (value)
                            {
                              const SnackBar(
                                content: Text('Data berhasil disimpan'),
                              )
                            }
                          else
                            {
                              const SnackBar(
                                content: Text('Data gagal disimpan'),
                              )
                            }
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text('Simpan'),
              )
            ]),
          )),
    );
  }
}
