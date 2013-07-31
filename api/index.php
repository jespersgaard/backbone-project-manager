<?php

require 'Slim/Slim.php';

$app = new Slim();

$app->get('/logs/:id',	'getLogData');
$app->get('/bugs/:id',	'getBugData');
$app->get('/specs/:id',	'getSpecData');
$app->get('/projects', 'getProjects');
$app->get('/login/:username/:password', 'login');
$app->post('/projects', 'addProject');
$app->post('/logs', 'newLog');
$app->post('/bugs', 'newBug');
$app->post('/specs', 'newSpec');
$app->put('/logs/:id', 'updateLog');
$app->put('/bugs/:id', 'updateBug');
$app->put('/specs/:id', 'updateSpec');

$app->run();

function getProjects() {
	$sql = "select * FROM projects ORDER BY project_id";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);  
		$projects = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		// echo '{"project": ' . json_encode($projects) . '}';
		echo json_encode($projects);
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function login($username, $password){
	try {
            $dbhost="localhost";
            $dbname="pmgr_demo";
            $dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $username, $password);	
            $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $user = (object) array('username' => $username, 'password' => $password);
            echo json_encode($user); 
            $dbh = null;
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
        
//	return $dbh;
} 

function getLogData($id) {
	$sql = "SELECT * FROM project_logs WHERE project_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("id", $id);
		$stmt->execute();
//		$logs = $stmt->fetch();  
		$logs = $stmt->fetchAll(PDO::FETCH_OBJ);  
		$db = null;
		echo json_encode($logs); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function getBugData($id) {
	$sql = "SELECT * FROM project_bugs WHERE project_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$bugs = $stmt->fetchAll(PDO::FETCH_OBJ);  
		$db = null;
		echo json_encode($bugs); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function getSpecData($id) {
	$sql = "SELECT * FROM project_specs WHERE project_id=:id ORDER BY open";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$specs = $stmt->fetchAll(PDO::FETCH_OBJ);  
		$db = null;
		echo json_encode($specs); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function addProject() {
//	error_log('addProject\n', 3, '/var/tmp/php.log');
	$request = Slim::getInstance()->request();
	$project = json_decode($request->getBody());
	$sql = "INSERT INTO projects (project_name) VALUES (:project_name)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("project_name", $project->project_name);
		$stmt->execute();
		$project->project_id = $db->lastInsertId();
//                $project->id = $project->project_id;
		$db = null;
		echo json_encode($project); 
	} catch(PDOException $e) {
//		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function newLog() {
	$request = Slim::getInstance()->request();
	$log = json_decode($request->getBody());
	$sql = "INSERT INTO project_logs (project_id, date, entry_text) VALUES (:project_id, :date, :entry_text)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("project_id", $log->project_id);
		$stmt->bindParam("date", $log->date);
		$stmt->bindParam("entry_text", $log->entry_text);
		$stmt->execute();
		$log->id = $db->lastInsertId();
		$db = null;
		echo json_encode($log); 
	} catch(PDOException $e) {
//		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function newBug() {
	$request = Slim::getInstance()->request();
	$bug = json_decode($request->getBody());
	$sql = "INSERT INTO project_bugs (project_id, date_opened, date_closed, notes, entry, open) VALUES (:project_id, :date_opened, :date_closed, :notes, :entry, :open)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("project_id", $bug->project_id);
		$stmt->bindParam("date_opened", $bug->date_opened);
		$stmt->bindParam("date_closed", $bug->date_closed);
		$stmt->bindParam("entry", $bug->entry);
		$stmt->bindParam("notes", $bug->notes);
		$stmt->bindParam("open", $bug->open);
		$stmt->execute();
		$bug->id = $db->lastInsertId();
		$db = null;
		echo json_encode($bug); 
	} catch(PDOException $e) {
//		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function newSpec() {
	$request = Slim::getInstance()->request();
	$spec = json_decode($request->getBody());
	$sql = "INSERT INTO project_specs (project_id, spec, notes, open) VALUES (:project_id, :spec, :notes, :open)";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("project_id", $spec->project_id);
		$stmt->bindParam("spec", $spec->spec);
		$stmt->bindParam("notes", $spec->notes);
		$stmt->bindParam("open", $spec->open);
		$stmt->execute();
		$spec->id = $db->lastInsertId();
		$db = null;
		echo json_encode($spec); 
	} catch(PDOException $e) {
//		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function updatelog($id) {
	$request = Slim::getInstance()->request();
	$body = $request->getBody();
	$log = json_decode($body);
	$sql = "UPDATE project_logs SET entry_text=:entry_text WHERE id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("entry_text", $log->entry_text);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo json_encode($log); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function updateBug($id) {
	$request = Slim::getInstance()->request();
	$body = $request->getBody();
	$bug = json_decode($body);
	$sql = "UPDATE project_bugs SET entry=:entry, notes=:notes, open=:open WHERE id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("entry", $bug->entry);
		$stmt->bindParam("notes", $bug->notes);
		$stmt->bindParam("open", $bug->open);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo json_encode($bug); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function updateSpec($id) {
	$request = Slim::getInstance()->request();
	$body = $request->getBody();
	$spec = json_decode($body);
	$sql = "UPDATE project_specs SET spec=:spec, notes=:notes, open=:open WHERE id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("spec", $spec->spec);
		$stmt->bindParam("notes", $spec->notes);
		$stmt->bindParam("open", $spec->open);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo json_encode($spec); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function getConnection() {
	$dbhost="localhost";
	$dbuser="guest";
	$dbpass="guestpw";
	$dbname="pmgr_demo";
	$dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);	
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbh;
}

?>