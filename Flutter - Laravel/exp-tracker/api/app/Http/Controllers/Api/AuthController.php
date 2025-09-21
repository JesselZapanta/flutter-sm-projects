<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use App\Services\AuthServices;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    protected $authService;

    public function __construct(AuthServices $authService)
    {
        $this->authService = $authService;
    }

    public function register(Request $request)
    {
        //validate
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|confirmed|min:6',
        ]);

        $data['uuid'] = Str::uuid();

        //store
        $user = User::create($data);

        //token
        $token = $user->createToken('auth')->plainTextToken;

        return response()->json([
            'message' => __('app.registration_success'),
            'results' => [
                'user' => new UserResource($user),
                'token' => $token
            ]
        ], 201);
    }
    public function login(Request $request)
    {
        //validate
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);
        

        if(!Auth::attempt($credentials)){
            return response()->json([
                'message' => __('app.login_failed')
            ], 401);
        }

        //get the auth user
        $user = Auth::user();

        //create new access token 
        $token = $user->createToken('auth')->plainTextToken;

        return response()->json([
            'message' => $user->email_verified_at ? __('app.login_success') : __('app.login_success_verify'),
            'results' => [
                'user' => new UserResource($user),
                'token' => $token
            ]
        ], 200);
    }

    public function otp(Request $request)
    {
        //get the user
        $user = Auth::user();

        //generate OTP
        $otp = $this->authService->otp($user);
        // return
        return response()->json([
            'message' => 'Mao ni ang OTOP',
            'results' => [
                'user' => new UserResource($user),
            ]
        ], 200);
    }
}
