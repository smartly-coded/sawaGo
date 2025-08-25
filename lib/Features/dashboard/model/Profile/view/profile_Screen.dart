import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart';
import 'package:sawago/Features/dashboard/model/Profile/Controller/profile_controller.dart';
import 'package:sawago/Repo/profile_repository.dart';
import 'package:sawago/Services/shared_pref.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = ProfileCubit(ProfileRepository());
        SharedPrefService.getUid().then((uid) {
          if (uid != null) cubit.loadUser(uid);
        });
        return cubit;
      },
      child: BlocBuilder<ProfileCubit, UserModel>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();

          firstNameController.text = state.firstName ?? '';
          lastNameController.text = state.lastName ?? '';
          emailController.text = state.email;
          phoneController.text = state.phone ?? '';
          dobController.text = state.dateOfBirth ?? '';

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "الملف الشخصي",
                style: TextStyle(color: Color(0xFF204F38)),
              ),
              actions: [
                if (cubit.fieldsEditable)
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => cubit.updateUser(),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color.fromRGBO(222, 222, 222, 1),
                                    width: 2,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Color.fromRGBO(222, 222, 222, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(Icons.add, size: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              SizedBox(width: 5),
                              Text("أضف صورة", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.firstName != null && state.lastName != null
                                ? "${state.firstName} ${state.lastName}"
                                : "اسم المستخدم",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "تعديل معلومات الملف الشخصي",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () => cubit.toggleEditableFields(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(firstNameController, "الاسم الأول", cubit.fieldsEditable, cubit.updateFirstName),
                  _buildEditableField(lastNameController, "الاسم الآخر", cubit.fieldsEditable, cubit.updateLastName),
                  _buildEditableField(emailController, "البريد الإلكتروني", cubit.fieldsEditable, cubit.updateEmail),
                  _buildEditableField(phoneController, "رقم الهاتف", cubit.fieldsEditable, cubit.updatePhone),
                  _buildEditableField(dobController, "تاريخ الميلاد", cubit.fieldsEditable, cubit.updateDateOfBirth),
                  const SizedBox(height: 16),
                  _buildBioField(context, cubit, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableField(TextEditingController controller, String label, bool enabled, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: enabled
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              )
            : null,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF02C35E), fontWeight: FontWeight.bold),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          onChanged: onChanged,
          enabled: enabled,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  Widget _buildBioField(BuildContext context, ProfileCubit cubit, UserModel state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("نبذة شخصية", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF02C35E))),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                state.bio?.isEmpty ?? true ? "أضف نبذة شخصية خاصة بك" : state.bio!,
                style: TextStyle(
                  color: state.bio?.isEmpty ?? true ? const Color(0xFF02C35E) : Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                final controller = TextEditingController(text: state.bio ?? '');
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("أدخل نبذة شخصية"),
                    content: TextField(
                      controller: controller,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "اكتب هنا...",
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("إلغاء"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.updateBio(controller.text);
                          Navigator.pop(ctx);
                        },
                        child: const Text("حفظ"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
