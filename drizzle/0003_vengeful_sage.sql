CREATE TABLE `erp_backups` (
	`id` text PRIMARY KEY NOT NULL,
	`account_id` text NOT NULL,
	`data` text NOT NULL,
	`revision` integer NOT NULL,
	`created` text NOT NULL,
	`reason` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `erp_price_history` (
	`id` text PRIMARY KEY NOT NULL,
	`account_id` text NOT NULL,
	`product_id` text NOT NULL,
	`old_price` text NOT NULL,
	`new_price` text NOT NULL,
	`supplier` text NOT NULL,
	`note` text NOT NULL,
	`actor` text NOT NULL,
	`created` text NOT NULL
);
