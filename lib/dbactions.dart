import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
var db;
var task_array = [];

const int PINNED = 1;
const int UNPINNED = 0;
const int COMPLETED = 1;
const int UNCOMPLETED = 0;

class Task {
	int id;
	int pos;
	String name;
	int status;
	int pinned;

	Task(this.id, this.pos, this.name, this.status, this.pinned);
}


Future<void> init_db() async {
	var path = (await getApplicationDocumentsDirectory()).path;
	db = sqlite3.open("$path/tareas.db");
	db.execute('''
		CREATE TABLE IF NOT EXISTS tareas (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		pos INT NOT NULL,
		name VARCHAR(100) NOT NULL,
		status INT,
		pinned INT
	)
	''');
	update_array();
}


void new_task(int pos, String name, {int status = 0, int pinned = 0}) {
	db.execute("INSERT INTO tareas (pos, name, status, pinned) VALUES (?, ?, ?, ?)", [pos, name, status, pinned]);
}


ResultSet get_task_by_id(int id) {
	return db.select('SELECT * FROM tareas WHERE id = $id');

}

void remove_task(int id) {
	db.execute("DELETE FROM tareas WHERE id = $id");

}

List<Task> get_array() {
	List<Task> arr = [];
	final all = db.select('SELECT * FROM tareas');
	for (var row in all) {
		arr.add(Task(row['id'], row['pos'], row['name'], row['status'], row['pinned']));
	}
	return arr;
	//arr.add(Task());
}

void update_array() {
	task_array.clear();
	task_array = get_array();
}


void set_status(int id, int status) {
	db.execute("UPDATE tareas SET status = $status WHERE id = $id");
}

void set_pinned(int id, int pinned) {
	db.execute("UPDATE tareas SET pinned = $pinned WHERE id = $id");
}

/*
void main() {
	init_db();

	new_task(0, "Comer");
	new_task(0, "Cagar");
	update_array();
	
	for (var i in task_array) {
		print("${i.name} -> ${i.status}");
	}
	print("------");

	set_status(1, COMPLETED);

	update_array();
	for (var i in task_array) {
		print("${i.name} -> ${i.status}");
	}

	db.dispose();
	return;
}
*/
