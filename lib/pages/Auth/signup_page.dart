import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_26_9/core/app_constants/app_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.isDoctor});
  final bool isDoctor;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final emailcont = TextEditingController();
  final passcont = TextEditingController();
  final namecont = TextEditingController();
  final specialistcont = TextEditingController();

  bool isLoading = false;
  bool isObscure = true;

  @override
  void dispose() {
    emailcont.dispose();
    passcont.dispose();
    namecont.dispose();
    specialistcont.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcont.text.trim(),
        password: passcont.text.trim(),
      );

      final uid = cred.user!.uid;

      if (widget.isDoctor) {
        await FirebaseFirestore.instance.collection("doctors").doc(uid).set({
          "uid": uid,
          "name": namecont.text.trim(),
          "specialist": specialistcont.text.trim(),
          "email": emailcont.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });
      } else {
        await FirebaseFirestore.instance.collection("patients").doc(uid).set({
          "uid": uid,
          "name": namecont.text.trim(),
          "email": emailcont.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم إنشاء الحساب بنجاح"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "حدث خطأ"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  InputDecoration _decoration({required String hint, required IconData icon, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:  BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/Glossy Blue Healthcare Cross Emblem.png",
                height: 120,
              ),
              const SizedBox(height: 10),
              Text(
                "إنشاء حساب كـ ${widget.isDoctor ? "دكتور" : "مريض"}",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isDoctor ? "انضم كطبيب وابدأ بمساعدة المرضى" : "انضم إلينا للحصول على رعاية أفضل",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 30),

              // Card Form
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: namecont,
                      validator: (v) => v!.trim().isEmpty ? "الاسم مطلوب" : null,
                      decoration: _decoration(hint: "الاسم بالكامل", icon: Icons.person_outline),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailcont,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v!.trim().isEmpty) return "البريد مطلوب";
                        if (!v.contains("@")) return "البريد غير صحيح";
                        return null;
                      },
                      decoration: _decoration(hint: "البريد الإلكتروني", icon: Icons.email_outlined),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passcont,
                      obscureText: isObscure,
                      validator: (v) => v!.length < 6 ? "كلمة المرور 6 أحرف على الأقل" : null,
                      decoration: _decoration(
                        hint: "كلمة المرور",
                        icon: Icons.lock_outline,
                        suffix: IconButton(
                          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => isObscure = !isObscure),
                        ),
                      ),
                    ),
                    if (widget.isDoctor) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: specialistcont,
                        validator: (v) => widget.isDoctor && v!.trim().isEmpty ? "التخصص مطلوب" : null,
                        decoration: _decoration(hint: "التخصص - مثال: قلب، أسنان", icon: Icons.medical_services_outlined),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 22, width: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          "إنشاء حساب",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("لديك حساب بالفعل؟ "),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("تسجيل الدخول", style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}