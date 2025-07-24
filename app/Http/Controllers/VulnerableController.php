<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VulnerableController extends Controller
{
    public function testSQLi(Request $request)
    {
        $id = $request->input('id');
        $sql = "SELECT * FROM users WHERE id = $id"; // rentan

        $result = DB::select($sql);
        return response()->json($result);
    }
}
