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
        if (!Schema::hasTable('incidents')) {
            return;
        }

        Schema::table('incidents', function (Blueprint $table) {
            if (!Schema::hasColumn('incidents', 'reported_user_id')) {
                $table->unsignedBigInteger('reported_user_id')->nullable()->after('updated_at');
                $table->index('reported_user_id');
                // Add foreign key if users table exists
                if (Schema::hasTable('users')) {
                    $table->foreign('reported_user_id')->references('id')->on('users')->onDelete('set null');
                }
            }
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        if (!Schema::hasTable('incidents')) {
            return;
        }

        Schema::table('incidents', function (Blueprint $table) {
            if (Schema::hasColumn('incidents', 'reported_user_id')) {
                // drop foreign key if it exists
                try {
                    $table->dropForeign(['reported_user_id']);
                } catch (\Throwable $e) {
                    // ignore if foreign doesn't exist
                }

                try {
                    $table->dropIndex(['reported_user_id']);
                } catch (\Throwable $e) {
                    // ignore
                }

                $table->dropColumn('reported_user_id');
            }
        });
    }
};
