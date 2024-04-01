DROP TABLE IF EXISTS `ld_orgs`;
CREATE TABLE IF NOT EXISTS `ld_orgs` (
  `org` text NOT NULL DEFAULT '0',
  `bank` int(11) DEFAULT 0,
  `description` text DEFAULT NULL,
  `historico` text DEFAULT '{}',
  `permissions` longtext DEFAULT '{}',
  PRIMARY KEY (`org`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `ld_orgs_daily`;
CREATE TABLE IF NOT EXISTS `ld_orgs_daily` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `org` varchar(50) DEFAULT '0',
  `itens` longtext DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `reward` text DEFAULT '{}',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `ld_orgs_monthly`;
CREATE TABLE IF NOT EXISTS `ld_orgs_monthly` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `org` text DEFAULT NULL,
  `itens` text DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `payment` text DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ld_orgs_farm` (
  `org` varchar(50) NOT NULL DEFAULT '',
  `type` text DEFAULT NULL,
  `daily` int(11) DEFAULT NULL,
  `monthly` int(11) DEFAULT NULL,
  `payment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;