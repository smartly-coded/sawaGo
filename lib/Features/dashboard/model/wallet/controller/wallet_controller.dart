// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sawago/Features/dashboard/model/wallet/model/wallet_model.dart';

// class WalletController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // إضافة عملية
//  Future<void> addTransaction({
//   required String userId,
//   required double amount,
//   required String type, 
//   String description = '',
// }) async {
//   final walletRef = _firestore.collection('wallets').doc(userId);
//   final txnRef = walletRef.collection('transactions').doc();

//   try {
//     await _firestore.runTransaction((transaction) async {
//       // 1. جميع عمليات القراءة أولاً (مطلوب في transactions)
//       final walletSnapshot = await transaction.get(walletRef);
      
//       // 2. إذا لم توجد المحفظة، ننشئها أولاً
//       if (!walletSnapshot.exists) {
//         // هذا يعتبر create وهو مسموح في القواعد
//         transaction.set(walletRef, {
//           "balance": 0.0,
//           "createdAt": FieldValue.serverTimestamp(),
//         });
//       }
      
//       // 3. حساب الرصيد الجديد
//       double currentBalance = walletSnapshot.exists ? 
//           (walletSnapshot.data()?['balance'] ?? 0.0).toDouble() : 0.0;
//       double newBalance = type == 'credit' ? currentBalance + amount : currentBalance - amount;

//       // 4. التحقق من أن الرصيد لا يصبح سالباً
//       if (newBalance < 0 && type == 'debit') {
//         throw Exception('رصيد غير كافي');
//       }

//       // 5. إضافة المعاملة (مسموح create في القواعد)
//       transaction.set(txnRef, {
//         'type': type,
//         'amount': amount,
//         'description': description,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       // 6. تحديث رصيد المحفظة (مسموح update في القواعد)
//       transaction.update(walletRef, {
//         'balance': newBalance,
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//     });
//   } catch (e) {
//     print('Error in addTransaction: $e');
//     rethrow;
//   }
// }
//   // Stream للرصيد
//   Stream<double> walletBalanceStream(String userId) {
//     return _firestore.collection('wallets').doc(userId)
//         .snapshots()
//         .handleError((error) {
//           print('Error in wallet balance stream: $error');
//         })
//         .map((snapshot) {
//           if (!snapshot.exists) return 0.0;
//           final data = snapshot.data();
//           return data != null ? (data['balance'] ?? 0.0).toDouble() : 0.0;
//         });
//   }

//   // Stream للمعاملات - التصحيح هنا
//   // Stream للمعاملات - التصحيح النهائي
// Stream<List<TransactionModel>> transactionsStream(String userId) {
//   return _firestore
//       .collection('wallets')
//       .doc(userId)
//       .collection('transactions') // هذه subcollection وليست collection منفصلة
//       .orderBy('timestamp', descending: true)
//       .snapshots()
//       .handleError((error) {
//         print('Error in transactions stream: $error');
//       })
//       .map((snapshot) {
//         if (snapshot.size == 0) {
//           print('لا توجد معاملات في subcollection');
//           return [];
//         }
        
//         return snapshot.docs.map((doc) {
//           print('معاملة موجودة: ${doc.data()}');
//           return TransactionModel.fromMap(doc.data(), doc.id);
//         }).toList();
//       });
// }
//   // الحصول على الرصيد الحالي
//   Future<double> getCurrentBalance(String userId) async {
//     try {
//       final doc = await _firestore.collection('wallets').doc(userId).get();
//       if (doc.exists) {
//         return (doc.data()?['balance'] ?? 0.0).toDouble();
//       }
//       return 0.0;
//     } catch (e) {
//       print('Error getting balance: $e');
//       return 0.0;
//     }
//   }

//   // دالة للمساعدة في تشخيص المشكلة
// Future<void> debugWalletStructure(String userId) async {
//   try {
//     final walletDoc = await _firestore.collection('wallets').doc(userId).get();
//     print('المحفظة موجودة: ${walletDoc.exists}');
    
//     if (walletDoc.exists) {
//       print('بيانات المحفظة: ${walletDoc.data()}');
      
//       // التحقق من existence of transactions subcollection
//       final transactions = await _firestore.collection('wallets')
//           .doc(userId)
//           .collection('transactions')
//           .get();
      
//       print('عدد المعاملات: ${transactions.size}');
      
//       for (var doc in transactions.docs) {
//         print('معاملة: ${doc.data()}');
//       }
//     }
//   } catch (e) {
//     print('خطأ في فحص الهيكل: $e');
//   }
// }



// }