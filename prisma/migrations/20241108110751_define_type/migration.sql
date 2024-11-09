/*
  Warnings:

  - Added the required column `type` to the `accounts` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_accounts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_Id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider_Type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "provider_Account_Id" TEXT NOT NULL,
    "refresh_Token" TEXT,
    "access_Token" TEXT,
    "access_Token_Expires" DATETIME,
    "created_At" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_At" DATETIME NOT NULL,
    CONSTRAINT "accounts_user_Id_fkey" FOREIGN KEY ("user_Id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_accounts" ("access_Token", "access_Token_Expires", "created_At", "id", "provider", "provider_Account_Id", "provider_Type", "refresh_Token", "updated_At", "user_Id") SELECT "access_Token", "access_Token_Expires", "created_At", "id", "provider", "provider_Account_Id", "provider_Type", "refresh_Token", "updated_At", "user_Id" FROM "accounts";
DROP TABLE "accounts";
ALTER TABLE "new_accounts" RENAME TO "accounts";
CREATE UNIQUE INDEX "accounts_provider_provider_Account_Id_key" ON "accounts"("provider", "provider_Account_Id");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
