
import 'package:expense_tracker/login/login.dart';
import 'package:expense_tracker/reminder.dart';
import 'package:expense_tracker/services/expenseApi.dart';
import 'package:expense_tracker/services/getdashapi.dart';
import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/services/notification.dart';
import 'package:expense_tracker/services/sentcomplint.dart';
import 'package:expense_tracker/user/feedback.dart';
import 'package:expense_tracker/user/notification.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


ValueNotifier<double> totalspended = ValueNotifier(0.0);
ValueNotifier<double> totalbalance = ValueNotifier(0.0);
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = false;

  @override
  void initState() {
    fetch();
    super.initState();
  }

  void fetch() async {
    setState(() {
      isloading = true;
    });
    profiledata = await getProfile();
    await getDashboardData();
    setState(() {
      isloading = false;
    });
  }

  // Helper method to remove time from a date string.
  String getDateOnly(String dateString) {
    return dateString.contains(' ') ? dateString.split(' ')[0] : dateString;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate totalSpend from transactionHistory.
     totalspended.value = 0.0;
    for (Map item in transactionHistory) {
      final double price = item['Price'] is double
          ? item['Price']
          : (item['Price'] as num).toDouble();
      final int quantity = int.tryParse(item['Quantity'].toString()) ?? 1;
      totalspended.value += price * quantity;
    }

    // Calculate balance by subtracting totalSpend from profile total income.
     totalbalance.value = double.parse(profiledata['Totalincome']) - totalspended.value;
    balanceee = totalbalance.value;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          // Show confirmation dialog before exiting.
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Exit?"),
              content: const Text("Do you really want to go back?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // Close dialog
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () =>
                      // Navigator.of(context).pop(true), // Allow back navigation
                      SystemNavigator.pop(),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          fetch();
        },
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                  ),
                  child: const Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text("Complaint"),
                  onTap: () async {
                    List<Map<String, dynamic>> feedbacks =
                        await viewComplaints();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FeedbackComplaintForm(feedbacks: feedbacks)),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () async{
                     SharedPreferences prefs = await SharedPreferences.getInstance();
                     prefs.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: isloading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      title: const Text('Home'),
                      centerTitle: true,
                      floating: true,
                      snap: true,
                      actions: [
                   
                      ],
                    ),
                    // Spend Analysis (Chart)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Spend Analysis',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: TransactionBarChart(
                                  transactionHistory: transactionHistory),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Total Spend & Balance
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder(valueListenable: totalspended,builder: (context, value, child) =>  _buildInfoCard('Total Spend', '${totalspended.value}')),
                            ValueListenableBuilder(valueListenable: totalbalance,builder: (context, value, child) =>  _buildInfoCard('Balance', '${totalbalance.value}')),
                          ],
                        ),
                      ),
                    ),
                    // Transaction History Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Text(
                          'Transaction History',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                   
                    TransactionList(
                      transactionHistory: transactionHistory,
                     
                    )
                  ],
                ),
        ),
      ),
    );
  }

  // Helper to build the Spend and Balance cards
  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build transaction tiles.
}

// chart

class TransactionBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> transactionHistory;

  const TransactionBarChart({Key? key, required this.transactionHistory})
      : super(key: key);

  // Helper method to safely extract date from a transaction
  String? getDateOnly(String? dateString) {
    if (dateString == null) return null;
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return null; // Return null if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');

    // Prepare a map for the last 7 days with initial sum 0.
    Map<String, double> dailySums = {};
    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final dayStr = formatter.format(day);
      dailySums[dayStr] = 0.0;
    }

    // Aggregate transactions into daily sums.
    for (final transaction in transactionHistory) {
      final rawDate = transaction['Date'];
      final transactionDate = getDateOnly(rawDate);
      if (transactionDate != null && dailySums.containsKey(transactionDate)) {
        final price = (transaction['Price'] as num).toDouble();
        dailySums[transactionDate] = (dailySums[transactionDate] ?? 0) + price;
      }
    }

    // Convert dailySums into a list of BarChartGroupData.
    List<BarChartGroupData> barGroups = [];
    final dayLabels = <String>[];
    int index = 0;

    dailySums.forEach((date, sum) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: sum,
              width: 16,
              borderRadius: BorderRadius.circular(4),
              color: Colors.deepPurple,
            ),
          ],
        ),
      );

      // Bottom labels (days of the week)
      DateTime dateTime = formatter.parse(date);
      dayLabels.add(DateFormat('E').format(dateTime)); // e.g., Mon, Tue, etc.
      index++;
    });

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int idx = value.toInt();
                if (idx < 0 || idx >= dayLabels.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(dayLabels[idx],
                      style: const TextStyle(fontSize: 12)),
                );
              },
            ),
          ),
        ),
        barGroups: barGroups,
        gridData: FlGridData(show: false),
      ),
    );
  }
}

// history

class TransactionList extends StatefulWidget {
  final List<Map<String, dynamic>> transactionHistory;
  // final VoidCallback ontap;

  const TransactionList(
      {Key? key, required this.transactionHistory,})
      : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  String? getDateOnly(String? dateString) {
    if (dateString == null) return null;
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return null;
    }
  }

  // Group transactions by month and date
  Map<String, Map<String, List<Map<String, dynamic>>>> groupTransactions() {
    Map<String, Map<String, List<Map<String, dynamic>>>> groupedData = {};

    for (var transaction in widget.transactionHistory) {
      final rawDate = transaction['Date'];
      final transactionDate = getDateOnly(rawDate);

      if (transactionDate != null) {
        DateTime date = DateTime.parse(transactionDate);
        String monthKey = DateFormat('MMMM yyyy').format(date);
        String dayKey = DateFormat('yyyy-MM-dd').format(date);

        groupedData.putIfAbsent(monthKey, () => {});
        groupedData[monthKey]!.putIfAbsent(dayKey, () => []);
        groupedData[monthKey]![dayKey]!.add(transaction);
      }
    }

    return groupedData;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = groupTransactions();

      totalspended.value = 0.0;
    for (Map item in widget.transactionHistory) {
      final double price = item['Price'] is double
          ? item['Price']
          : (item['Price'] as num).toDouble();
      final int quantity = int.tryParse(item['Quantity'].toString()) ?? 1;
      totalspended.value += price * quantity;
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, monthIndex) {
          String monthKey = groupedTransactions.keys.elementAt(monthIndex);
          var monthData = groupedTransactions[monthKey]!;

          return ExpansionTile(
            title: Text(
              monthKey,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: monthData.keys.map((dayKey) {
              var dailyTransactions = monthData[dayKey]!;

              return ExpansionTile(
                title: Text(
                  DateFormat('EEE, MMM d').format(DateTime.parse(dayKey)),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                children: dailyTransactions.map((transaction) {
                
                  return _buildTransactionTile(
                      transaction['Category'],
                      getDateOnly(transaction['Date']) ?? 'Unknown date',
                      transaction['Price'].toString(),
                      transaction['Quantity'].toString(),
                      dailyTransactions.indexOf(transaction),
                      context,
                     );
                }).toList(),
              );
            }).toList(),
          );
        },
        childCount: groupedTransactions.length,
      ),
    );
  }

  Widget _buildTransactionTile(String title, String date, String amount,
      String qty, index, contextt,) {
    return Dismissible(
      resizeDuration: const Duration(milliseconds: 100),
      movementDuration: const Duration(milliseconds: 100),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
   
      onDismissed: (direction)async {
        final removedTransaction = widget.transactionHistory.removeAt(index);

    
    
 
    final double price = removedTransaction['Price'] is double
        ? removedTransaction['Price']
        : (removedTransaction['Price'] as num).toDouble();
    final int quantity = int.tryParse(removedTransaction['Quantity'].toString()) ?? 1;
    
    totalspended.value -= price * quantity; // Subtract removed amount
     totalbalance.value = double.parse(profiledata['Totalincome']) - totalspended.value;
    balanceee = totalbalance.value;


  ScaffoldMessenger.of(contextt).showSnackBar(
    SnackBar(content: Text('Transaction removed')),
  );
},

      key: Key('$title-$date-$index'),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.attach_money, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              amount,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            Text('Qty: $qty')
          ],
        ),
      ),
    );
  }
}
