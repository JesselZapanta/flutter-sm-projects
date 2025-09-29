<?php

namespace App\Services;

use App\Mail\OtpMail;
use App\Models\Otp;
use App\Models\User;
use GuzzleHttp\Psr7\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Mail;

class AuthServices
{
    public function otp(User $user, string $type = 'verification')
    {
        //check for span and throttle
        $code = random_int(100000, 999999);

        $otp = Otp::create([
            'user_id' => $user->id,
            'type' => $type,
            'code' => $code,
            'status' => 1
        ]);

        // send OTP to email
        Mail::to($user)->send(new OtpMail($user, $otp));

        return $otp;
    }
    public function verify(User $user, object $request)
    {
        //check if the otp is in the otp model and the user_id is equal to user-id and the otp status is 1
        $otp = Otp::where('user_id', $user->id)
            ->where('code', $request->otp)
            ->where('status', 1)
            ->first();


        // return $otp;
        if(!$otp){
            abort(422, __('app.otp_invalid'));
        }

        // update the user email verified at
        $user->update([
            'email_verified_at' => Carbon::now()
        ]);

        $otp->update([
            'status' => 0,
            'updated_at' => Carbon::now(),
        ]);
        
        return $user;
    }

    public function getUserByEmail(string $email)
    {
        return User::where('email', $email)->first();
    }
    public function resetPassword(User $user, object $request)
    {
        //validate the otp
        $otp = Otp::where([
            'user_id' => $user->id,
            'code' => $request->otp,
            'type' => 'password-reset',
            'status' => 1,
        ])->first();

        if(!$otp){
            return abort(422, __('app.otp_invalid'));
        }

        //set the new password and update the otp
        $user->update([
            'password' => $request->password
        ]);

        $otp->update([
            'status' => 0,
            'updated_at' => Carbon::now()
        ]);

        //return user
        return $user;
    }
}