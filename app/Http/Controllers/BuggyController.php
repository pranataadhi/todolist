<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BuggyController extends Controller
{
    // BUG 1: Akses index array yang tidak ada
    public function bug1()
    {
        $arr = [1, 2, 3];
        echo $arr[5]; // Index tidak tersedia
    }

    // BUG 2: Variabel tidak diinisialisasi
    public function bug2()
    {
        echo $notDefinedVar; // Undefined variable
    }

    // BUG 3: SQL Injection (query mentah, tidak di-bind)
    public function bug3(Request $request)
    {
        $id = $request->input('id');
        $result = \DB::select("SELECT * FROM users WHERE id = $id"); // Raw query tanpa sanitasi
        dd($result);
    }

    // BUG 4: Hardcoded password (kerentanan keamanan)
    public function bug4()
    {
        $password = 'admin123'; // Hardcoded password
        if ($password == 'admin123') {
            echo "Weak password used!";
        }
    }

    // BUG 5: Dead code (tidak akan pernah dijalankan)
    public function bug5()
    {
        return "Done";
        echo "This will never be reached";
    }

    // BUG 6: Nested if berlebihan
    public function bug6()
    {
        $a = 10;
        if ($a > 0) {
            if ($a < 100) {
                if ($a != 50) {
                    echo "Too nested"; // Code smell
                }
            }
        }
    }

    // BUG 7: Catch tanpa tindakan
    public function bug7()
    {
        try {
            throw new \Exception("Error!");
        } catch (\Exception $e) {
            // kosong: swallow error
        }
    }

    // BUG 8: Empty function
    public function bug8()
    {
        // no logic inside
    }

    // BUG 9: String comparison tidak ketat
    public function bug9()
    {
        $input = "0";
        if ($input == false) { // seharusnya pakai ===
            echo "Loose comparison!";
        }
    }

    // BUG 10: Magic number
    public function bug10()
    {
        $diskon = 0.07; // Harusnya pakai konstanta
        echo "Diskon 7%";
    }

    // BUG 11: Fungsi terlalu panjang
    public function bug11()
    {
        // Simulasi 40 baris (Sonar mendeteksi fungsi terlalu kompleks)
        for ($i = 0; $i < 40; $i++) {
            echo "Line $i<br>";
        }
    }
}
