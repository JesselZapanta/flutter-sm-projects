<x-mail::message>
# Hello {{ $user->name }},

Here's your One-Time Password (OTP):  

<x-mail::panel>
# {{ $otp->code }}
</x-mail::panel>

This OTP is valid for **5 minutes**.  

@if ($otp->type == 'verification')
Verifying your account  
@else
Use it to complete your password reset request.  
@endif

⚠️ **Security Reminder:**  
Do not share this OTP with anyone. Our team will never ask for your OTP.  
If you didn't request this OTP, you can safely ignore this email.

Thank you for trusting **{{ config('app.name') }}**.  

Regards,  
**{{ config('app.name') }} Team**
</x-mail::message>
