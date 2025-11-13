<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     * Adds QR metadata fields to user_details and creates the scheduled event to update qr_is_active.
     *
     * Note: MySQL event scheduler must be enabled for the DB event to run (SET GLOBAL event_scheduler = ON;)
     */
    public function up()
    {
        if (!Schema::hasTable('user_details')) {
            return;
        }

        // Add columns if missing
        if (!Schema::hasColumn('user_details', 'qr_path') || !Schema::hasColumn('user_details', 'qr_token') || !Schema::hasColumn('user_details', 'qr_expires_at') || !Schema::hasColumn('user_details', 'qr_is_active')) {
            Schema::table('user_details', function (Blueprint $table) {
                if (!Schema::hasColumn('user_details', 'qr_path')) {
                    $table->string('qr_path', 255)->nullable()->after('profile_photo_path');
                }
                if (!Schema::hasColumn('user_details', 'qr_token')) {
                    $table->string('qr_token', 191)->nullable()->after('qr_path');
                }
                if (!Schema::hasColumn('user_details', 'qr_expires_at')) {
                    $table->dateTime('qr_expires_at')->nullable()->after('qr_token');
                }
                if (!Schema::hasColumn('user_details', 'qr_is_active')) {
                    $table->boolean('qr_is_active')->default(false)->after('qr_expires_at');
                }
            });
        }

        // Ensure index exists for token lookups
        try {
            DB::statement('CREATE INDEX idx_user_details_qr_token ON user_details (qr_token)');
        } catch (\Exception $e) {
            // ignore if index exists or fails (older MySQL may behave differently)
        }

        // Initialize qr_is_active based on current data
        DB::statement("UPDATE user_details SET qr_is_active = CASE WHEN qr_token IS NOT NULL AND qr_expires_at IS NOT NULL AND qr_expires_at > NOW() THEN 1 ELSE 0 END");

        // Create a DB event to keep qr_is_active in sync (runs every 1 minute)
        try {
            DB::unprepared('DROP EVENT IF EXISTS ev_user_details_qr_status');

            $sql = <<<'SQL'
CREATE EVENT ev_user_details_qr_status
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
  UPDATE user_details
    SET qr_is_active = 0
    WHERE qr_is_active <> 0
      AND qr_expires_at IS NOT NULL
      AND qr_expires_at <= NOW();

  UPDATE user_details
    SET qr_is_active = 1
    WHERE qr_token IS NOT NULL
      AND qr_expires_at IS NOT NULL
      AND qr_expires_at > NOW();
END
SQL;
            DB::unprepared($sql);
        } catch (\Exception $e) {
            // ignore event creation errors; server might not allow events
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        if (!Schema::hasTable('user_details')) {
            return;
        }

        // Drop DB event
        try { DB::unprepared('DROP EVENT IF EXISTS ev_user_details_qr_status'); } catch (\Exception $e) {}

        // Drop index
        try { DB::statement('DROP INDEX idx_user_details_qr_token ON user_details'); } catch (\Exception $e) {}

        Schema::table('user_details', function (Blueprint $table) {
            if (Schema::hasColumn('user_details', 'qr_is_active')) {
                $table->dropColumn('qr_is_active');
            }
            if (Schema::hasColumn('user_details', 'qr_expires_at')) {
                $table->dropColumn('qr_expires_at');
            }
            if (Schema::hasColumn('user_details', 'qr_token')) {
                $table->dropColumn('qr_token');
            }
            if (Schema::hasColumn('user_details', 'qr_path')) {
                $table->dropColumn('qr_path');
            }
        });
    }
};
