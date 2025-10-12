<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('messages', function (Blueprint $table) {
            if (!Schema::hasColumn('messages', 'conversation_id')) {
                $table->unsignedBigInteger('conversation_id')->nullable()->index()->after('id');
            }
            if (!Schema::hasColumn('messages', 'sender_id')) {
                $table->unsignedBigInteger('sender_id')->nullable()->index()->after('conversation_id');
            }
            if (!Schema::hasColumn('messages', 'recipient_id')) {
                $table->unsignedBigInteger('recipient_id')->nullable()->index()->after('sender_id');
            }

            // add foreign keys if possible
            try {
                $sm = Schema::getConnection()->getDoctrineSchemaManager();
                $platform = $sm->getDatabasePlatform();
                // attempt to add foreign key constraints
                $table->foreign('conversation_id')->references('id')->on('conversations')->onDelete('cascade');
                $table->foreign('sender_id')->references('id')->on('users')->onDelete('set null');
                $table->foreign('recipient_id')->references('id')->on('users')->onDelete('set null');
            } catch (\Exception $ex) {
                // some platforms or setups may not permit FK creation; ignore
            }
        });
    }

    public function down()
    {
        Schema::table('messages', function (Blueprint $table) {
            if (Schema::hasColumn('messages', 'conversation_id')) {
                try { $table->dropForeign(['conversation_id']); } catch (\Exception $e) {}
                $table->dropColumn('conversation_id');
            }
            if (Schema::hasColumn('messages', 'sender_id')) {
                try { $table->dropForeign(['sender_id']); } catch (\Exception $e) {}
                $table->dropColumn('sender_id');
            }
            if (Schema::hasColumn('messages', 'recipient_id')) {
                try { $table->dropForeign(['recipient_id']); } catch (\Exception $e) {}
                $table->dropColumn('recipient_id');
            }
        });
    }
};
