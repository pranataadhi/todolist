<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VulnerableController extends Controller
{
    public function vulnerableQuery(Request $request)
    {
        $id = $request->input('id');

        // ❌ INI RENTAN SQL INJECTION karena input user langsung disisipkan ke query tanpa binding
        $query = "SELECT * FROM users WHERE id = $id";

        $results = DB::select($query);

        return response()->json($results);
    }
}
