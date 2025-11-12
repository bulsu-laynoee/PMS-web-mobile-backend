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
        if (!Schema::hasColumn('parking_layouts', 'is_active')) {
            Schema::table('parking_layouts', function (Blueprint $table) {
                $table->boolean('is_active')->default(true)->after('layout_data');
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        if (Schema::hasColumn('parking_layouts', 'is_active')) {
            Schema::table('parking_layouts', function (Blueprint $table) {
                $table->dropColumn('is_active');
            });
        }
    }
};
