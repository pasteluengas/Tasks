import 'package:flutter/material.dart';
import 'dbactions.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await init_db();
		update_array();
		
		for (var i in task_array) {
			print("${i.name} -> ${i.status}");
		}
		
		runApp(const MyApp());
		//db.dispose();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareas',
      theme: ThemeData(
    		brightness: Brightness.light,
    		primarySwatch: Colors.blue,
    		),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
              primary: Colors.grey,
              surface: Colors.black,
              background: Colors.black,
            ),
        ),
        themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Tareas'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
	List<Widget> tmp_list = [];
	final TextEditingController _controller = TextEditingController();
	for (var  i in task_array) {
		IconData icon0 = (i.name == "love" || i.name == "amar") ? Icons.favorite_border : Icons.delete_outline;//ListTile(title: Text(i.name), leading: Icon(Icons.check)
		tmp_list.add(Row(
			  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  children: [
			  	Checkbox(
			  	          tristate: true,
			  	          value: (i.status == 1) ? true : false,
			  	          onChanged: (bool? value) {
			  	            setState(() {
			  	            	if (value == true) {
			  	            		set_status(i.id, COMPLETED);	
			  	            	} else {
			  	            		set_status(i.id, UNCOMPLETED);
			  	            	}
			  	            	update_array();
			  	              //isChecked = value;
			  	            });
			  	          },
			  	        ),
			  	              
			    Expanded(
			    	child: DefaultTextStyle.merge(
			    		style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
			    		child: Text(i.name),
			    	)
			    ),
				Spacer(),
			    IconButton(
			    	icon: Icon(icon0, color: Colors.white),
			    		onPressed: () {
			    			setState(() {
			    				remove_task(i.id);
			    				update_array();
			    			});
			    		},
			    ),
			  ],
		));
	}
  
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
			// title
			DefaultTextStyle.merge(
				style: const TextStyle(fontSize: 38, fontWeight: FontWeight.normal),
				child: const Center(child: Text('Tareas')),
			),

			// The rest
			Row(
				children: [
					Expanded (
						child: Padding (
							padding: EdgeInsets.all(12),
							child: TextField(
								decoration: InputDecoration(
									border: OutlineInputBorder(),
									hintText: 'Añadir tarea',
								),
								controller: _controller,
								onSubmitted: (String value) {
									print("submited!");
									if (!value.trim().isEmpty) {
										print("Se deberia a;adir $value");
										new_task(1, value);
										_controller.clear();
										setState(() {
											print("Se setea el estate");
											update_array();
										});
									} else {
										print("Pues parece que su $value no tiene nada");
									}
								}
							), 
						),	
					),
				]
			),



			Expanded  (
				child: ListView(
					children: tmp_list
				)
			),
			
           const Text('Escrito por alguien'),
          ],
        ),
      ),

      // a button
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}

/*class task_list extends statelessWidget {
	const task_list({super.key});
	@override
	Widget build(BuildContext context) {
		var task_var_widget = Column(
			mainAxisAlignment: .center,
			children = [];
		);

		
		return task_var_widget;
	}
}*/
