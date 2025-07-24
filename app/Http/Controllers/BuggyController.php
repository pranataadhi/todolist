<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BuggyController extends Controller
{
    public function showBug()
    {
        // Bug 1: Akses index array yang tidak ada
        $data = ['foo' => 'bar'];
        echo $data['baz']; // <- Ini bug: Key 'baz' tidak ada

        // Bug 2: Variabel tidak digunakan
        $unusedVariable = 123;

        // Bug 3: Hardcoded password (keamanan)
        $password = "123456"; // <- Ini bisa dideteksi SonarQube

        // Bug 4: Perbandingan tidak aman
        if ($password == true) {
            echo "Password OK?";
        }
    }
}
