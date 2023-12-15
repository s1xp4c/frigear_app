/*
  Warnings:

  - You are about to drop the column `created_at` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the column `handle` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `sessions` table. All the data in the column will be lost.
  - The primary key for the `verification_tokens` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `created_at` on the `verification_tokens` table. All the data in the column will be lost.
  - You are about to drop the column `handle` on the `verification_tokens` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `verification_tokens` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `verification_tokens` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `verification_tokens` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[identifier,token]` on the table `verification_tokens` will be added. If there are existing duplicate values, this will fail.
  - Made the column `user_id` on table `sessions` required. This step will fail if there are existing NULL values in that column.
  - Made the column `phone` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `identifier` to the `verification_tokens` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_user_id_fkey";

-- DropForeignKey
ALTER TABLE "verification_tokens" DROP CONSTRAINT "verification_tokens_user_id_fkey";

-- DropIndex
DROP INDEX "sessions_handle_key";

-- DropIndex
DROP INDEX "verification_tokens_handle_key";

-- AlterTable
ALTER TABLE "sessions" DROP COLUMN "created_at",
DROP COLUMN "handle",
DROP COLUMN "updated_at",
ALTER COLUMN "user_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "phone" SET NOT NULL;

-- AlterTable
ALTER TABLE "verification_tokens" DROP CONSTRAINT "verification_tokens_pkey",
DROP COLUMN "created_at",
DROP COLUMN "handle",
DROP COLUMN "id",
DROP COLUMN "updated_at",
DROP COLUMN "user_id",
ADD COLUMN     "identifier" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "verification_tokens_identifier_token_key" ON "verification_tokens"("identifier", "token");

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
