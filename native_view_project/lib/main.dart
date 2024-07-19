import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Native view Example"),
        ),
        body: const NativeViewList(),
        floatingActionButton: Builder(builder: (builderContext) {
          return FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                context: builderContext,
                isScrollControlled: true,
                useSafeArea: true,
                isDismissible: true,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                builder: (context) {
                  return const NativeViewList();
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class NativeViewList extends StatelessWidget {
  const NativeViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 100, color: Colors.green),
          Expanded(
            child: ListView.separated(
              itemCount: 150,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                // This is used in the platform side to register the view.
                const String viewType = '<native_view>';
                // Pass parameters to the platform side.
                final Map<String, dynamic> creationParams = <String, dynamic>{};

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 300,
                          height: 210,
                          color: Colors.red,
                        ),
                        Container(
                          width: 300,
                          height: 210,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          child: UiKitView(
                            viewType: viewType,
                            layoutDirection: TextDirection.ltr,
                            creationParams: creationParams,
                            creationParamsCodec: const StandardMessageCodec(),
                          ),
                        ),
                      ],
                    ),
                    Text("${index}"),
                    Container(
                      child: Text("Hello"),
                    )
                  ],
                );
              },
            ),
          ),
          Container(height: 100, color: Colors.amber)
        ],
      ),
    );
  }
}

// class FlutterViewList extends StatefulWidget {
//   const FlutterViewList({Key? key}) : super(key: key);
//
//   @override
//   State<FlutterViewList> createState() => _FlutterViewListState();
// }
//
// class _FlutterViewListState extends State<FlutterViewList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 150,
//       itemBuilder: (context, index) {
//         return Container(
//           margin: const EdgeInsets.all(20),
//           width: 300,
//           height: 150,
//           color: Colors.red,
//           child: Center(
//             child: Text(
//               "$index",
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
