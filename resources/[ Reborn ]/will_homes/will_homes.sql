CREATE TABLE `will_homes` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`house_id` INT(11) NOT NULL DEFAULT '0',
	`owner` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`name` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`friends` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`theme` TEXT NOT NULL DEFAULT 'modern' COLLATE 'utf8mb4_general_ci',
	`vault` INT(11) NOT NULL DEFAULT '100',
	`extends` TEXT NOT NULL DEFAULT '[]' COLLATE 'utf8mb4_general_ci',
	`tax` INT(11) NOT NULL DEFAULT '1572029150',
	PRIMARY KEY (`id`) USING BTREE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB AUTO_INCREMENT=1;
