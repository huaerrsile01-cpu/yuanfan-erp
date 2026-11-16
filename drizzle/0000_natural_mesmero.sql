CREATE TABLE `erp_accounts` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` text,
	`email` text NOT NULL,
	`name` text NOT NULL,
	`role` text NOT NULL,
	`parent` text,
	`permissions` text NOT NULL,
	`active` integer DEFAULT 1 NOT NULL,
	`access_rev` integer DEFAULT 0 NOT NULL,
	`created` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `erp_accounts_user_id_unique` ON `erp_accounts` (`user_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `erp_accounts_email_unique` ON `erp_accounts` (`email`);--> statement-breakpoint
CREATE TABLE `erp_audit` (
	`id` text PRIMARY KEY NOT NULL,
	`actor` text NOT NULL,
	`target` text NOT NULL,
	`action` text NOT NULL,
	`created` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `erp_states` (
	`account_id` text PRIMARY KEY NOT NULL,
	`data` text NOT NULL,
	`revision` integer DEFAULT 0 NOT NULL,
	`updated` text NOT NULL
);
