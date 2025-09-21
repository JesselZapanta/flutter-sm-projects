<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Otp extends Model
{
    protected $table = 'otps';

    protected $fillable = [
        'user_id',
        'type',
        'code',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
