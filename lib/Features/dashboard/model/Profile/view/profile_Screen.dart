import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/Profile/Controller/profile_controller.dart';
import 'package:sawago/Features/dashboard/model/Profile/model/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileModel>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                title: const Text(
                  "الملف الشخصي",
                  style: TextStyle(color: Color(0xFF204F38)),
                ),
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
                            const SizedBox(width: 15),
                            const Row(
                              children: [
                                Icon(Icons.add_rounded,
                                    size: 20,
                                    color: Color.fromRGBO(85, 85, 85, 1)),
                                SizedBox(height: 4),
                                Text(
                                  "أضف صورة ",
                                  style: TextStyle(
                                    color: Color.fromRGBO(85, 85, 85, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "شيماء محمد",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text("حساب جديد",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "تعديل معلومات الملف الشخصي",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildEditableField(
                      context,
                      cubit,
                      state,
                      "الاسم الأول",
                      state.firstName,
                      onChanged: cubit.updateFirstName,
                    ),
                    _buildEditableField(
                      context,
                      cubit,
                      state,
                      "الاسم الآخر",
                      state.lastName,
                      onChanged: cubit.updateLastName,
                    ),
                    _buildEditableField(
                      context,
                      cubit,
                      state,
                      "تاريخ الميلاد",
                      state.birthDate,
                      onChanged: cubit.updateBirthDate,
                    ),
                    _buildEditableField(
                      context,
                      cubit,
                      state,
                      "البريد الالكتروني",
                      state.email,
                      onChanged: cubit.updateEmail,
                    ),
                    _buildEditableField(
                      context,
                      cubit,
                      state,
                      "رقم الهاتف",
                      state.phone,
                      onChanged: cubit.updatePhone,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.bio.isEmpty
                                ? "أضف نبذة شخصية خاصة بك"
                                : state.bio,
                            style: TextStyle(
                              color: state.bio.isEmpty
                                  ? const Color(0xFF02C35E)
                                  : Colors.black,
                              fontWeight: state.bio.isEmpty
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () {
                            _showBioDialog(context, cubit, state.bio);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableField(
    BuildContext context,
    ProfileCubit cubit,
    ProfileModel state,
    String label,
    String value, {
    required Function(String) onChanged,
  }) {
    final isEditable = state.editableFields[label] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF02C35E), fontSize: 14)),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            initialValue: value,
            enabled: isEditable,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: label,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              suffixIcon: IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () => cubit.toggleEdit(label),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _showBioDialog(
    BuildContext context,
    ProfileCubit cubit,
    String currentBio,
  ) {
    final controller = TextEditingController(text: currentBio);
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
  }
}
