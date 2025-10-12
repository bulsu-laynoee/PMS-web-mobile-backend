<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::dropIfExists('parking_assignments');

        Schema::create('parking_assignments', function (Blueprint $table) {
            $table->id();
            // create the column as unsignedBigInteger and index it here. The explicit
            // foreign key constraint is added later by `2025_09_21_210000_add_foreign_keys_to_pms_tables.php`
            // This prevents migration ordering issues when parking_slots doesn't exist yet.
            $table->unsignedBigInteger('parking_slot_id');
            $table->index('parking_slot_id');
            // define user_id as unsignedBigInteger nullable and index it instead of forcing a FK constraint
            // Some environments may fail to create this FK during migrations; keep it nullable and indexed.
            $table->unsignedBigInteger('user_id')->nullable()->index();
            $table->string('guest_name')->nullable();
            $table->string('guest_contact')->nullable();
            $table->string('vehicle_plate');
            $table->string('vehicle_color');
            $table->string('vehicle_type');
            $table->dateTime('start_time');
            $table->dateTime('end_time')->nullable();
            $table->string('status')->default('active');
            $table->text('notes')->nullable();
            $table->timestamps();
            $table->string('assignee_type');
            $table->string('assignment_type');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parking_assignments');
    }
};
