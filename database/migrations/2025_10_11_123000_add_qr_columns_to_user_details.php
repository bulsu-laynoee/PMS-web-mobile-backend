<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddQrColumnsToUserDetails extends Migration
{
    /**
     * Run the migrations.
     * Adds `qr_path` and `qr_token` to `user_details` if they don't exist.
     */
    public function up()
    {
        if (! Schema::hasTable('user_details')) return;

        Schema::table('user_details', function (Blueprint $table) {
            if (! Schema::hasColumn('user_details', 'qr_path')) {
                $table->string('qr_path')->nullable()->after('or_cr_path');
            }
            if (! Schema::hasColumn('user_details', 'qr_token')) {
                $table->string('qr_token')->nullable()->after('qr_path')->index();
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        if (! Schema::hasTable('user_details')) return;

        Schema::table('user_details', function (Blueprint $table) {
            if (Schema::hasColumn('user_details', 'qr_token')) {
                $table->dropColumn('qr_token');
            }
            if (Schema::hasColumn('user_details', 'qr_path')) {
                $table->dropColumn('qr_path');
            }
        });
    }
}
