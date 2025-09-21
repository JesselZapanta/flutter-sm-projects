<?php

namespace App\Services;

use App\Models\Otp;
use App\Models\User;
use GuzzleHttp\Psr7\Request;

class AuthServices
{
    public function otp(User $user)
    {
        $code = random_int(100000, 999999);

        $otp = Otp::create([
            'user_type' => $user->id,
            'type' => 'verification',
            'code' => $code,
            'status' => 1
        ]);

        
        //send OTP to email

        return $otp;
    }
}