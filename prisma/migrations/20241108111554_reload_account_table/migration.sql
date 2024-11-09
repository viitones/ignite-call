/*
  Warnings:

  - You are about to drop the column `access_Token` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `access_Token_Expires` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `created_At` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `provider_Account_Id` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `provider_Type` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `refresh_Token` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `updated_At` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `user_Id` on the `accounts` table. All the data in the column will be lost.
  - Added the required column `provider_account_id` to the `accounts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `accounts` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_accounts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "provider_account_id" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,
    CONSTRAINT "accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_accounts" ("id", "provider", "type") SELECT "id", "provider", "type" FROM "accounts";
DROP TABLE "accounts";
ALTER TABLE "new_accounts" RENAME TO "accounts";
CREATE UNIQUE INDEX "accounts_provider_provider_account_id_key" ON "accounts"("provider", "provider_account_id");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
