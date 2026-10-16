<?php
require __DIR__ . '/config.php';

$in = json_input();
$name  = trim((string)($in['name'] ?? ''));
$email = strtolower(trim((string)($in['email'] ?? '')));
$phone = preg_replace('/[\s-]/', '', (string)($in['phone'] ?? ''));
$pass  = (string)($in['password'] ?? '');

if (mb_strlen($name) < 2 || mb_strlen($name) > 100) {
    respond(422, ['success' => false, 'message' => 'Sahi naam daalo']);
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 190) {
    respond(422, ['success' => false, 'message' => 'Sahi email daalo']);
}
if (!preg_match('/^\+?\d{10,15}$/', $phone)) {
    respond(422, ['success' => false, 'message' => 'Sahi phone number daalo']);
}
if (strlen($pass) < 6) {
    respond(422, ['success' => false, 'message' => 'Password kam se kam 6 characters']);
}

try {
    $pdo = db();

    $q = $pdo->prepare('SELECT email, phone FROM users WHERE email = ? OR phone = ? LIMIT 1');
    $q->execute([$email, $phone]);
    if ($row = $q->fetch()) {
        $msg = $row['email'] === $email ? 'Email already registered hai' : 'Phone already registered hai';
        respond(409, ['success' => false, 'message' => $msg]);
    }

    $ins = $pdo->prepare('INSERT INTO users (name, email, phone, password_hash) VALUES (?, ?, ?, ?)');
    $ins->execute([$name, $email, $phone, password_hash($pass, PASSWORD_DEFAULT)]);

    respond(201, [
        'success' => true,
        'user' => [
            'id' => (int)$pdo->lastInsertId(),
            'name' => $name,
            'email' => $email,
            'phone' => $phone,
            'fcoin' => 0,
            'dcoin' => 0,
            'wcoin' => 0,
        ],
    ]);
} catch (PDOException $e) {
    if ($e->getCode() === '23000') {
        respond(409, ['success' => false, 'message' => 'Email ya phone already registered hai']);
    }
    respond(500, ['success' => false, 'message' => 'Server error']);
}