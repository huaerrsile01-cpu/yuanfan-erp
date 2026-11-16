// Intentionally empty by default.
// Add Drizzle tables here when the site actually needs a database.
// See examples/d1/db/schema.ts for an opt-in example.
import {sqliteTable,text,integer} from 'drizzle-orm/sqlite-core';
export const accounts=sqliteTable('erp_accounts',{id:text('id').primaryKey(),userId:text('user_id').unique(),email:text('email').notNull().unique(),name:text('name').notNull(),role:text('role').notNull(),parent:text('parent'),permissions:text('permissions').notNull(),active:integer('active').notNull().default(1),accessRev:integer('access_rev').notNull().default(0),created:text('created').notNull()});
export const states=sqliteTable('erp_states',{accountId:text('account_id').primaryKey(),data:text('data').notNull(),revision:integer('revision').notNull().default(0),updated:text('updated').notNull()});
export const audit=sqliteTable('erp_audit',{id:text('id').primaryKey(),actor:text('actor').notNull(),target:text('target').notNull(),action:text('action').notNull(),created:text('created').notNull()});
export const authLimits=sqliteTable('erp_auth_limits',{key:text('key').primaryKey(),attempts:integer('attempts').notNull(),expires:integer('expires').notNull()});
export const credentials=sqliteTable('erp_credentials',{username:text('username').primaryKey(),accountId:text('account_id').notNull(),hash:text('hash').notNull(),version:integer('version').notNull().default(0)});
export const passwordSessions=sqliteTable('erp_password_sessions',{id:text('id').primaryKey(),credential:text('credential').notNull(),accountId:text('account_id').notNull(),version:integer('version').notNull(),expires:integer('expires').notNull()});
export const backups=sqliteTable('erp_backups',{id:text('id').primaryKey(),accountId:text('account_id').notNull(),data:text('data').notNull(),revision:integer('revision').notNull(),created:text('created').notNull(),reason:text('reason').notNull()});
export const priceHistory=sqliteTable('erp_price_history',{id:text('id').primaryKey(),accountId:text('account_id').notNull(),productId:text('product_id').notNull(),oldPrice:text('old_price').notNull(),newPrice:text('new_price').notNull(),supplier:text('supplier').notNull(),note:text('note').notNull(),actor:text('actor').notNull(),created:text('created').notNull()});
