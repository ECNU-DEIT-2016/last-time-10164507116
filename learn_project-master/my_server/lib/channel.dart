import 'dart:async';
import 'dart:math';
import 'package:sqljocky5/sqljocky.dart';
import 'my_server.dart';



//fangwenwebdeyizhongtongdao
/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
/// 
/// 
/// 
List results;
MySqlConnection conn;
class MyServerChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
    Future<void> prepare() async {
     logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
        final s = ConnectionSettings(
    user: "deit2016",
    password: "deit2016@ecnu",
    host: "www.muedu.org",
    port: 3306,
    db: "deit2016db_10164507116",
  );
  print("Opening connection ...");
  conn = await MySqlConnection.connect(s);
  print("Opened connection!");

  await dropTables(conn);
  await createTables(conn);
  await insertRows(conn);
  results=await readData(conn);
  print(results);
  await conn.close();

  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
     router
      .route("/random")
      .link(() => Order());

    router
      .route("/users/[:id]")
      .link(() => MyController())
      .linkFunction((request) async {
      return new Response.ok({'key': 'value'});
    });

    return router;
  }
}



class Order extends ResourceController {

  @Operation.get()
  Future<Response> getThings() async {
    Random random=new Random();
    return Response.ok(results[random.nextInt(results.length)]);
  }
/*
@override
  Future<RequestOrResponse> handle(Request request) async {

   if (request.path.variables.containsKey('id')) {

   // request.path.variables['id']=i.toString();
    
    final id = int.parse(request.path.variables['id']);
    final name = MyServerChannel.idlist.firstWhere((student) => student['id'] == id, orElse: () => null);
    if (name == null) {
      return Response.notFound();
    }

    return Response.ok(name);
  }

  }

*/
}



class MyController extends ResourceController {
  
  @Operation.get()
  Future<Response> getThings() async {
    return Response.ok(results);
  }

  @Operation.get('id')
  Future<Response> getThing(@Bind.path('id') int id) async {
    if (id < 0 || id >= 13) {
      return Response.notFound();
    }
    return Response.ok(results[id]);
  }
}

//drops the tables if they already exist
Future<void> dropTables(MySqlConnection conn) async {
  print("Dropping tables ...");
  await conn.execute("DROP TABLE IF EXISTS students");
  print("Dropped tables!");
}

Future<void> createTables(MySqlConnection conn) async {
  print("Creating tables ...");
  await conn.execute("CREATE TABLE students (id INTEGER NOT NULL auto_increment primary key,name VARCHAR(255) )");
  print("Created table!");
}

Future<void> insertRows(MySqlConnection conn) async {
  print("Inserting rows ...");
  List<Results> r1 =
      await conn.preparedMulti("INSERT INTO students (id, name) VALUES (?, ?)",[

    
     [1,"朱子恒"],
     [2,"周嘉祥"],
     [3,"tlw"],
     [4,"zjy"],
     [5,"ljy"],
     [6,"qxy"],
     [7,"zpw"],
     [8,"zkx"],
     [9,"zkx"],
     [10,"ldk"],
     [11,"cxr"],
     [12,"zsy"],
     [13,"cy"],
        
      ]);
  print("Students table insert ids: " + r1.map((r) => r.insertId).toString());
  print("Rows inserted!");
}

Future<List> readData(MySqlConnection conn) async {
  Results result =
      await conn.execute('SELECT p.id, p.name '
          'FROM students p '
          );
  //return result;

  return  result.toList();
}



main() async {

   /* final s = ConnectionSettings(
    user: "root",
    password: "longxing500",
    host: "localhost",
    port: 3306,
    db: "mysql",
  );
  print("Opening connection ...");
  conn = await MySqlConnection.connect(s);
  print("Opened connection!");*/

 // MyServerChannel msc;
 // msc.prepare();

}