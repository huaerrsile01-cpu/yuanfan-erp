CREATE TABLE `erp_credentials` (
	`username` text PRIMARY KEY NOT NULL,
	`account_id` text NOT NULL,
	`hash` text NOT NULL,
	`version` integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE `erp_password_sessions` (
	`id` text PRIMARY KEY NOT NULL,
	`credential` text NOT NULL,
	`account_id` text NOT NULL,
	`version` integer NOT NULL,
	`expires` integer NOT NULL
);
