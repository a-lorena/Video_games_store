const dbName = 'app_database';
const dbVersion = '1.0';
const dbDescription = 'app_database';
const dbSize = 100000;
const dbDriver = "SQLITE";

const admin = {
	id: -100,
	username: "Admin",
	password: "admin",
	logged: 0
}

function dbInit() {
	var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDescription, dbSize, dbDriver);
	
	try {
		db.transaction(function (tx) {
			tx.executeSql(
				`CREATE TABLE IF NOT EXISTS users (
					id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, 
					username VARCHAR(20) NOT NULL, 
					password VARCHAR(20) NOT NULL,
					logged INTEGER DEFAULT 0
				)`
			);
		});
	} catch (err) {
		console.log("Error creating table in database: " + err);
	};

	try {
		db.transaction(function (tx) {
			tx.executeSql(
				`CREATE TABLE IF NOT EXISTS posts (
					id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, 
					title VARCHAR(50) NOT NULL, 
					genre VARCHAR(30) NOT NULL,
					description VARCHAR(500) NOT NULL,
					price VARCHAR(10) NOT NULL,
					user VARCHAR(20) NOT NULL
				)`
			);
		});
	} catch (err) {
		console.log("Error creating table in database: " + err);
	}

	try {
		db.transaction(function (tx) {
			tx.executeSql(
				`CREATE TABLE IF NOT EXISTS orders (
					id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, 
					title VARCHAR(50) NOT NULL, 
					seller VARCHAR(20) NOT NULL,
					buyer VARCHAR(20) NOT NULL,
					price VARCHAR(10) NOT NULL,
					status INTEGER DEFAULT 0
				)`
			);
		});
	} catch (err) {
		console.log("Error creating table in database: " + err);
	};
}

function dbOpen() {
	try {
		var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDescription, dbSize, dbDriver);
	} catch (err) {
		console.log("Error opening database: " + err);
	}
	return db
}

function registerUser(username, password) {
	var db = dbOpen();
	db.transaction(function(tx) {
		tx.executeSql(
			`INSERT INTO users (
				username,
				password,
				logged
			) VALUES (?, ?, ?)`, [username, password, 0]);
	});
}

function loginUser(username, password) {
	var db = dbOpen();
	var result, userID;

	if (username === admin.username && password === admin.password) {
		admin.logged = 1;

	} else {
		db.transaction(function(tx) {
			result = tx.executeSql(
				`SELECT * FROM users WHERE username = ? AND password = ?`, [username, password]
			);
		});

		try {
			userID = result.rows.item(0).id;
		} catch(err) {
			return false;
		}
	
		db.transaction(function(tx) {
			tx.executeSql(
				`UPDATE users SET logged = ? WHERE id = ?`, [1, userID]
			);
		});
	}

	return true;
}

function logoutUser(username) {
	var db = dbOpen();
	db.transaction(function(tx) {

		if (username === admin.username) {
			admin.logged = 0;
		} else {
			tx.executeSql(
				`UPDATE users SET logged = ? WHERE username = ?`, [0, username]
			);
		}
	});
}

function findUser() {
	var db = dbOpen();
	var length, id, username;

	db.transaction(function(tx) {
		var result = tx.executeSql(
			`SELECT * FROM users WHERE logged = ?`, [1]
		);

		length = result.rows.length;

		if (length == 1) {
			id = result.rows.item(0).id;
			username = result.rows.item(0).username;
		} else {
			id = admin.id;
			username = admin.username;
		}
		
	});

	return [id, username];
}

function checkIfUserExists(username) {
	var db = dbOpen();
	var length;
	
	db.transaction(function(tx) {
		var result = tx.executeSql(
			`SELECT * FROM users WHERE username = ?`, [username]
		);

		length = result.rows.length;
	});

	return length;
}

function checkIfUserIsLoggedIn() {
	var db = dbOpen();
	var length;

	db.transaction(function(tx) {
		var result = tx.executeSql(
			`SELECT * FROM users WHERE logged = ?`, [1]
		);

		length = result.rows.length;
	});

	return length;
}

function savePost(title, genre, description, price, user) {
	var db = dbOpen();

	db.transaction(function(tx) {
		tx.executeSql(
			`INSERT INTO posts (
				title, 
				genre, 
				description, 
				price,
				user
			) VALUES (?, ?, ?, ?, ?)`, [title, genre, description, price, user]
		);
	});
}

function deletePost(id) {
	var db = dbOpen();

	db.transaction(function(tx) {
		tx.executeSql('DELETE FROM posts WHERE id = ?', id);
	});
}

function getAllUserPosts(type, modelID, username) {
	var db = dbOpen();

	db.transaction(function(tx) {
		//var sql = 'SELECT * FROM posts WHERE username = ?';

		if (type == "discount") {
			var results = tx.executeSql(`SELECT * FROM posts WHERE
											user != ? AND
											user != ?`,
										[admin.username, username]);

			for (var i = 0; i < results.rows.length; i++) {
				modelID.model.append({
					id: results.rows.item(i).id,
					title: results.rows.item(i).title,
					seller: results.rows.item(i).user,
					genre: results.rows.item(i).genre,
					description: results.rows.item(i).description,
					price: results.rows.item(i).price
				});
			}

		} else {
			var results = tx.executeSql('SELECT * FROM posts WHERE user = ?', [username]);

			for (var i = 0; i < results.rows.length; i++) {
				modelID.model.append({
					id: results.rows.item(i).id,
					title: results.rows.item(i).title,
					seller: results.rows.item(i).user,
					genre: results.rows.item(i).genre,
					description: results.rows.item(i).description,
					price: results.rows.item(i).price
				});
			}
		}
	});
}

function orderGame(title, seller, buyer, price) {
	var db = dbOpen();

	db.transaction(function(tx) {
		tx.executeSql(`
			INSERT INTO orders (
				title,
				seller,
				buyer,
				price
			) VALUES (?, ?, ?, ?)`, [title, seller, buyer, price]
		);
	});
}

function sellGame(orderID) {
	var db = dbOpen();

	db.transaction(function(tx) {
		tx.executeSql(
			`UPDATE orders SET status = ? WHERE id = ?`, [1, orderID]
		);
	});
}

function getMyRequests(list, username) {
	var db = dbOpen();

	db.transaction(function(tx) {
		var results = tx.executeSql(
			'SELECT * FROM orders WHERE seller = ? AND status = ?', [username, 0]
		);

		for (var i = 0; i < results.rows.length; i++) {
			list.model.append({
				id: results.rows.item(i).id,
				title: results.rows.item(i).title,
				seller: results.rows.item(i).seller,
				buyer: results.rows.item(i).buyer,
				price: results.rows.item(i).price,
				status: results.rows.item(i).status
			});
		}
	});
}

function getMyOrders(list, username) {
	var db = dbOpen();

	db.transaction(function(tx) {
		var results = tx.executeSql('SELECT * FROM orders WHERE buyer = ?', [username]);

		for (var i = 0; i < results.rows.length; i++) {
			list.model.append({
				id: results.rows.item(i).id,
				title: results.rows.item(i).title,
				seller: results.rows.item(i).seller,
				buyer: results.rows.item(i).buyer,
				price: results.rows.item(i).price,
				status: results.rows.item(i).status
			});
		}
	});
}

function deleteOrder(orderID) {
	var db = dbOpen();

	db.transaction(function(tx) {
		tx.executeSql(
			`DELETE FROM orders WHERE id = ?`, [orderID]
		);
	});
}

