<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use App\Services\AuthServices;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Validation\Rules;

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
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        $data['uuid'] = Str::uuid();

        //store
        $user = User::create($data);

        //send verification code
        $this->authService->otp($user);

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
        $this->authService->otp($user);
        // return
        return response()->json([
            'message' => __('app.otp_sent_success'),
        ], 200);
    }

    public function verify(Request $request)
    {
        //validate the request
        $request->validate([
            'otp' => 'required|numeric'
        ]);

        // //get the user
        $user = Auth::user();

        // verify api
        $this->authService->verify($user, $request);

        // return
        return response()->json([
            'message' => __('app.otp_verify_success'),
            'results' => [
                'user' => new UserResource($user),
            ]
        ], 200);
    }

    public function resetOtp(Request $request)
    {
        //validate the request 
        $request->validate([
            'email' => 'required|email|max:255|exists:users,email',
        ]);

        $user = $this->authService->getUserByEmail($request->email);    

        $this->authService->otp($user, 'password-reset');

        return response()->json([
            'message' => __('app.otp_sent_success'),
        ], 200);
    }

    public function resetPassword(Request $request)
    {
        //validate the request 
        $request->validate([
            'email' => 'required|email|max:255|exists:users,email',
            'otp' => 'required|numeric',
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        $user = $this->authService->getUserByEmail($request->email);    

        $this->authService->resetPassword($user, $request);

        return response()->json([
            'message' => __('app.password_reset_verify_success'),
        ], 200);
    }
}
