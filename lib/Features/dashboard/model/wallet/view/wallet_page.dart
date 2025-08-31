// import 'package:flutter/material.dart';
// import 'package:sawago/Features/dashboard/model/wallet/controller/wallet_controller.dart';
// import 'package:sawago/Features/dashboard/model/wallet/model/wallet_model.dart';

// class WalletPage extends StatefulWidget {
//   final String userId;
//   const WalletPage({super.key, required this.userId});

//   @override
//   State<WalletPage> createState() => _WalletPageState();
// }

// class _WalletPageState extends State<WalletPage> {
//   final WalletController controller = WalletController();
//   double currentBalance = 0.0;
//   bool _isLoading = true;
//   String? _errorMessage;

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   String _selectedType = 'credit';

//   @override
//   void initState() {
//     super.initState();
//     _loadInitialData();
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//     controller.debugWalletStructure(widget.userId);
//   });
//   }

//   Future<void> _loadInitialData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
    
//     try {
//       final balance = await controller.getCurrentBalance(widget.userId);
//       setState(() => currentBalance = balance);
//     } catch (e) {
//       setState(() => _errorMessage = 'فشل تحميل البيانات: ${e.toString()}');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _submitTransaction() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       try {
//         final amount = double.parse(_amountController.text.trim());
//         final description = _descriptionController.text.trim();

//         await controller.addTransaction(
//           userId: widget.userId,
//           amount: amount,
//           type: _selectedType,
//           description: description.isNotEmpty ? description : 'بدون وصف',
//         );

//         _amountController.clear();
//         _descriptionController.clear();
        
//         // تحديث الرصيد بعد الإضافة
//         final newBalance = await controller.getCurrentBalance(widget.userId);
//         setState(() => currentBalance = newBalance);
        
//         Navigator.of(context).pop();
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('تمت إضافة المعاملة بنجاح')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('خطأ: ${e.toString()}')),
//         );
//       } finally {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _showAddTransactionDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('إضافة معاملة'),
//         content: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               DropdownButtonFormField<String>(
//                 value: _selectedType,
//                 items: const [
//                   DropdownMenuItem(value: 'credit', child: Text('إيداع')),
//                   DropdownMenuItem(value: 'debit', child: Text('سحب')),
//                 ],
//                 onChanged: (val) {
//                   if (val != null) setState(() => _selectedType = val);
//                 },
//                 decoration: const InputDecoration(labelText: 'نوع المعاملة'),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'المبلغ',
//                   prefixText: 'ج.م ',
//                 ),
//                 validator: (val) {
//                   if (val == null || val.isEmpty) return 'يرجى إدخال المبلغ';
//                   final parsed = double.tryParse(val);
//                   if (parsed == null) return 'يرجى إدخال رقم صحيح';
//                   if (parsed <= 0) return 'يجب أن يكون المبلغ أكبر من الصفر';
//                   if (_selectedType == 'debit' && parsed > currentBalance) {
//                     return 'الرصيد غير كافي';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(labelText: 'الوصف (اختياري)'),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
//             child: const Text('إلغاء'),
//           ),
//           ElevatedButton(
//             onPressed: _isLoading ? null : _submitTransaction,
//             child: _isLoading 
//                 ? const SizedBox(
//                     width: 16,
//                     height: 16,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                 : const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('محفظتي')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(_errorMessage!),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: _loadInitialData,
//                       child: const Text('إعادة المحاولة'),
//                     ),
//                   ],
//                 ),
//               )
//             : Column(
//                 children: [
//                   // عرض الرصيد
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         const Text('الرصيد الحالي', style: TextStyle(fontSize: 16)),
//                         const SizedBox(height: 8),
//                         Text(
//                           'ج.م ${currentBalance.toStringAsFixed(2)}',
//                           style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(),
//                   // قائمة المعاملات
//                   Expanded(
//                     child: StreamBuilder<List<TransactionModel>>(
//                       stream: controller.transactionsStream(widget.userId),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return const Center(child: CircularProgressIndicator());
//                         }
                        
//                         if (snapshot.hasError) {
//                           return Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('خطأ: ${snapshot.error}'),
//                                 const SizedBox(height: 16),
//                                 ElevatedButton(
//                                   onPressed: _loadInitialData,
//                                   child: const Text('إعادة المحاولة'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
                        
//                         final transactions = snapshot.data ?? [];
                        
//                         if (transactions.isEmpty) {
//                           return const Center(
//                             child: Text('لا توجد معاملات حتى الآن'),
//                           );
//                         }
                        
//                         return ListView.builder(
//                           itemCount: transactions.length,
//                           itemBuilder: (context, index) {
//                             final txn = transactions[index];
//                             return ListTile(
//                               leading: Icon(
//                                 txn.type == 'credit' ? Icons.add : Icons.remove,
//                                 color: txn.type == 'credit' ? Colors.green : Colors.red,
//                               ),
//                               title: Text(
//                                 'ج.م ${txn.amount.toStringAsFixed(2)}',
//                                 style: TextStyle(
//                                   color: txn.type == 'credit' ? Colors.green : Colors.red,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Text(txn.description),
//                               trailing: Text(
//                                 _formatDate(txn.timestamp),
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddTransactionDialog,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }