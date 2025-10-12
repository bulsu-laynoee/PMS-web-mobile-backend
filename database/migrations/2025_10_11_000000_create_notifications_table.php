<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (Schema::hasTable('notifications')) {
            // Table already exists in this environment (legacy or pre-existing schema)
            return;
        }

        Schema::create('notifications', function (Blueprint $table) {
            // Laravel's default notification id is a uuid string
            $table->uuid('id')->primary();
            $table->string('type');
            // polymorphic relation to notifiable models
            $table->morphs('notifiable');
            $table->text('data');
            $table->timestamp('read_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('notifications');
    }
};
