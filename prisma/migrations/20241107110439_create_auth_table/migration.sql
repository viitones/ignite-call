/*
  Warnings:

  - You are about to drop the column `created_at` on the `users` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "accounts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_Id" TEXT NOT NULL,
    "provider_Type" TEXT NOT NULL,
    "provider_Id" TEXT NOT NULL,
    "provider_Account_Id" TEXT NOT NULL,
    "refresh_Token" TEXT,
    "access_Token" TEXT,
    "access_Token_Expires" DATETIME,
    "created_At" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_At" DATETIME NOT NULL,
    CONSTRAINT "accounts_user_Id_fkey" FOREIGN KEY ("user_Id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_Id" TEXT NOT NULL,
    "expires" DATETIME NOT NULL,
    "session_Token" TEXT NOT NULL,
    "access_Token" TEXT NOT NULL,
    "created_At" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_At" DATETIME NOT NULL,
    CONSTRAINT "sessions_user_Id_fkey" FOREIGN KEY ("user_Id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_users" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "avatar_url" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_users" ("id", "name", "username") SELECT "id", "name", "username" FROM "users";
DROP TABLE "users";
ALTER TABLE "new_users" RENAME TO "users";
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "accounts_provider_Id_provider_Account_Id_key" ON "accounts"("provider_Id", "provider_Account_Id");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_session_Token_key" ON "sessions"("session_Token");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_access_Token_key" ON "sessions"("access_Token");
