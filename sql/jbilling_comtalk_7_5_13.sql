/*
SQLyog Trial v11.13 (32 bit)
MySQL - 5.5.22 : Database - jbilling_comtalk
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jbilling_comtalk` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jbilling_comtalk`;

/*Table structure for table `ach` */

DROP TABLE IF EXISTS `ach`;

CREATE TABLE `ach` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `aba_routing` varchar(40) NOT NULL,
  `bank_account` varchar(60) NOT NULL,
  `account_type` int(11) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `gateway_key` varchar(100) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ach_i_2` (`user_id`),
  KEY `FK178867A85DBFE` (`user_id`),
  CONSTRAINT `ach_FK_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK178867A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ach` */

LOCK TABLES `ach` WRITE;

UNLOCK TABLES;

/*Table structure for table `ageing_entity_step` */

DROP TABLE IF EXISTS `ageing_entity_step`;

CREATE TABLE `ageing_entity_step` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `days` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF47F8DECA7AC55E` (`entity_id`),
  KEY `FKF47F8DECA1224125` (`status_id`),
  CONSTRAINT `ageing_entity_step_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `ageing_entity_step_FK_1` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FKF47F8DECA1224125` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FKF47F8DECA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ageing_entity_step` */

LOCK TABLES `ageing_entity_step` WRITE;

insert  into `ageing_entity_step`(`id`,`entity_id`,`status_id`,`days`,`OPTLOCK`) values (100,11,1,0,0);

UNLOCK TABLES;

/*Table structure for table `base_user` */

DROP TABLE IF EXISTS `base_user`;

CREATE TABLE `base_user` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `language_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `subscriber_status` int(11) DEFAULT '1',
  `currency_id` int(11) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_status_change` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_name` varchar(50) DEFAULT NULL,
  `failed_attempts` int(11) NOT NULL DEFAULT '0',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entity_id` (`entity_id`,`user_name`,`status_id`),
  KEY `ix_base_user_un` (`entity_id`,`user_name`),
  KEY `FK93BC3879BF4F395B` (`currency_id`),
  KEY `FK93BC3879A7AC55E` (`entity_id`),
  KEY `FK93BC3879A1224125` (`status_id`),
  KEY `FK93BC387960AFD809` (`subscriber_status`),
  KEY `FK93BC3879ED34C00D` (`language_id`),
  CONSTRAINT `base_user_FK_5` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `base_user_FK_1` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `base_user_FK_2` FOREIGN KEY (`subscriber_status`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `base_user_FK_3` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `base_user_FK_4` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `FK93BC387960AFD809` FOREIGN KEY (`subscriber_status`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK93BC3879A1224125` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK93BC3879A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK93BC3879BF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK93BC3879ED34C00D` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `base_user` */

LOCK TABLES `base_user` WRITE;

insert  into `base_user`(`id`,`entity_id`,`password`,`deleted`,`language_id`,`status_id`,`subscriber_status`,`currency_id`,`create_datetime`,`last_status_change`,`last_login`,`user_name`,`failed_attempts`,`OPTLOCK`) values (10,11,'46f94c8de14fb36680850768ff1b7f2a',0,1,1,9,1,'2013-07-05 14:07:48','2013-07-05 14:07:52','2013-07-05 14:07:52','Admin',0,0);

UNLOCK TABLES;

/*Table structure for table `billing_process` */

DROP TABLE IF EXISTS `billing_process`;

CREATE TABLE `billing_process` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `billing_date` datetime NOT NULL,
  `period_unit_id` int(11) NOT NULL,
  `period_value` int(11) NOT NULL,
  `is_review` int(11) NOT NULL,
  `paper_invoice_batch_id` int(11) DEFAULT NULL,
  `retries_to_do` int(11) NOT NULL DEFAULT '0',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK13303CABA7AC55E` (`entity_id`),
  KEY `FK13303CAB3F97B344` (`paper_invoice_batch_id`),
  KEY `FK13303CAB247BB99` (`period_unit_id`),
  CONSTRAINT `billing_process_FK_3` FOREIGN KEY (`paper_invoice_batch_id`) REFERENCES `paper_invoice_batch` (`id`),
  CONSTRAINT `billing_process_FK_1` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `billing_process_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK13303CAB247BB99` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `FK13303CAB3F97B344` FOREIGN KEY (`paper_invoice_batch_id`) REFERENCES `paper_invoice_batch` (`id`),
  CONSTRAINT `FK13303CABA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `billing_process` */

LOCK TABLES `billing_process` WRITE;

UNLOCK TABLES;

/*Table structure for table `billing_process_configuration` */

DROP TABLE IF EXISTS `billing_process_configuration`;

CREATE TABLE `billing_process_configuration` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `next_run_date` datetime NOT NULL,
  `generate_report` smallint(6) NOT NULL,
  `retries` int(11) DEFAULT NULL,
  `days_for_retry` int(11) DEFAULT NULL,
  `days_for_report` int(11) DEFAULT NULL,
  `review_status` int(11) NOT NULL,
  `period_unit_id` int(11) NOT NULL,
  `period_value` int(11) NOT NULL,
  `due_date_unit_id` int(11) NOT NULL,
  `due_date_value` int(11) NOT NULL,
  `df_fm` smallint(6) DEFAULT NULL,
  `only_recurring` smallint(6) NOT NULL DEFAULT '1',
  `invoice_date_process` smallint(6) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  `auto_payment` smallint(6) NOT NULL DEFAULT '0',
  `maximum_periods` int(11) NOT NULL DEFAULT '1',
  `auto_payment_application` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK76287C62A7AC55E` (`entity_id`),
  KEY `FK76287C62247BB99` (`period_unit_id`),
  CONSTRAINT `billing_process_configuration_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `billing_process_configuration_FK_1` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `FK76287C62247BB99` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `FK76287C62A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `billing_process_configuration` */

LOCK TABLES `billing_process_configuration` WRITE;

insert  into `billing_process_configuration`(`id`,`entity_id`,`next_run_date`,`generate_report`,`retries`,`days_for_retry`,`days_for_report`,`review_status`,`period_unit_id`,`period_value`,`due_date_unit_id`,`due_date_value`,`df_fm`,`only_recurring`,`invoice_date_process`,`OPTLOCK`,`auto_payment`,`maximum_periods`,`auto_payment_application`) values (100,11,'2013-08-05 00:00:00',1,0,1,3,1,2,1,1,1,NULL,1,0,0,1,1,1);

UNLOCK TABLES;

/*Table structure for table `blacklist` */

DROP TABLE IF EXISTS `blacklist`;

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `credit_card` int(11) DEFAULT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_blacklist_user_type` (`user_id`,`type`),
  KEY `ix_blacklist_entity_type` (`entity_id`,`type`),
  KEY `FK4F74291DA7AC55E` (`entity_id`),
  KEY `FK4F74291D9CD23330` (`contact_id`),
  KEY `FK4F74291D7A85DBFE` (`user_id`),
  KEY `FK4F74291D2E23C475` (`credit_card_id`),
  CONSTRAINT `blacklist_FK_2` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `blacklist_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK4F74291D2E23C475` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`id`),
  CONSTRAINT `FK4F74291D7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK4F74291D9CD23330` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK4F74291DA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `blacklist` */

LOCK TABLES `blacklist` WRITE;

UNLOCK TABLES;

/*Table structure for table `breadcrumb` */

DROP TABLE IF EXISTS `breadcrumb`;

CREATE TABLE `breadcrumb` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `breadcrumb` */

LOCK TABLES `breadcrumb` WRITE;

insert  into `breadcrumb`(`id`,`user_id`,`controller`,`action`,`name`,`object_id`,`description`,`version`) values (1,10,'customer','list',NULL,NULL,NULL,0),(2,10,'customer','edit','create',NULL,NULL,0);

UNLOCK TABLES;

/*Table structure for table `contact` */

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `organization_name` varchar(200) DEFAULT NULL,
  `street_addres1` varchar(100) DEFAULT NULL,
  `street_addres2` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(30) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `person_initial` varchar(5) DEFAULT NULL,
  `person_title` varchar(40) DEFAULT NULL,
  `phone_country_code` int(11) DEFAULT NULL,
  `phone_area_code` int(11) DEFAULT NULL,
  `phone_phone_number` varchar(20) DEFAULT NULL,
  `fax_country_code` int(11) DEFAULT NULL,
  `fax_area_code` int(11) DEFAULT NULL,
  `fax_phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `notification_include` smallint(6) DEFAULT '1',
  `user_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_contact_fname` (`first_name`),
  KEY `ix_contact_lname` (`last_name`),
  KEY `ix_contact_orgname` (`organization_name`),
  KEY `contact_i_del` (`deleted`),
  KEY `ix_contact_fname_lname` (`first_name`,`last_name`),
  KEY `ix_contact_address` (`street_addres1`,`city`,`postal_code`,`street_addres2`,`state_province`,`country_code`),
  KEY `ix_contact_phone` (`phone_phone_number`,`phone_area_code`,`phone_country_code`),
  KEY `ix_user` (`user_id`),
  KEY `FK38B724207A85DBFE` (`user_id`),
  CONSTRAINT `FK38B724207A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `contact` */

LOCK TABLES `contact` WRITE;

insert  into `contact`(`id`,`organization_name`,`street_addres1`,`street_addres2`,`city`,`state_province`,`postal_code`,`country_code`,`last_name`,`first_name`,`person_initial`,`person_title`,`phone_country_code`,`phone_area_code`,`phone_phone_number`,`fax_country_code`,`fax_area_code`,`fax_phone_number`,`email`,`create_datetime`,`deleted`,`notification_include`,`user_id`,`OPTLOCK`) values (101,'Comtalk A/S','Niels Bohrs','Vej 10','Haderslev','Haderslev','6100','DK','Jensen','William',NULL,NULL,45,69,'906900',NULL,NULL,NULL,'noc@comtalk.dk','2013-07-05 14:07:48',0,NULL,NULL,0),(102,'Comtalk A/S','Niels Bohrs','Vej 10','Haderslev','Haderslev','6100','DK','Jensen','William',NULL,NULL,45,69,'906900',NULL,NULL,NULL,'noc@comtalk.dk','2013-07-05 14:07:51',0,NULL,10,0);

UNLOCK TABLES;

/*Table structure for table `contact_field` */

DROP TABLE IF EXISTS `contact_field`;

CREATE TABLE `contact_field` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `content` varchar(100) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_contact_field_cid` (`contact_id`),
  KEY `ix_contact_field_content` (`content`),
  KEY `FK387E901B9CD23330` (`contact_id`),
  KEY `FK387E901BCA08854` (`type_id`),
  CONSTRAINT `contact_field_FK_2` FOREIGN KEY (`type_id`) REFERENCES `contact_field_type` (`id`),
  CONSTRAINT `contact_field_FK_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK387E901B9CD23330` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK387E901BCA08854` FOREIGN KEY (`type_id`) REFERENCES `contact_field_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `contact_field` */

LOCK TABLES `contact_field` WRITE;

UNLOCK TABLES;

/*Table structure for table `contact_field_type` */

DROP TABLE IF EXISTS `contact_field_type`;

CREATE TABLE `contact_field_type` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `prompt_key` varchar(50) NOT NULL,
  `data_type` varchar(10) NOT NULL,
  `customer_readonly` smallint(6) DEFAULT NULL,
  `optlock` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_cf_type_entity` (`entity_id`),
  KEY `FK539F90DEA7AC55E` (`entity_id`),
  CONSTRAINT `contact_field_type_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK539F90DEA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `contact_field_type` */

LOCK TABLES `contact_field_type` WRITE;

UNLOCK TABLES;

/*Table structure for table `contact_map` */

DROP TABLE IF EXISTS `contact_map`;

CREATE TABLE `contact_map` (
  `id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_map_i_3` (`contact_id`),
  KEY `contact_map_i_1` (`table_id`,`foreign_id`,`type_id`),
  KEY `FK274E8BD9CD23330` (`contact_id`),
  KEY `FK274E8BDDD2012ED` (`table_id`),
  KEY `FK274E8BD35D6FCBC` (`type_id`),
  CONSTRAINT `contact_map_FK_3` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `contact_map_FK_1` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `contact_map_FK_2` FOREIGN KEY (`type_id`) REFERENCES `contact_type` (`id`),
  CONSTRAINT `FK274E8BD35D6FCBC` FOREIGN KEY (`type_id`) REFERENCES `contact_type` (`id`),
  CONSTRAINT `FK274E8BD9CD23330` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK274E8BDDD2012ED` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `contact_map` */

LOCK TABLES `contact_map` WRITE;

insert  into `contact_map`(`id`,`contact_id`,`type_id`,`table_id`,`foreign_id`,`OPTLOCK`) values (678001,101,1,5,11,0),(678002,102,20,10,10,0);

UNLOCK TABLES;

/*Table structure for table `contact_type` */

DROP TABLE IF EXISTS `contact_type`;

CREATE TABLE `contact_type` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `is_primary` smallint(6) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4C2BB7F9A7AC55E` (`entity_id`),
  CONSTRAINT `contact_type_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK4C2BB7F9A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `contact_type` */

LOCK TABLES `contact_type` WRITE;

insert  into `contact_type`(`id`,`entity_id`,`is_primary`,`OPTLOCK`) values (1,NULL,NULL,0),(20,11,1,0);

UNLOCK TABLES;

/*Table structure for table `country` */

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `country` */

LOCK TABLES `country` WRITE;

insert  into `country`(`id`,`code`) values (1,'AF'),(2,'AL'),(3,'DZ'),(4,'AS'),(5,'AD'),(6,'AO'),(7,'AI'),(8,'AQ'),(9,'AG'),(10,'AR'),(11,'AM'),(12,'AW'),(13,'AU'),(14,'AT'),(15,'AZ'),(16,'BS'),(17,'BH'),(18,'BD'),(19,'BB'),(20,'BY'),(21,'BE'),(22,'BZ'),(23,'BJ'),(24,'BM'),(25,'BT'),(26,'BO'),(27,'BA'),(28,'BW'),(29,'BV'),(30,'BR'),(31,'IO'),(32,'BN'),(33,'BG'),(34,'BF'),(35,'BI'),(36,'KH'),(37,'CM'),(38,'CA'),(39,'CV'),(40,'KY'),(41,'CF'),(42,'TD'),(43,'CL'),(44,'CN'),(45,'CX'),(46,'CC'),(47,'CO'),(48,'KM'),(49,'CG'),(50,'CK'),(51,'CR'),(52,'CI'),(53,'HR'),(54,'CU'),(55,'CY'),(56,'CZ'),(57,'CD'),(58,'DK'),(59,'DJ'),(60,'DM'),(61,'DO'),(62,'TP'),(63,'EC'),(64,'EG'),(65,'SV'),(66,'GQ'),(67,'ER'),(68,'EE'),(69,'ET'),(70,'FK'),(71,'FO'),(72,'FJ'),(73,'FI'),(74,'FR'),(75,'GF'),(76,'PF'),(77,'TF'),(78,'GA'),(79,'GM'),(80,'GE'),(81,'DE'),(82,'GH'),(83,'GI'),(84,'GR'),(85,'GL'),(86,'GD'),(87,'GP'),(88,'GU'),(89,'GT'),(90,'GN'),(91,'GW'),(92,'GY'),(93,'HT'),(94,'HM'),(95,'HN'),(96,'HK'),(97,'HU'),(98,'IS'),(99,'IN'),(100,'ID'),(101,'IR'),(102,'IQ'),(103,'IE'),(104,'IL'),(105,'IT'),(106,'JM'),(107,'JP'),(108,'JO'),(109,'KZ'),(110,'KE'),(111,'KI'),(112,'KR'),(113,'KW'),(114,'KG'),(115,'LA'),(116,'LV'),(117,'LB'),(118,'LS'),(119,'LR'),(120,'LY'),(121,'LI'),(122,'LT'),(123,'LU'),(124,'MO'),(125,'MK'),(126,'MG'),(127,'MW'),(128,'MY'),(129,'MV'),(130,'ML'),(131,'MT'),(132,'MH'),(133,'MQ'),(134,'MR'),(135,'MU'),(136,'YT'),(137,'MX'),(138,'FM'),(139,'MD'),(140,'MC'),(141,'MN'),(142,'MS'),(143,'MA'),(144,'MZ'),(145,'MM'),(146,'NA'),(147,'NR'),(148,'NP'),(149,'NL'),(150,'AN'),(151,'NC'),(152,'NZ'),(153,'NI'),(154,'NE'),(155,'NG'),(156,'NU'),(157,'NF'),(158,'KP'),(159,'MP'),(160,'NO'),(161,'OM'),(162,'PK'),(163,'PW'),(164,'PA'),(165,'PG'),(166,'PY'),(167,'PE'),(168,'PH'),(169,'PN'),(170,'PL'),(171,'PT'),(172,'PR'),(173,'QA'),(174,'RE'),(175,'RO'),(176,'RU'),(177,'RW'),(178,'WS'),(179,'SM'),(180,'ST'),(181,'SA'),(182,'SN'),(183,'YU'),(184,'SC'),(185,'SL'),(186,'SG'),(187,'SK'),(188,'SI'),(189,'SB'),(190,'SO'),(191,'ZA'),(192,'GS'),(193,'ES'),(194,'LK'),(195,'SH'),(196,'KN'),(197,'LC'),(198,'PM'),(199,'VC'),(200,'SD'),(201,'SR'),(202,'SJ'),(203,'SZ'),(204,'SE'),(205,'CH'),(206,'SY'),(207,'TW'),(208,'TJ'),(209,'TZ'),(210,'TH'),(211,'TG'),(212,'TK'),(213,'TO'),(214,'TT'),(215,'TN'),(216,'TR'),(217,'TM'),(218,'TC'),(219,'TV'),(220,'UG'),(221,'UA'),(222,'AE'),(223,'UK'),(224,'US'),(225,'UM'),(226,'UY'),(227,'UZ'),(228,'VU'),(229,'VA'),(230,'VE'),(231,'VN'),(232,'VG'),(233,'VI'),(234,'WF'),(235,'YE'),(236,'ZM'),(237,'ZW');

UNLOCK TABLES;

/*Table structure for table `credit_card` */

DROP TABLE IF EXISTS `credit_card`;

CREATE TABLE `credit_card` (
  `id` int(11) NOT NULL,
  `cc_number` varchar(100) NOT NULL,
  `cc_number_plain` varchar(20) DEFAULT NULL,
  `cc_expiry` datetime NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `cc_type` int(11) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `gateway_key` varchar(100) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_cc_number` (`cc_number_plain`),
  KEY `ix_cc_number_encrypted` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `credit_card` */

LOCK TABLES `credit_card` WRITE;

UNLOCK TABLES;

/*Table structure for table `currency` */

DROP TABLE IF EXISTS `currency`;

CREATE TABLE `currency` (
  `id` int(11) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `code` varchar(3) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `currency` */

LOCK TABLES `currency` WRITE;

insert  into `currency`(`id`,`symbol`,`code`,`country_code`,`OPTLOCK`) values (1,'US$','USD','US',1),(2,'C$','CAD','CA',0),(3,'&#8364;','EUR','EU',0),(4,'&#165;','JPY','JP',0),(5,'&#163;','GBP','UK',0),(6,'&#8361;','KRW','KR',0),(7,'Sf','CHF','CH',0),(8,'SeK','SEK','SE',0),(9,'S$','SGD','SG',0),(10,'M$','MYR','MY',0),(11,'$','AUD','AU',0);

UNLOCK TABLES;

/*Table structure for table `currency_entity_map` */

DROP TABLE IF EXISTS `currency_entity_map`;

CREATE TABLE `currency_entity_map` (
  `currency_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  KEY `currency_entity_map_i_2` (`currency_id`,`entity_id`),
  KEY `FK7286FEEBF4F395B` (`currency_id`),
  KEY `FK7286FEEA7AC55E` (`entity_id`),
  CONSTRAINT `currency_entity_map_FK_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `currency_entity_map_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK7286FEEA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK7286FEEBF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `currency_entity_map` */

LOCK TABLES `currency_entity_map` WRITE;

insert  into `currency_entity_map`(`currency_id`,`entity_id`) values (1,11);

UNLOCK TABLES;

/*Table structure for table `currency_exchange` */

DROP TABLE IF EXISTS `currency_exchange`;

CREATE TABLE `currency_exchange` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `rate` decimal(22,10) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD1015291BF4F395B` (`currency_id`),
  CONSTRAINT `currency_exchange_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FKD1015291BF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `currency_exchange` */

LOCK TABLES `currency_exchange` WRITE;

insert  into `currency_exchange`(`id`,`entity_id`,`currency_id`,`rate`,`create_datetime`,`OPTLOCK`) values (1,0,2,1.3250000000,'2004-03-09 00:00:00',1),(2,0,3,0.8118000000,'2004-03-09 00:00:00',1),(3,0,4,111.4000000000,'2004-03-09 00:00:00',1),(4,0,5,0.5479000000,'2004-03-09 00:00:00',1),(5,0,6,1171.0000000000,'2004-03-09 00:00:00',1),(6,0,7,1.2300000000,'2004-07-06 00:00:00',1),(7,0,8,7.4700000000,'2004-07-06 00:00:00',1),(10,0,9,1.6800000000,'2004-10-12 00:00:00',1),(11,0,10,3.8000000000,'2004-10-12 00:00:00',1),(12,0,11,1.2880000000,'2007-01-25 00:00:00',1);

UNLOCK TABLES;

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `referral_fee_paid` smallint(6) DEFAULT NULL,
  `invoice_delivery_method_id` int(11) NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `auto_payment_type` int(11) DEFAULT NULL,
  `due_date_unit_id` int(11) DEFAULT NULL,
  `due_date_value` int(11) DEFAULT NULL,
  `df_fm` smallint(6) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_parent` smallint(6) DEFAULT NULL,
  `exclude_aging` smallint(6) NOT NULL DEFAULT '0',
  `invoice_child` smallint(6) DEFAULT NULL,
  `current_order_id` int(11) DEFAULT NULL,
  `balance_type` int(11) NOT NULL DEFAULT '1',
  `dynamic_balance` decimal(22,10) DEFAULT NULL,
  `credit_limit` decimal(22,10) DEFAULT NULL,
  `auto_recharge` decimal(22,10) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_i_2` (`user_id`),
  KEY `FK24217FDE49B7B4B4` (`invoice_delivery_method_id`),
  KEY `FK24217FDE7A85DBFE` (`user_id`),
  KEY `FK24217FDEBAB9E7B` (`partner_id`),
  KEY `FK24217FDECD59C84C` (`parent_id`),
  CONSTRAINT `customer_FK_3` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `customer_FK_1` FOREIGN KEY (`invoice_delivery_method_id`) REFERENCES `invoice_delivery_method` (`id`),
  CONSTRAINT `customer_FK_2` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`),
  CONSTRAINT `FK24217FDE49B7B4B4` FOREIGN KEY (`invoice_delivery_method_id`) REFERENCES `invoice_delivery_method` (`id`),
  CONSTRAINT `FK24217FDE7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK24217FDEBAB9E7B` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`),
  CONSTRAINT `FK24217FDECD59C84C` FOREIGN KEY (`parent_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

LOCK TABLES `customer` WRITE;

UNLOCK TABLES;

/*Table structure for table `entity` */

DROP TABLE IF EXISTS `entity`;

CREATE TABLE `entity` (
  `id` int(11) NOT NULL,
  `external_id` varchar(20) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `language_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB29DE3E3BF4F395B` (`currency_id`),
  KEY `FKB29DE3E3ED34C00D` (`language_id`),
  CONSTRAINT `entity_FK_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `entity_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FKB29DE3E3BF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FKB29DE3E3ED34C00D` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `entity` */

LOCK TABLES `entity` WRITE;

insert  into `entity`(`id`,`external_id`,`description`,`create_datetime`,`language_id`,`currency_id`,`OPTLOCK`) values (11,NULL,'Comtalk A/S','2013-07-05 14:07:48',1,1,1);

UNLOCK TABLES;

/*Table structure for table `entity_delivery_method_map` */

DROP TABLE IF EXISTS `entity_delivery_method_map`;

CREATE TABLE `entity_delivery_method_map` (
  `method_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  KEY `FKEBD7E7CDA7AC55E` (`entity_id`),
  KEY `FKEBD7E7CD5A9B2CED` (`method_id`),
  CONSTRAINT `entity_delivery_method_map_FK_2` FOREIGN KEY (`method_id`) REFERENCES `invoice_delivery_method` (`id`),
  CONSTRAINT `entity_delivery_method_map_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FKEBD7E7CD5A9B2CED` FOREIGN KEY (`method_id`) REFERENCES `invoice_delivery_method` (`id`),
  CONSTRAINT `FKEBD7E7CDA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `entity_delivery_method_map` */

LOCK TABLES `entity_delivery_method_map` WRITE;

insert  into `entity_delivery_method_map`(`method_id`,`entity_id`) values (1,11),(2,11),(3,11);

UNLOCK TABLES;

/*Table structure for table `entity_payment_method_map` */

DROP TABLE IF EXISTS `entity_payment_method_map`;

CREATE TABLE `entity_payment_method_map` (
  `entity_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  KEY `FK59BAAAB3A7AC55E` (`entity_id`),
  KEY `FK59BAAAB349AE3B28` (`payment_method_id`),
  CONSTRAINT `entity_payment_method_map_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `entity_payment_method_map_FK_1` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FK59BAAAB349AE3B28` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FK59BAAAB3A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `entity_payment_method_map` */

LOCK TABLES `entity_payment_method_map` WRITE;

insert  into `entity_payment_method_map`(`entity_id`,`payment_method_id`) values (11,1),(11,2),(11,3);

UNLOCK TABLES;

/*Table structure for table `entity_report_map` */

DROP TABLE IF EXISTS `entity_report_map`;

CREATE TABLE `entity_report_map` (
  `report_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`entity_id`),
  KEY `FK856DA5ADA7AC55E` (`entity_id`),
  KEY `FK856DA5AD5CD8E463` (`report_id`),
  CONSTRAINT `entity_report_map_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `entity_report_map_FK_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
  CONSTRAINT `FK856DA5AD5CD8E463` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
  CONSTRAINT `FK856DA5ADA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `entity_report_map` */

LOCK TABLES `entity_report_map` WRITE;

insert  into `entity_report_map`(`report_id`,`entity_id`) values (1,11),(2,11),(3,11),(4,11),(5,11),(6,11),(7,11),(8,11),(9,11);

UNLOCK TABLES;

/*Table structure for table `event_log` */

DROP TABLE IF EXISTS `event_log`;

CREATE TABLE `event_log` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `affected_user_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `foreign_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `level_field` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `old_num` int(11) DEFAULT NULL,
  `old_str` varchar(1000) DEFAULT NULL,
  `old_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_el_main` (`module_id`,`message_id`,`create_datetime`),
  KEY `FK1E4681FA7AC55E` (`entity_id`),
  KEY `FK1E4681F597F77EE` (`module_id`),
  KEY `FK1E4681F7A85DBFE` (`user_id`),
  KEY `FK1E4681F74A049FE` (`message_id`),
  KEY `FK1E4681F21DFC133` (`affected_user_id`),
  KEY `FK1E4681FDD2012ED` (`table_id`),
  CONSTRAINT `event_log_FK_6` FOREIGN KEY (`message_id`) REFERENCES `event_log_message` (`id`),
  CONSTRAINT `event_log_FK_1` FOREIGN KEY (`module_id`) REFERENCES `event_log_module` (`id`),
  CONSTRAINT `event_log_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `event_log_FK_3` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `event_log_FK_4` FOREIGN KEY (`affected_user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `event_log_FK_5` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `FK1E4681F21DFC133` FOREIGN KEY (`affected_user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK1E4681F597F77EE` FOREIGN KEY (`module_id`) REFERENCES `event_log_module` (`id`),
  CONSTRAINT `FK1E4681F74A049FE` FOREIGN KEY (`message_id`) REFERENCES `event_log_message` (`id`),
  CONSTRAINT `FK1E4681F7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK1E4681FA7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK1E4681FDD2012ED` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `event_log` */

LOCK TABLES `event_log` WRITE;

UNLOCK TABLES;

/*Table structure for table `event_log_message` */

DROP TABLE IF EXISTS `event_log_message`;

CREATE TABLE `event_log_message` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `event_log_message` */

LOCK TABLES `event_log_message` WRITE;

insert  into `event_log_message`(`id`) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34);

UNLOCK TABLES;

/*Table structure for table `event_log_module` */

DROP TABLE IF EXISTS `event_log_module`;

CREATE TABLE `event_log_module` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `event_log_module` */

LOCK TABLES `event_log_module` WRITE;

insert  into `event_log_module`(`id`) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15);

UNLOCK TABLES;

/*Table structure for table `filter` */

DROP TABLE IF EXISTS `filter`;

CREATE TABLE `filter` (
  `id` int(11) NOT NULL,
  `filter_set_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `constraint_type` varchar(255) NOT NULL,
  `field` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `visible` bit(1) NOT NULL,
  `integer_value` int(11) DEFAULT NULL,
  `string_value` varchar(255) DEFAULT NULL,
  `start_date_value` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date_value` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `boolean_value` bit(1) DEFAULT NULL,
  `decimal_value` decimal(22,10) DEFAULT NULL,
  `decimal_high_value` decimal(22,10) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB408CB78D235B8C` (`filter_set_id`),
  CONSTRAINT `filter_FK_1` FOREIGN KEY (`filter_set_id`) REFERENCES `filter_set` (`id`),
  CONSTRAINT `FKB408CB78D235B8C` FOREIGN KEY (`filter_set_id`) REFERENCES `filter_set` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `filter` */

LOCK TABLES `filter` WRITE;

UNLOCK TABLES;

/*Table structure for table `filter_set` */

DROP TABLE IF EXISTS `filter_set`;

CREATE TABLE `filter_set` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `filter_set` */

LOCK TABLES `filter_set` WRITE;

UNLOCK TABLES;

/*Table structure for table `generic_status` */

DROP TABLE IF EXISTS `generic_status`;

CREATE TABLE `generic_status` (
  `id` int(11) NOT NULL,
  `dtype` varchar(40) NOT NULL,
  `status_value` int(11) NOT NULL,
  `can_login` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generic_status_FK_1` (`dtype`),
  CONSTRAINT `generic_status_FK_1` FOREIGN KEY (`dtype`) REFERENCES `generic_status_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `generic_status` */

LOCK TABLES `generic_status` WRITE;

insert  into `generic_status`(`id`,`dtype`,`status_value`,`can_login`) values (1,'user_status',1,1),(2,'user_status',2,1),(3,'user_status',3,1),(4,'user_status',4,1),(5,'user_status',5,0),(6,'user_status',6,0),(7,'user_status',7,0),(8,'user_status',8,0),(9,'subscriber_status',1,NULL),(10,'subscriber_status',2,NULL),(11,'subscriber_status',3,NULL),(12,'subscriber_status',4,NULL),(13,'subscriber_status',5,NULL),(14,'subscriber_status',6,NULL),(15,'subscriber_status',7,NULL),(16,'order_status',1,NULL),(17,'order_status',2,NULL),(18,'order_status',3,NULL),(19,'order_status',4,NULL),(20,'order_line_provisioning_status',1,NULL),(21,'order_line_provisioning_status',2,NULL),(22,'order_line_provisioning_status',3,NULL),(23,'order_line_provisioning_status',4,NULL),(24,'order_line_provisioning_status',5,NULL),(25,'order_line_provisioning_status',6,NULL),(26,'invoice_status',1,NULL),(27,'invoice_status',2,NULL),(28,'invoice_status',3,NULL),(29,'mediation_record_status',1,NULL),(30,'mediation_record_status',2,NULL),(31,'mediation_record_status',3,NULL),(32,'mediation_record_status',4,NULL),(33,'process_run_status',1,NULL),(34,'process_run_status',2,NULL),(35,'process_run_status',3,NULL);

UNLOCK TABLES;

/*Table structure for table `generic_status_type` */

DROP TABLE IF EXISTS `generic_status_type`;

CREATE TABLE `generic_status_type` (
  `id` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `generic_status_type` */

LOCK TABLES `generic_status_type` WRITE;

insert  into `generic_status_type`(`id`) values ('invoice_status'),('mediation_record_status'),('order_line_provisioning_status'),('order_status'),('process_run_status'),('subscriber_status'),('user_status');

UNLOCK TABLES;

/*Table structure for table `international_description` */

DROP TABLE IF EXISTS `international_description`;

CREATE TABLE `international_description` (
  `table_id` int(11) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `psudo_column` varchar(20) NOT NULL,
  `language_id` int(11) NOT NULL,
  `content` varchar(4000) NOT NULL,
  PRIMARY KEY (`table_id`,`foreign_id`,`psudo_column`,`language_id`),
  KEY `international_description_i_2` (`table_id`,`foreign_id`,`language_id`),
  KEY `int_description_i_lan` (`language_id`),
  CONSTRAINT `international_description_FK_2` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `international_description_FK_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `international_description` */

LOCK TABLES `international_description` WRITE;

insert  into `international_description`(`table_id`,`foreign_id`,`psudo_column`,`language_id`,`content`) values (4,1,'description',1,'United States Dollar'),(4,1,'description',2,'Dólares Norte Americanos'),(4,2,'description',1,'Canadian Dollar'),(4,2,'description',2,'Dólares Canadianos'),(4,3,'description',1,'Euro'),(4,3,'description',2,'Euro'),(4,4,'description',1,'Yen'),(4,4,'description',2,'Ien'),(4,5,'description',1,'Pound Sterling'),(4,5,'description',2,'Libras Estrelinas'),(4,6,'description',1,'Won'),(4,6,'description',2,'Won'),(4,7,'description',1,'Swiss Franc'),(4,7,'description',2,'Franco Suíço'),(4,8,'description',1,'Swedish Krona'),(4,8,'description',2,'Coroa Sueca'),(4,9,'description',1,'Singapore Dollar'),(4,9,'description',2,'Dólar da Singapura'),(4,10,'description',1,'Malaysian Ringgit'),(4,10,'description',2,'Ringgit Malasiano'),(4,11,'description',1,'Australian Dollar'),(4,11,'description',2,'Dólar Australiano'),(6,1,'description',1,'Month'),(6,1,'description',2,'Mês'),(6,2,'description',1,'Week'),(6,2,'description',2,'Semana'),(6,3,'description',1,'Day'),(6,3,'description',2,'Dia'),(6,4,'description',1,'Year'),(6,4,'description',2,'Ano'),(7,1,'description',1,'Email'),(7,1,'description',2,'Email'),(7,2,'description',1,'Paper'),(7,2,'description',2,'Papel'),(7,3,'description',1,'Email + Paper'),(7,3,'description',2,'Email + Papel'),(9,1,'description',1,'Active'),(9,1,'description',2,'Activo'),(9,2,'description',1,'Overdue'),(9,2,'description',2,'Em aberto'),(9,3,'description',1,'Overdue 2'),(9,3,'description',2,'Em aberto 2'),(9,4,'description',1,'Overdue 3'),(9,4,'description',2,'Em aberto 3'),(9,5,'description',1,'Suspended'),(9,5,'description',2,'Suspensa'),(9,6,'description',1,'Suspended 2'),(9,6,'description',2,'Suspensa 2'),(9,7,'description',1,'Suspended 3'),(9,7,'description',2,'Suspensa 3'),(9,8,'description',1,'Deleted'),(9,8,'description',2,'Eliminado'),(17,1,'description',1,'One time'),(17,1,'description',2,'Vez única'),(17,200,'description',1,'Monthly'),(18,1,'description',1,'Items'),(18,1,'description',2,'Items'),(18,2,'description',1,'Tax'),(18,2,'description',2,'Imposto'),(18,3,'description',1,'Penalty'),(18,3,'description',2,'Penalidade'),(19,1,'description',1,'pre paid'),(19,1,'description',2,'Pré pago'),(19,2,'description',1,'post paid'),(19,2,'description',2,'Pós pago'),(20,1,'description',1,'Active'),(20,1,'description',2,'Activo'),(20,2,'description',1,'Finished'),(20,2,'description',2,'Terminado'),(20,3,'description',1,'Suspended'),(20,3,'description',2,'Suspenso'),(20,4,'description',1,'Suspended (auto)'),(20,4,'description',2,'Suspender (auto)'),(23,1,'description',1,'Item management and order line total calculation'),(23,2,'description',1,'Billing process: order filters'),(23,3,'description',1,'Billing process: invoice filters'),(23,4,'description',1,'Invoice presentation'),(23,5,'description',1,'Billing process: order periods calculation'),(23,6,'description',1,'Payment gateway integration'),(23,7,'description',1,'Notifications'),(23,8,'description',1,'Payment instrument selection'),(23,9,'description',1,'Penalties for overdue invoices'),(23,10,'description',1,'Alarms when a payment gateway is down'),(23,11,'description',1,'Subscription status manager'),(23,12,'description',1,'Parameters for asynchronous payment processing'),(23,13,'description',1,'Add one product to order'),(23,14,'description',1,'Product pricing'),(23,15,'description',1,'Mediation Reader'),(23,16,'description',1,'Mediation Processor'),(23,17,'description',1,'Generic internal events listener'),(23,18,'description',1,'External provisioning processor'),(23,19,'description',1,'Purchase validation against pre-paid balance / credit limit'),(23,20,'description',1,'Billing process: customer selection'),(23,21,'description',1,'Mediation Error Handler'),(23,22,'description',1,'Scheduled Plug-ins'),(23,23,'description',1,'Rules Generators'),(23,24,'description',1,'Ageing for customers with overdue invoices'),(24,1,'description',1,'Calculates the order total and the total for each line, considering the item prices, the quantity and if the prices are percentage or not.'),(24,1,'title',1,'Default order totals'),(24,2,'description',1,'Adds an additional line to the order with a percentage charge to represent the value added tax.'),(24,2,'title',1,'VAT'),(24,3,'description',1,'A very simple implementation that sets the due date of the invoice. The due date is calculated by just adding the period of time to the invoice date.'),(24,3,'title',1,'Invoice due date'),(24,4,'description',1,'This task will copy all the lines on the orders and invoices to the new invoice, considering the periods involved for each order, but not the fractions of periods. It will not copy the lines that are taxes. The quantity and total of each line will be multiplied by the amount of periods.'),(24,4,'title',1,'Default invoice composition.'),(24,5,'description',1,'Decides if an order should be included in an invoice for a given billing process.  This is done by taking the billing process time span, the order period, the active since/until, etc.'),(24,5,'title',1,'Standard Order Filter'),(24,6,'description',1,'Always returns true, meaning that the overdue invoice will be carried over to a new invoice.'),(24,6,'title',1,'Standard Invoice Filter'),(24,7,'description',1,'Calculates the start and end period to be included in an invoice. This is done by taking the billing process time span, the order period, the active since/until, etc.'),(24,7,'title',1,'Default Order Periods'),(24,8,'description',1,'Integration with the authorize.net payment gateway.'),(24,8,'title',1,'Authorize.net payment processor'),(24,9,'description',1,'Notifies a user by sending an email. It supports text and HTML emails'),(24,9,'title',1,'Standard Email Notification'),(24,10,'description',1,'Finds the information of a payment method available to a customer, given priority to credit card. In other words, it will return the credit car of a customer or the ACH information in that order.'),(24,10,'title',1,'Default payment information'),(24,11,'description',1,'Plug-in useful only for testing'),(24,11,'title',1,'Testing plug-in for partner payouts'),(24,12,'description',1,'Will generate a PDF version of an invoice.'),(24,12,'title',1,'PDF invoice notification'),(24,14,'description',1,'Returns always false, which makes jBilling to never carry over an invoice into another newer invoice.'),(24,14,'title',1,'No invoice carry over'),(24,15,'description',1,'Will create a new order with a penalty item. The item is taken as a parameter to the task.'),(24,15,'title',1,'Default interest task'),(24,16,'description',1,'Extends BasicOrderFilterTask, modifying the dates to make the order applicable a number of months before it would be by using the default filter.'),(24,16,'title',1,'Anticipated order filter'),(24,17,'description',1,'Extends BasicOrderPeriodTask, modifying the dates to make the order applicable a number of months before itd be by using the default task.'),(24,17,'title',1,'Anticipate order periods.'),(24,19,'description',1,'Extends the standard authorize.net payment processor to also send an email to the company after processing the payment.'),(24,19,'title',1,'Email & process authorize.net'),(24,20,'description',1,'Sends an email to the billing administrator as an alarm when a payment gateway is down.'),(24,20,'title',1,'Payment gateway down alarm'),(24,21,'description',1,'A test payment processor implementation to be able to test jBillings functions without using a real payment gateway.'),(24,21,'title',1,'Test payment processor'),(24,22,'description',1,'Allows a customer to be assigned a specific payment gateway. It checks a custom contact field to identify the gateway and then delegates the actual payment processing to another plugin.'),(24,22,'title',1,'Router payment processor based on Custom Fields'),(24,23,'description',1,'It determines how a payment event affects the subscription status of a user, considering its present status and a state machine.'),(24,23,'title',1,'Default subscription status manager'),(24,24,'description',1,'Integration with the ACH commerce payment gateway.'),(24,24,'title',1,'ACH Commerce payment processor'),(24,25,'description',1,'A dummy task that does not add any parameters for asynchronous payment processing. This is the default.'),(24,25,'title',1,'Standard asynchronous parameters'),(24,26,'description',1,'This plug-in adds parameters for asynchronous payment processing to have one processing message bean per payment processor. It is used in combination with the router payment processor plug-ins.'),(24,26,'title',1,'Router asynchronous parameters'),(24,28,'description',1,'It adds items to an order. If the item is already in the order, it only updates the quantity.'),(24,28,'title',1,'Standard Item Manager'),(24,29,'description',1,'This is a rules-based plug-in. It will do what the basic item manager does (actually calling it); but then it will execute external rules as well. These external rules have full control on changing the order that is getting new items.'),(24,29,'title',1,'Rules Item Manager'),(24,30,'description',1,'This is a rules-based plug-in. It calculates the total for an order line (typically this is the price multiplied by the quantity); allowing for the execution of external rules.'),(24,30,'title',1,'Rules Line Total'),(24,31,'description',1,'This is a rules-based plug-in. It gives a price to an item by executing external rules. You can then add logic externally for pricing. It is also integrated with the mediation process by having access to the mediation pricing data.'),(24,31,'title',1,'Rules Pricing'),(24,32,'description',1,'This is a reader for the mediation process. It reads records from a text file whose fields are separated by a character (or string).'),(24,32,'title',1,'Separator file reader'),(24,33,'description',1,'This is a rules-based plug-in (see chapter 7). It takes an event record from the mediation process and executes external rules to translate the record into billing meaningful data. This is at the core of the mediation component, see the ?Telecom Guide? document for more information.'),(24,33,'title',1,'Rules mediation processor'),(24,34,'description',1,'This is a reader for the mediation process. It reads records from a text file whose fields have fixed positions,and the record has a fixed length.'),(24,34,'title',1,'Fixed length file reader'),(24,35,'description',1,'This is exactly the same as the standard payment information task, the only difference is that it does not validate if the credit card is expired. Use this plug-in only if you want to submit payment with expired credit cards.'),(24,35,'title',1,'Payment information without validation'),(24,36,'description',1,'This plug-in is only used for testing purposes. Instead of sending an email (or other real notification); it simply stores the text to be sent in a file named emails_sent.txt.'),(24,36,'title',1,'Notification task for testing'),(24,37,'description',1,'This plugin takes into consideration the field cycle starts of orders to calculate fractional order periods.'),(24,37,'title',1,'Order periods calculator with pro rating.'),(24,38,'description',1,'When creating an invoice from an order, this plug-in will pro-rate any fraction of a period taking a day as the smallest billable unit.'),(24,38,'title',1,'Invoice composition task with pro-rating (day as fraction)'),(24,39,'description',1,'Integration with the Intraanuity payment gateway.'),(24,39,'title',1,'Payment process for the Intraanuity payment gateway'),(24,40,'description',1,'This plug-in will create a new order with a negative price to reflect a credit when an order is canceled within a period that has been already invoiced.'),(24,40,'title',1,'Automatic cancellation credit.'),(24,41,'description',1,'This plug-in will use external rules to determine if an order that is being canceled should create a new order with a penalty fee. This is typically used for early cancels of a contract.'),(24,41,'title',1,'Fees for early cancellation of a plan.'),(24,42,'description',1,'Used for blocking payments from reaching real payment processors. Typically configured as first payment processor in the processing chain.'),(24,42,'title',1,'Blacklist filter payment processor.'),(24,43,'description',1,'Causes users and their associated details (e.g., credit card number, phone number, etc.) to be blacklisted when their status becomes suspended or higher. '),(24,43,'title',1,'Blacklist user when their status becomes suspended or higher.'),(24,44,'description',1,'This is a reader for the mediation process. It reads records from a JDBC database source.'),(24,44,'title',1,'JDBC Mediation Reader.'),(24,45,'description',1,'This is a reader for the mediation process. It is an extension of the JDBC reader, allowing easy configuration of a MySQL database source.'),(24,45,'title',1,'MySQL Mediation Reader.'),(24,46,'description',1,'Responds to order related events. Runs rules to generate commands to send via JMS messages to the external provisioning module.'),(24,46,'title',1,'Provisioning commands rules task.'),(24,47,'description',1,'This plug-in is only used for testing purposes. It is a test external provisioning task for testing the provisioning modules.'),(24,47,'title',1,'Test external provisioning task.'),(24,48,'description',1,'An external provisioning plug-in for communicating with the Ericsson Customer Administration Interface (CAI).'),(24,48,'title',1,'CAI external provisioning task.'),(24,49,'description',1,'Delegates the actual payment processing to another plug-in based on the currency of the payment.'),(24,49,'title',1,'Currency Router payment processor'),(24,50,'description',1,'An external provisioning plug-in for communicating with the TeliaSonera MMSC.'),(24,50,'title',1,'MMSC external provisioning task.'),(24,51,'description',1,'This filter will only invoices with a positive balance to be carried over to the next invoice.'),(24,51,'title',1,'Filters out negative invoices for carry over.'),(24,52,'description',1,'It will generate a file with one line per invoice generated.'),(24,52,'title',1,'File invoice exporter.'),(24,53,'description',1,'It will call a package of rules when an internal event happens.'),(24,53,'title',1,'Rules caller on an event.'),(24,54,'description',1,'It will update the dynamic balance of a customer (pre-paid or credit limit) when events affecting the balance happen.'),(24,54,'title',1,'Dynamic balance manager'),(24,55,'description',1,'Used for real-time mediation, this plug-in will validate a call based on the current dynamic balance of a customer.'),(24,55,'title',1,'Balance validator based on the customer balance.'),(24,56,'description',1,'Used for real-time mediation, this plug-in will validate a call based on a package or rules'),(24,56,'title',1,'Balance validator based on rules.'),(24,57,'description',1,'Integration with the Payments Gateway payment processor.'),(24,57,'title',1,'Payment processor for Payments Gateway.'),(24,58,'description',1,'Saves the credit card information in the payment gateway, rather than the jBilling DB.'),(24,58,'title',1,'Credit cards are stored externally.'),(24,59,'description',1,'This is a rules-based plug-in compatible with the mediation module of jBilling 2.2.x. It will do what the basic item manager does (actually calling it); but then it will execute external rules as well. These external rules have full control on changing the order that is getting new items.'),(24,59,'title',1,'Rules Item Manager 2'),(24,60,'description',1,'This is a rules-based plug-in, compatible with the mediation process of jBilling 2.2.x and later. It calculates the total for an order line (typically this is the price multiplied by the quantity); allowing for the execution of external rules.'),(24,60,'title',1,'Rules Line Total - 2'),(24,61,'description',1,'This is a rules-based plug-in compatible with the mediation module of jBilling 2.2.x. It gives a price to an item by executing external rules. You can then add logic externally for pricing. It is also integrated with the mediation process by having access to the mediation pricing data.'),(24,61,'title',1,'Rules Pricing 2'),(24,63,'description',1,'A fake plug-in to test payments that would be stored externally.'),(24,63,'title',1,'Test payment processor for external storage.'),(24,64,'description',1,'Payment processor plug-in to integrate with RBS WorldPay'),(24,64,'title',1,'WorldPay integration'),(24,65,'description',1,'Payment processor plug-in to integrate with RBS WorldPay. It stores the credit card information (number, etc) in the gateway.'),(24,65,'title',1,'WorldPay integration with external storage'),(24,66,'description',1,'Monitors the balance of a customer and upon reaching a limit, it requests a real-time payment'),(24,66,'title',1,'Auto recharge'),(24,67,'description',1,'Payment processor for integration with the Beanstream payment gateway'),(24,67,'title',1,'Beanstream gateway integration'),(24,68,'description',1,'Payment processor for integration with the Sage payment gateway'),(24,68,'title',1,'Sage payments gateway integration'),(24,69,'description',1,'Called when the billing process runs to select which users to evaluate. This basic implementation simply returns every user not in suspended (or worse) status'),(24,69,'title',1,'Standard billing process users filter'),(24,70,'description',1,'Called when the billing process runs to select which users to evaluate. This only returns users with orders that have a next invoice date earlier than the billing process.'),(24,70,'title',1,'Selective billing process users filter'),(24,71,'description',1,'Event records with errors are saved to a file'),(24,71,'title',1,'Mediation file error handler'),(24,73,'description',1,'Event records with errors are saved to a database table'),(24,73,'title',1,'Mediation data base error handler'),(24,75,'description',1,'Submits payments to paypal as a payment gateway and stores credit card information in PayPal as well'),(24,75,'title',1,'Paypal integration with external storage'),(24,76,'description',1,'Submits payments to authorize.net as a payment gateway and stores credit card information in authorize.net as well'),(24,76,'title',1,'Authorize.net integration with external storage'),(24,77,'description',1,'Delegates the actual payment processing to another plug-in based on the payment method of the payment.'),(24,77,'title',1,'Payment method router payment processor'),(24,78,'description',1,'Generates rules dynamically based on a Velocity template.'),(24,78,'title',1,'Dynamic rules generator'),(24,79,'description',1,'A scheduled task to execute the Mediation Process.'),(24,79,'title',1,'Mediation Process Task'),(24,80,'description',1,'A scheduled task to execute the Billing Process.'),(24,80,'title',1,'Billing Process Task'),(24,87,'description',1,'Ages a user based on the number of days that the account is overdue.'),(24,87,'title',1,'Basic ageing'),(24,88,'description',1,'A scheduled task to execute the Ageing Process.'),(24,88,'title',1,'Ageing process task'),(24,89,'description',1,'Ages a user based on the number of business days (excluding holidays) that the account is overdue.'),(24,89,'title',1,'Business day ageing'),(28,20,'description',1,'Primary'),(35,1,'description',1,'Cheque'),(35,1,'description',2,'Cheque'),(35,2,'description',1,'Visa'),(35,2,'description',2,'Visa'),(35,3,'description',1,'MasterCard'),(35,3,'description',2,'MasterCard'),(35,4,'description',1,'AMEX'),(35,4,'description',2,'AMEX'),(35,5,'description',1,'ACH'),(35,5,'description',2,'CCA'),(35,6,'description',1,'Discovery'),(35,6,'description',2,'Discovery'),(35,7,'description',1,'Diners'),(35,7,'description',2,'Diners'),(35,8,'description',1,'PayPal'),(35,8,'description',2,'PayPal'),(41,1,'description',1,'Successful'),(41,1,'description',2,'Com sucesso'),(41,2,'description',1,'Failed'),(41,2,'description',2,'Sem sucesso'),(41,3,'description',1,'Processor unavailable'),(41,3,'description',2,'Processador indisponível'),(41,4,'description',1,'Entered'),(41,4,'description',2,'Inserido'),(46,1,'description',1,'Billing Process'),(46,1,'description',2,'Processo de Facturação'),(46,2,'description',1,'User maintenance'),(46,2,'description',2,'Manutenção de Utilizador'),(46,3,'description',1,'Item maintenance'),(46,3,'description',2,'Item de manutenção'),(46,4,'description',1,'Item type maintenance'),(46,4,'description',2,'Item tipo de manutenção'),(46,5,'description',1,'Item user price maintenance'),(46,5,'description',2,'Item manutenção de preço de utilizador'),(46,6,'description',1,'Promotion maintenance'),(46,6,'description',2,'Manutenção de promoção'),(46,7,'description',1,'Order maintenance'),(46,7,'description',2,'Manutenção por ordem'),(46,8,'description',1,'Credit card maintenance'),(46,8,'description',2,'Manutenção de cartão de crédito'),(46,9,'description',1,'Invoice maintenance'),(46,9,'description',2,'Manutenção de facturas'),(46,11,'description',1,'Pluggable tasks maintenance'),(46,11,'description',2,'Manutenção de tarefas de plug-ins'),(47,1,'description',1,'A prepaid order has unbilled time before the billing process date'),(47,1,'description',2,'Uma ordem pré-paga tem tempo não facturado anterior à data de facturação'),(47,2,'description',1,'Order has no active time at the date of process.'),(47,2,'description',2,'A ordem não tem nenhum período activo à data de processamento.'),(47,3,'description',1,'At least one complete period has to be billable.'),(47,3,'description',2,'Pelo menos um período completo tem de ser facturável.'),(47,4,'description',1,'Already billed for the current date.'),(47,4,'description',2,'Já há facturação para o período.'),(47,5,'description',1,'This order had to be maked for exclusion in the last process.'),(47,5,'description',2,'Esta ordem teve de ser marcada para exclusão do último processo.'),(47,6,'description',1,'Pre-paid order is being process after its expiration.'),(47,6,'description',2,'Pre-paid order is being process after its expiration.'),(47,7,'description',1,'A row was marked as deleted.'),(47,7,'description',2,'A linha marcada foi eliminada.'),(47,8,'description',1,'A user password was changed.'),(47,8,'description',2,'A senha de utilizador foi alterada.'),(47,9,'description',1,'A row was updated.'),(47,9,'description',2,'Uma linha foi actualizada.'),(47,10,'description',1,'Running a billing process, but a review is found unapproved.'),(47,10,'description',2,'A correr um processo de facturação, foi encontrada uma revisão rejeitada.'),(47,11,'description',1,'Running a billing process, review is required but not present.'),(47,11,'description',2,'A correr um processo de facturação, uma é necessária mas não encontrada.'),(47,12,'description',1,'A user status was changed.'),(47,12,'description',2,'Um status de utilizador foi alterado.'),(47,13,'description',1,'An order status was changed.'),(47,13,'description',2,'Um status de uma ordem foi alterado.'),(47,14,'description',1,'A user had to be aged, but there\'s no more steps configured.'),(47,14,'description',2,'Um utilizador foi inserido no processo de antiguidade, mas não há mais passos configurados.'),(47,15,'description',1,'A partner has a payout ready, but no payment instrument.'),(47,15,'description',2,'Um parceiro tem um pagamento a receber, mas não tem instrumento de pagamento.'),(47,16,'description',1,'A purchase order as been manually applied to an invoice.'),(47,16,'description',2,'Uma ordem de compra foi aplicada manualmente a uma factura.'),(47,17,'description',1,'The order line has been updated'),(47,18,'description',1,'The order next billing date has been changed'),(47,19,'description',1,'Last API call to get the the user subscription status transitions'),(47,20,'description',1,'User subscription status has changed'),(47,21,'description',1,'User account is now locked'),(47,22,'description',1,'The order main subscription flag was changed'),(47,23,'description',1,'All the one-time orders the mediation found were in status finished'),(47,24,'description',1,'A valid payment method was not found. The payment request was cancelled'),(47,25,'description',1,'A new row has been created'),(47,26,'description',1,'An invoiced order was cancelled, a credit order was created'),(47,27,'description',1,'A user id was added to the blacklist'),(47,28,'description',1,'A user id was removed from the blacklist'),(47,29,'description',1,'Posted a provisioning command using a UUID'),(47,30,'description',1,'A command was posted for provisioning'),(47,31,'description',1,'The provisioning status of an order line has changed'),(47,32,'description',1,'User subscription status has NOT changed'),(47,33,'description',1,'The dynamic balance of a user has changed'),(47,34,'description',1,'The invoice if child flag has changed'),(50,1,'description',1,'Process payment with billing process'),(50,1,'description',2,'Processar pagamento com processo de facturação'),(50,2,'description',1,'URL of CSS file'),(50,2,'description',2,'URL ou ficheiro CSS'),(50,3,'description',1,'URL of logo graphic'),(50,3,'description',2,'URL ou gráfico de logotipo'),(50,4,'description',1,'Grace period'),(50,4,'description',2,'Período de graça'),(50,4,'instruction',1,'Grace period in days before ageing a customer with an overdue invoice.'),(50,5,'description',1,'Partner percentage rate'),(50,5,'description',2,'Percentagem do parceiro'),(50,5,'instruction',1,'Partner default percentage commission rate. See the Partner section of the documentation.'),(50,6,'description',1,'Partner referral fee'),(50,6,'description',2,'Valor de referência do parceiro'),(50,6,'instruction',1,'Partner default flat fee to be paid as commission. See the Partner section of the documentation.'),(50,7,'description',1,'Partner one time payout'),(50,7,'description',2,'Parceiro pagamento único'),(50,7,'instruction',1,'Set to \'1\' to enable one-time payment for partners. If set, partners will only get paid once per customer. See the Partner section of the documentation.'),(50,8,'description',1,'Partner period unit payout'),(50,8,'description',2,'Parceiro unidade do período de pagamento'),(50,8,'instruction',1,'Partner default payout period unit. See the Partner section of the documentation.'),(50,9,'description',1,'Partner period value payout'),(50,9,'description',2,'Parceiro valor do período de pagamento'),(50,9,'instruction',1,'Partner default payout period value. See the Partner section of the documentation.'),(50,10,'description',1,'Partner automatic payout'),(50,10,'description',2,'Parceiro pagamento automático'),(50,10,'instruction',1,'Set to \'1\' to enable batch payment payouts using the billing process and the configured payment processor. See the Partner section of the documentation.'),(50,11,'description',1,'User in charge of partners '),(50,11,'description',2,'Utilizador responsável pelos parceiros'),(50,11,'instruction',1,'Partner default assigned clerk id. See the Partner section of the documentation.'),(50,12,'description',1,'Partner fee currency'),(50,12,'description',2,'Parceiro moeda'),(50,12,'instruction',1,'Currency ID to use when paying partners. See the Partner section of the documentation.'),(50,13,'description',1,'Self delivery of paper invoices'),(50,13,'description',2,'Entrega pelo mesmo das facturas em papel'),(50,13,'instruction',1,'Set to \'1\' to e-mail invoices as the billing company. \'0\' to deliver invoices as jBilling.'),(50,14,'description',1,'Include customer notes in invoice'),(50,14,'description',2,'Incluir notas do cliente na factura'),(50,14,'instruction',1,'Set to \'1\' to show notes in invoices, \'0\' to disable.'),(50,15,'description',1,'Days before expiration for order notification'),(50,15,'description',2,'Dias antes da expiração para notificação de ordens'),(50,15,'instruction',1,'Days before the orders \'active until\' date to send the 1st notification. Leave blank to disable.'),(50,16,'description',1,'Days before expiration for order notification 2'),(50,16,'description',2,'Dias antes da expiração para notificação de ordens 2'),(50,16,'instruction',1,'Days before the orders \'active until\' date to send the 2nd notification. Leave blank to disable.'),(50,17,'description',1,'Days before expiration for order notification 3'),(50,17,'description',2,'Dias antes da expiração para notificação de ordens 3'),(50,17,'instruction',1,'Days before the orders \'active until\' date to send the 3rd notification. Leave blank to disable.'),(50,18,'description',1,'Invoice number prefix'),(50,18,'description',2,'Número de prefixo da factura'),(50,18,'instruction',1,'Prefix value for generated invoice public numbers.'),(50,19,'description',1,'Next invoice number'),(50,19,'description',2,'Próximo número de factura'),(50,19,'instruction',1,'The current value for generated invoice public numbers. New invoices will be assigned a public number by incrementing this value.'),(50,20,'description',1,'Manual invoice deletion'),(50,20,'description',2,'Eliminação manual de facturas'),(50,20,'instruction',1,'Set to \'1\' to allow invoices to be deleted, \'0\' to disable.'),(50,21,'description',1,'Use invoice reminders'),(50,21,'description',2,'Usar os lembretes de factura'),(50,21,'instruction',1,'Set to \'1\' to allow invoice reminder notifications, \'0\' to disable.'),(50,22,'description',1,'Number of days after the invoice generation for the first reminder'),(50,22,'description',2,'Número de dias após a geração da factura para o primeiro lembrete'),(50,23,'description',1,'Number of days for next reminder'),(50,23,'description',2,'Número de dias para o próximo lembrete'),(50,24,'description',1,'Data Fattura Fine Mese'),(50,24,'description',2,'Data Factura Fim do Mês'),(50,24,'instruction',1,'Set to \'1\' to enable, \'0\' to disable.'),(50,25,'description',1,'Use overdue penalties (interest).'),(50,25,'instruction',1,'Set to \'1\' to enable the billing process to calculate interest on overdue payments, \'0\' to disable. Calculation of interest is handled by the selected penalty plug-in.'),(50,27,'description',1,'Use order anticipation.'),(50,27,'instruction',1,'Set to \'1\' to use the \'OrderFilterAnticipateTask\' to invoice a number of months in advance, \'0\' to disable. Plug-in must be configured separately.'),(50,28,'description',1,'Paypal account.'),(50,28,'instruction',1,'PayPal account name.'),(50,29,'description',1,'Paypal button URL.'),(50,29,'instruction',1,'A URL where the graphic of the PayPal button resides. The button is displayed to customers when they are making a payment. The default is usually the best option, except when another language is needed.'),(50,30,'description',1,'URL for HTTP ageing callback.'),(50,30,'instruction',1,'URL for the HTTP Callback to invoke when the ageing process changes a status of a user.'),(50,31,'description',1,'Use continuous invoice dates.'),(50,31,'instruction',1,'Default \'2000-01-01\'. If this preference is used, the system will make sure that all your invoices have their dates in a incremental way. Any invoice with a greater \'ID\' will also have a greater (or equal) date. In other words, a new invoice can not have an earlier date than an existing (older) invoice. To use this preference, set it as a string with the date where to start.'),(50,32,'description',1,'Attach PDF invoice to email notification.'),(50,32,'instruction',1,'Set to \'1\' to attach a PDF version of the invoice to all invoice notification e-mails. \'0\' to disable.'),(50,33,'description',1,'Force one order per invoice.'),(50,33,'instruction',1,'Set to \'1\' to show the \'include in separate invoice\' flag on an order. \'0\' to disable.'),(50,35,'description',1,'Add order Id to invoice lines.'),(50,35,'instruction',1,'Set to \'1\' to include the ID of the order in the description text of the resulting invoice line. \'0\' to disable. This can help to easily track which exact orders is responsible for a line in an invoice, considering that many orders can be included in a single invoice.'),(50,36,'description',1,'Allow customers to edit own contact information.'),(50,36,'instruction',1,'Set to \'1\' to allow customers to edit their own contact information. \'0\' to disable.'),(50,37,'description',1,'Hide (mask) credit card numbers.'),(50,37,'instruction',1,'Set to \'1\' to mask all credit card numbers. \'0\' to disable. When set, numbers are masked to all users, even administrators, and in all log files.'),(50,38,'description',1,'Link ageing to customer subscriber status.'),(50,38,'instruction',1,'Set to \'1\' to change the subscription status of a user when the user ages. \'0\' to disable.'),(50,39,'description',1,'Lock-out user after failed login attempts.'),(50,39,'instruction',1,'The number of retries to allow before locking the user account. A locked user account will have their password changed to the value of lockout_password in the jbilling.properties configuration file.'),(50,40,'description',1,'Expire user passwords after days.'),(50,40,'instruction',1,'If greater than zero, it represents the number of days that a password is valid. After those days, the password is expired and the user is forced to change it.'),(50,41,'description',1,'Use main-subscription orders.'),(50,41,'instruction',1,'Set to \'1\' to allow the usage of the \'main subscription\' flag for orders This flag is read only by the mediation process when determining where to place charges coming from external events.'),(50,42,'description',1,'Use pro-rating.'),(50,42,'instruction',1,'Set to \'1\' to allow the use of pro-rating to invoice fractions of a period. Shows the \'cycle\' attribute of an order. Note that you need to configure the corresponding plug-ins for this feature to be fully functional.'),(50,43,'description',1,'Use payment blacklist.'),(50,43,'instruction',1,'If the payment blacklist feature is used, this is set to the id of the configuration of the PaymentFilterTask plug-in. See the Blacklist section of the documentation.'),(50,44,'description',1,'Allow negative payments.'),(50,44,'instruction',1,'Set to \'1\' to allow negative payments. \'0\' to disable'),(50,45,'description',1,'Delay negative invoice payments.'),(50,45,'instruction',1,'Set to \'1\' to delay payment of negative invoice amounts, causing the balance to be carried over to the next invoice. Invoices that have had negative balances from other invoices transferred to them are allowed to immediately make a negative payment (credit) if needed. \'0\' to disable. Preference 44 & 46 are usually also enabled.'),(50,46,'description',1,'Allow invoice without orders.'),(50,46,'instruction',1,'Set to \'1\' to allow invoices with negative balances to generate a new invoice that isn\'t composed of any orders so that their balances will always get carried over to a new invoice for the credit to take place. \'0\' to disable. Preference 44 & 45 are usually also enabled.'),(50,47,'description',1,'Last read mediation record id.'),(50,47,'instruction',1,'ID of the last record read by the mediation process. This is used to determine what records are \'new\' and need to be read.'),(50,48,'description',1,'Use provisioning.'),(50,48,'instruction',1,'Set to \'1\' to allow the use of provisioning. \'0\' to disable.'),(50,49,'description',1,'Automatic customer recharge threshold.'),(50,49,'instruction',1,'The threshold value for automatic payments. Pre-paid users with an automatic recharge value set will generate an automatic payment whenever the account balance falls below this threshold. Note that you need to configure the AutoRechargeTask plug-in for this feature to be fully functional.'),(50,50,'description',1,'Invoice decimal rounding.'),(50,50,'instruction',1,'The number of decimal places to be shown on the invoice. Defaults to 2.'),(52,1,'description',1,'Invoice (email)'),(52,1,'description',2,'Factura (email)'),(52,2,'description',1,'User Reactivated'),(52,2,'description',2,'Utilizador Reactivado'),(52,3,'description',1,'User Overdue'),(52,3,'description',2,'Utilizador Em Atraso'),(52,4,'description',1,'User Overdue 2'),(52,4,'description',2,'Utilizador Em Atraso 2'),(52,5,'description',1,'User Overdue 3'),(52,5,'description',2,'Utilizador Em Atraso 3'),(52,6,'description',1,'User Suspended'),(52,6,'description',2,'Utilizador Suspenso'),(52,7,'description',1,'User Suspended 2'),(52,7,'description',2,'Utilizador Suspenso 2'),(52,8,'description',1,'User Suspended 3'),(52,8,'description',2,'Utilizador Suspenso 3'),(52,9,'description',1,'User Deleted'),(52,9,'description',2,'Utilizador Eliminado'),(52,10,'description',1,'Payout Remainder'),(52,10,'description',2,'Pagamento Remascente'),(52,11,'description',1,'Partner Payout'),(52,11,'description',2,'Parceiro Pagamento'),(52,12,'description',1,'Invoice (paper)'),(52,12,'description',2,'Factura (papel)'),(52,13,'description',1,'Order about to expire. Step 1'),(52,13,'description',2,'Ordem de compra a expirar. Passo 1'),(52,14,'description',1,'Order about to expire. Step 2'),(52,14,'description',2,'Ordem de compra a expirar. Passo 2'),(52,15,'description',1,'Order about to expire. Step 3'),(52,15,'description',2,'Ordem de compra a expirar. Passo 3'),(52,16,'description',1,'Payment (successful)'),(52,16,'description',2,'Payment (com sucesso)'),(52,17,'description',1,'Payment (failed)'),(52,17,'description',2,'Payment (sem sucesso)'),(52,19,'description',1,'Update Credit Card'),(52,19,'description',2,'Actualizar Cartão de Crédito'),(52,20,'description',1,'Lost password'),(52,20,'description',2,'Senha esquecida'),(59,10,'description',1,'Create customer'),(59,11,'description',1,'Edit customer'),(59,12,'description',1,'Delete customer'),(59,13,'description',1,'Inspect customer'),(59,14,'description',1,'Blacklist customer'),(59,15,'description',1,'View customer details'),(59,16,'description',1,'Download customer CSV'),(59,20,'description',1,'Create order'),(59,21,'description',1,'Edit order'),(59,22,'description',1,'Delete order'),(59,23,'description',1,'Generate invoice for order'),(59,24,'description',1,'View order details'),(59,25,'description',1,'Download order CSV'),(59,26,'description',1,'Edit line price'),(59,27,'description',1,'Edit line description'),(59,28,'description',1,'View all customers'),(59,30,'description',1,'Create payment'),(59,31,'description',1,'Edit payment'),(59,32,'description',1,'Delete payment'),(59,33,'description',1,'Link payment to invoice'),(59,34,'description',1,'View payment details'),(59,35,'description',1,'Download payment CSV'),(59,36,'description',1,'View all customers'),(59,40,'description',1,'Create product'),(59,41,'description',1,'Edit product'),(59,42,'description',1,'Delete product'),(59,43,'description',1,'View product details'),(59,44,'description',1,'Download payment CSV'),(59,50,'description',1,'Create product category'),(59,51,'description',1,'Edit product category'),(59,52,'description',1,'Delete product category'),(59,60,'description',1,'Create plan'),(59,61,'description',1,'Edit plan'),(59,62,'description',1,'Delete plan'),(59,63,'description',1,'View plan details'),(59,70,'description',1,'Delete invoice'),(59,71,'description',1,'Send invoice notification'),(59,72,'description',1,'View invoice details'),(59,73,'description',1,'Download invoice CSV'),(59,74,'description',1,'View all customers'),(59,80,'description',1,'Approve / Disapprove review'),(59,90,'description',1,'Show customer menu'),(59,91,'description',1,'Show invoices menu'),(59,92,'description',1,'Show order menu'),(59,93,'description',1,'Show payments & refunds menu'),(59,94,'description',1,'Show billing menu'),(59,95,'description',1,'Show mediation menu'),(59,96,'description',1,'Show reports menu'),(59,97,'description',1,'Show products menu'),(59,98,'description',1,'Show plans menu'),(59,99,'description',1,'Show configuration menu'),(59,120,'description',1,'Web Service API access'),(60,1,'description',1,'An internal user with all the permissions'),(60,1,'description',2,'Um utilizador interno com todas as permissões'),(60,1,'title',1,'Internal'),(60,1,'title',2,'Interno'),(60,2,'description',1,'The super user of an entity'),(60,2,'description',2,'O super utilizador de uma entidade'),(60,2,'title',1,'Super user'),(60,2,'title',2,'Super utilizador'),(60,3,'description',1,'A billing clerk'),(60,3,'description',2,'Um operador de facturação'),(60,3,'title',1,'Clerk'),(60,3,'title',2,'Operador'),(60,4,'description',1,'A partner that will bring customers'),(60,4,'description',2,'Um parceiro que vai angariar clientes'),(60,4,'title',1,'Partner'),(60,4,'title',2,'Parceiro'),(60,5,'description',1,'A customer that will query his/her account'),(60,5,'description',2,'Um cliente que vai fazer pesquisas na sua conta'),(60,5,'title',1,'Customer'),(60,5,'title',2,'Cliente'),(60,60,'description',1,'The super user of an entity'),(60,60,'title',1,'Super user'),(60,61,'description',1,'A billing clerk'),(60,61,'title',1,'Clerk'),(60,62,'description',1,'A customer that will query his/her account'),(60,62,'title',1,'Customer'),(64,1,'description',1,'Afghanistan'),(64,1,'description',2,'Afganistão'),(64,2,'description',1,'Albania'),(64,2,'description',2,'Albânia'),(64,3,'description',1,'Algeria'),(64,3,'description',2,'Algéria'),(64,4,'description',1,'American Samoa'),(64,4,'description',2,'Samoa Americana'),(64,5,'description',1,'Andorra'),(64,5,'description',2,'Andorra'),(64,6,'description',1,'Angola'),(64,6,'description',2,'Angola'),(64,7,'description',1,'Anguilla'),(64,7,'description',2,'Anguilha'),(64,8,'description',1,'Antarctica'),(64,8,'description',2,'Antártida'),(64,9,'description',1,'Antigua and Barbuda'),(64,9,'description',2,'Antigua e Barbuda'),(64,10,'description',1,'Argentina'),(64,10,'description',2,'Argentina'),(64,11,'description',1,'Armenia'),(64,11,'description',2,'Arménia'),(64,12,'description',1,'Aruba'),(64,12,'description',2,'Aruba'),(64,13,'description',1,'Australia'),(64,13,'description',2,'Austrália'),(64,14,'description',1,'Austria'),(64,14,'description',2,'Áustria'),(64,15,'description',1,'Azerbaijan'),(64,15,'description',2,'Azerbeijão'),(64,16,'description',1,'Bahamas'),(64,16,'description',2,'Bahamas'),(64,17,'description',1,'Bahrain'),(64,17,'description',2,'Bahrain'),(64,18,'description',1,'Bangladesh'),(64,18,'description',2,'Bangladesh'),(64,19,'description',1,'Barbados'),(64,19,'description',2,'Barbados'),(64,20,'description',1,'Belarus'),(64,20,'description',2,'Belarússia'),(64,21,'description',1,'Belgium'),(64,21,'description',2,'Bélgica'),(64,22,'description',1,'Belize'),(64,22,'description',2,'Belize'),(64,23,'description',1,'Benin'),(64,23,'description',2,'Benin'),(64,24,'description',1,'Bermuda'),(64,24,'description',2,'Bermuda'),(64,25,'description',1,'Bhutan'),(64,25,'description',2,'Butão'),(64,26,'description',1,'Bolivia'),(64,26,'description',2,'Bolívia'),(64,27,'description',1,'Bosnia and Herzegovina'),(64,27,'description',2,'Bosnia e Herzegovina'),(64,28,'description',1,'Botswana'),(64,28,'description',2,'Botswana'),(64,29,'description',1,'Bouvet Island'),(64,29,'description',2,'Ilha Bouvet'),(64,30,'description',1,'Brazil'),(64,30,'description',2,'Brasil'),(64,31,'description',1,'British Indian Ocean Territory'),(64,31,'description',2,'Território Britânico do Oceano Índico'),(64,32,'description',1,'Brunei'),(64,32,'description',2,'Brunei'),(64,33,'description',1,'Bulgaria'),(64,33,'description',2,'Bulgária'),(64,34,'description',1,'Burkina Faso'),(64,34,'description',2,'Burquina Faso'),(64,35,'description',1,'Burundi'),(64,35,'description',2,'Burundi'),(64,36,'description',1,'Cambodia'),(64,36,'description',2,'Cambodia'),(64,37,'description',1,'Cameroon'),(64,37,'description',2,'Camarões'),(64,38,'description',1,'Canada'),(64,38,'description',2,'Canada'),(64,39,'description',1,'Cape Verde'),(64,39,'description',2,'Cabo Verde'),(64,40,'description',1,'Cayman Islands'),(64,40,'description',2,'Ilhas Caimão'),(64,41,'description',1,'Central African Republic'),(64,41,'description',2,'República Centro Africana'),(64,42,'description',1,'Chad'),(64,42,'description',2,'Chade'),(64,43,'description',1,'Chile'),(64,43,'description',2,'Chile'),(64,44,'description',1,'China'),(64,44,'description',2,'China'),(64,45,'description',1,'Christmas Island'),(64,45,'description',2,'Ilha Natal'),(64,46,'description',1,'Cocos - Keeling Islands'),(64,46,'description',2,'Ilha Cocos e Keeling'),(64,47,'description',1,'Colombia'),(64,47,'description',2,'Colômbia'),(64,48,'description',1,'Comoros'),(64,48,'description',2,'Comoros'),(64,49,'description',1,'Congo'),(64,49,'description',2,'Congo'),(64,50,'description',1,'Cook Islands'),(64,50,'description',2,'Ilhas Cook'),(64,51,'description',1,'Costa Rica'),(64,51,'description',2,'Costa Rica'),(64,52,'description',1,'Cote d Ivoire'),(64,52,'description',2,'Costa do Marfim'),(64,53,'description',1,'Croatia'),(64,53,'description',2,'Croácia'),(64,54,'description',1,'Cuba'),(64,54,'description',2,'Cuba'),(64,55,'description',1,'Cyprus'),(64,55,'description',2,'Chipre'),(64,56,'description',1,'Czech Republic'),(64,56,'description',2,'República Checa'),(64,57,'description',1,'Congo - DRC'),(64,57,'description',2,'República Democrática do Congo'),(64,58,'description',1,'Denmark'),(64,58,'description',2,'Dinamarca'),(64,59,'description',1,'Djibouti'),(64,59,'description',2,'Djibouti'),(64,60,'description',1,'Dominica'),(64,60,'description',2,'Dominica'),(64,61,'description',1,'Dominican Republic'),(64,61,'description',2,'República Dominicana'),(64,62,'description',1,'East Timor'),(64,62,'description',2,'Timor Leste'),(64,63,'description',1,'Ecuador'),(64,63,'description',2,'Ecuador'),(64,64,'description',1,'Egypt'),(64,64,'description',2,'Egipto'),(64,65,'description',1,'El Salvador'),(64,65,'description',2,'El Salvador'),(64,66,'description',1,'Equatorial Guinea'),(64,66,'description',2,'Guiné Equatorial'),(64,67,'description',1,'Eritrea'),(64,67,'description',2,'Eritreia'),(64,68,'description',1,'Estonia'),(64,68,'description',2,'Estónia'),(64,69,'description',1,'Ethiopia'),(64,69,'description',2,'Etiopia'),(64,70,'description',1,'Malvinas Islands'),(64,70,'description',2,'Ilhas Malvinas'),(64,71,'description',1,'Faroe Islands'),(64,71,'description',2,'Ilhas Faroé'),(64,72,'description',1,'Fiji Islands'),(64,72,'description',2,'Ilhas Fiji'),(64,73,'description',1,'Finland'),(64,73,'description',2,'Finlândia'),(64,74,'description',1,'France'),(64,74,'description',2,'França'),(64,75,'description',1,'French Guiana'),(64,75,'description',2,'Guiana Francesa'),(64,76,'description',1,'French Polynesia'),(64,76,'description',2,'Polinésia Francesa'),(64,77,'description',1,'French Southern and Antarctic Lands'),(64,77,'description',2,'Terras Antárticas e do Sul Francesas'),(64,78,'description',1,'Gabon'),(64,78,'description',2,'Gabão'),(64,79,'description',1,'Gambia'),(64,79,'description',2,'Gâmbia'),(64,80,'description',1,'Georgia'),(64,80,'description',2,'Georgia'),(64,81,'description',1,'Germany'),(64,81,'description',2,'Alemanha'),(64,82,'description',1,'Ghana'),(64,82,'description',2,'Gana'),(64,83,'description',1,'Gibraltar'),(64,83,'description',2,'Gibraltar'),(64,84,'description',1,'Greece'),(64,84,'description',2,'Grécia'),(64,85,'description',1,'Greenland'),(64,85,'description',2,'Gronelândia'),(64,86,'description',1,'Grenada'),(64,86,'description',2,'Granada'),(64,87,'description',1,'Guadeloupe'),(64,87,'description',2,'Guadalupe'),(64,88,'description',1,'Guam'),(64,88,'description',2,'Guantanamo'),(64,89,'description',1,'Guatemala'),(64,89,'description',2,'Guatemala'),(64,90,'description',1,'Guinea'),(64,90,'description',2,'Guiné'),(64,91,'description',1,'Guinea-Bissau'),(64,91,'description',2,'Guiné-Bissau'),(64,92,'description',1,'Guyana'),(64,92,'description',2,'Guiana'),(64,93,'description',1,'Haiti'),(64,93,'description',2,'Haiti'),(64,94,'description',1,'Heard Island and McDonald Islands'),(64,94,'description',2,'Ilhas Heard e McDonald'),(64,95,'description',1,'Honduras'),(64,95,'description',2,'Honduras'),(64,96,'description',1,'Hong Kong SAR'),(64,96,'description',2,'Hong Kong SAR'),(64,97,'description',1,'Hungary'),(64,97,'description',2,'Hungria'),(64,98,'description',1,'Iceland'),(64,98,'description',2,'Islândia'),(64,99,'description',1,'India'),(64,99,'description',2,'Índia'),(64,100,'description',1,'Indonesia'),(64,100,'description',2,'Indonésia'),(64,101,'description',1,'Iran'),(64,101,'description',2,'Irão'),(64,102,'description',1,'Iraq'),(64,102,'description',2,'Iraque'),(64,103,'description',1,'Ireland'),(64,103,'description',2,'Irlanda'),(64,104,'description',1,'Israel'),(64,104,'description',2,'Israel'),(64,105,'description',1,'Italy'),(64,105,'description',2,'Itália'),(64,106,'description',1,'Jamaica'),(64,106,'description',2,'Jamaica'),(64,107,'description',1,'Japan'),(64,107,'description',2,'Japão'),(64,108,'description',1,'Jordan'),(64,108,'description',2,'Jordânia'),(64,109,'description',1,'Kazakhstan'),(64,109,'description',2,'Kazaquistão'),(64,110,'description',1,'Kenya'),(64,110,'description',2,'Kénia'),(64,111,'description',1,'Kiribati'),(64,111,'description',2,'Kiribati'),(64,112,'description',1,'Korea'),(64,112,'description',2,'Coreia'),(64,113,'description',1,'Kuwait'),(64,113,'description',2,'Kuwait'),(64,114,'description',1,'Kyrgyzstan'),(64,114,'description',2,'Kirgistão'),(64,115,'description',1,'Laos'),(64,115,'description',2,'Laos'),(64,116,'description',1,'Latvia'),(64,116,'description',2,'Latvia'),(64,117,'description',1,'Lebanon'),(64,117,'description',2,'Líbano'),(64,118,'description',1,'Lesotho'),(64,118,'description',2,'Lesoto'),(64,119,'description',1,'Liberia'),(64,119,'description',2,'Libéria'),(64,120,'description',1,'Libya'),(64,120,'description',2,'Líbia'),(64,121,'description',1,'Liechtenstein'),(64,121,'description',2,'Liechtenstein'),(64,122,'description',1,'Lithuania'),(64,122,'description',2,'Lituânia'),(64,123,'description',1,'Luxembourg'),(64,123,'description',2,'Luxemburgo'),(64,124,'description',1,'Macao SAR'),(64,124,'description',2,'Macau SAR'),(64,125,'description',1,'Macedonia, Former Yugoslav Republic of'),(64,125,'description',2,'Macedónia, Antiga República Jugoslava da'),(64,126,'description',1,'Madagascar'),(64,126,'description',2,'Madagáscar'),(64,127,'description',1,'Malawi'),(64,127,'description',2,'Malaui'),(64,128,'description',1,'Malaysia'),(64,128,'description',2,'Malásia'),(64,129,'description',1,'Maldives'),(64,129,'description',2,'Maldivas'),(64,130,'description',1,'Mali'),(64,130,'description',2,'Mali'),(64,131,'description',1,'Malta'),(64,131,'description',2,'Malta'),(64,132,'description',1,'Marshall Islands'),(64,132,'description',2,'Ilhas Marshall'),(64,133,'description',1,'Martinique'),(64,133,'description',2,'Martinica'),(64,134,'description',1,'Mauritania'),(64,134,'description',2,'Mauritânia'),(64,135,'description',1,'Mauritius'),(64,135,'description',2,'Maurícias'),(64,136,'description',1,'Mayotte'),(64,136,'description',2,'Maiote'),(64,137,'description',1,'Mexico'),(64,137,'description',2,'México'),(64,138,'description',1,'Micronesia'),(64,138,'description',2,'Micronésia'),(64,139,'description',1,'Moldova'),(64,139,'description',2,'Moldova'),(64,140,'description',1,'Monaco'),(64,140,'description',2,'Mónaco'),(64,141,'description',1,'Mongolia'),(64,141,'description',2,'Mongólia'),(64,142,'description',1,'Montserrat'),(64,142,'description',2,'Monserrate'),(64,143,'description',1,'Morocco'),(64,143,'description',2,'Marrocos'),(64,144,'description',1,'Mozambique'),(64,144,'description',2,'Moçambique'),(64,145,'description',1,'Myanmar'),(64,145,'description',2,'Mianmar'),(64,146,'description',1,'Namibia'),(64,146,'description',2,'Namíbia'),(64,147,'description',1,'Nauru'),(64,147,'description',2,'Nauru'),(64,148,'description',1,'Nepal'),(64,148,'description',2,'Nepal'),(64,149,'description',1,'Netherlands'),(64,149,'description',2,'Holanda'),(64,150,'description',1,'Netherlands Antilles'),(64,150,'description',2,'Antilhas Holandesas'),(64,151,'description',1,'New Caledonia'),(64,151,'description',2,'Nova Caledónia'),(64,152,'description',1,'New Zealand'),(64,152,'description',2,'Nova Zelândia'),(64,153,'description',1,'Nicaragua'),(64,153,'description',2,'Nicarágua'),(64,154,'description',1,'Niger'),(64,154,'description',2,'Niger'),(64,155,'description',1,'Nigeria'),(64,155,'description',2,'Nigéria'),(64,156,'description',1,'Niue'),(64,156,'description',2,'Niue'),(64,157,'description',1,'Norfolk Island'),(64,157,'description',2,'Ilhas Norfolk'),(64,158,'description',1,'North Korea'),(64,158,'description',2,'Coreia do Norte'),(64,159,'description',1,'Northern Mariana Islands'),(64,159,'description',2,'Ilhas Mariana do Norte'),(64,160,'description',1,'Norway'),(64,160,'description',2,'Noruega'),(64,161,'description',1,'Oman'),(64,161,'description',2,'Oman'),(64,162,'description',1,'Pakistan'),(64,162,'description',2,'Pakistão'),(64,163,'description',1,'Palau'),(64,163,'description',2,'Palau'),(64,164,'description',1,'Panama'),(64,164,'description',2,'Panama'),(64,165,'description',1,'Papua New Guinea'),(64,165,'description',2,'Papua Nova Guiné'),(64,166,'description',1,'Paraguay'),(64,166,'description',2,'Paraguai'),(64,167,'description',1,'Peru'),(64,167,'description',2,'Perú'),(64,168,'description',1,'Philippines'),(64,168,'description',2,'Filipinas'),(64,169,'description',1,'Pitcairn Islands'),(64,169,'description',2,'Ilhas Pitcairn'),(64,170,'description',1,'Poland'),(64,170,'description',2,'Polónia'),(64,171,'description',1,'Portugal'),(64,171,'description',2,'Portugal'),(64,172,'description',1,'Puerto Rico'),(64,172,'description',2,'Porto Rico'),(64,173,'description',1,'Qatar'),(64,173,'description',2,'Qatar'),(64,174,'description',1,'Reunion'),(64,174,'description',2,'Reunião'),(64,175,'description',1,'Romania'),(64,175,'description',2,'Roménia'),(64,176,'description',1,'Russia'),(64,176,'description',2,'Rússia'),(64,177,'description',1,'Rwanda'),(64,177,'description',2,'Rwanda'),(64,178,'description',1,'Samoa'),(64,178,'description',2,'Samoa'),(64,179,'description',1,'San Marino'),(64,179,'description',2,'São Marino'),(64,180,'description',1,'Sao Tome and Principe'),(64,180,'description',2,'São Tomé e Princepe'),(64,181,'description',1,'Saudi Arabia'),(64,181,'description',2,'Arábia Saudita'),(64,182,'description',1,'Senegal'),(64,182,'description',2,'Senegal'),(64,183,'description',1,'Serbia and Montenegro'),(64,183,'description',2,'Sérvia e Montenegro'),(64,184,'description',1,'Seychelles'),(64,184,'description',2,'Seychelles'),(64,185,'description',1,'Sierra Leone'),(64,185,'description',2,'Serra Leoa'),(64,186,'description',1,'Singapore'),(64,186,'description',2,'Singapure'),(64,187,'description',1,'Slovakia'),(64,187,'description',2,'Eslováquia'),(64,188,'description',1,'Slovenia'),(64,188,'description',2,'Eslovénia'),(64,189,'description',1,'Solomon Islands'),(64,189,'description',2,'Ilhas Salomão'),(64,190,'description',1,'Somalia'),(64,190,'description',2,'Somália'),(64,191,'description',1,'South Africa'),(64,191,'description',2,'África do Sul'),(64,192,'description',1,'South Georgia and the South Sandwich Islands'),(64,192,'description',2,'Georgia do Sul e Ilhas Sandwich South'),(64,193,'description',1,'Spain'),(64,193,'description',2,'Espanha'),(64,194,'description',1,'Sri Lanka'),(64,194,'description',2,'Sri Lanka'),(64,195,'description',1,'St. Helena'),(64,195,'description',2,'Sta. Helena'),(64,196,'description',1,'St. Kitts and Nevis'),(64,196,'description',2,'Sta. Kitts e Nevis'),(64,197,'description',1,'St. Lucia'),(64,197,'description',2,'Sta. Lucia'),(64,198,'description',1,'St. Pierre and Miquelon'),(64,198,'description',2,'Sta. Pierre e Miquelon'),(64,199,'description',1,'St. Vincent and the Grenadines'),(64,199,'description',2,'Sto. Vicente e Grenadines'),(64,200,'description',1,'Sudan'),(64,200,'description',2,'Sudão'),(64,201,'description',1,'Suriname'),(64,201,'description',2,'Suriname'),(64,202,'description',1,'Svalbard and Jan Mayen'),(64,202,'description',2,'Svalbard e Jan Mayen'),(64,203,'description',1,'Swaziland'),(64,203,'description',2,'Swazilândia'),(64,204,'description',1,'Sweden'),(64,204,'description',2,'Suécia'),(64,205,'description',1,'Switzerland'),(64,205,'description',2,'Suíça'),(64,206,'description',1,'Syria'),(64,206,'description',2,'Síria'),(64,207,'description',1,'Taiwan'),(64,207,'description',2,'Taiwan'),(64,208,'description',1,'Tajikistan'),(64,208,'description',2,'Tajikistão'),(64,209,'description',1,'Tanzania'),(64,209,'description',2,'Tanzânia'),(64,210,'description',1,'Thailand'),(64,210,'description',2,'Thailândia'),(64,211,'description',1,'Togo'),(64,211,'description',2,'Togo'),(64,212,'description',1,'Tokelau'),(64,212,'description',2,'Tokelau'),(64,213,'description',1,'Tonga'),(64,213,'description',2,'Tonga'),(64,214,'description',1,'Trinidad and Tobago'),(64,214,'description',2,'Trinidade e Tobago'),(64,215,'description',1,'Tunisia'),(64,215,'description',2,'Tunísia'),(64,216,'description',1,'Turkey'),(64,216,'description',2,'Turquia'),(64,217,'description',1,'Turkmenistan'),(64,217,'description',2,'Turkmenistão'),(64,218,'description',1,'Turks and Caicos Islands'),(64,218,'description',2,'Ilhas Turks e Caicos'),(64,219,'description',1,'Tuvalu'),(64,219,'description',2,'Tuvalu'),(64,220,'description',1,'Uganda'),(64,220,'description',2,'Uganda'),(64,221,'description',1,'Ukraine'),(64,221,'description',2,'Ucrânia'),(64,222,'description',1,'United Arab Emirates'),(64,222,'description',2,'Emiados Árabes Unidos'),(64,223,'description',1,'United Kingdom'),(64,223,'description',2,'Reino Unido'),(64,224,'description',1,'United States'),(64,224,'description',2,'Estados Unidos'),(64,225,'description',1,'United States Minor Outlying Islands'),(64,225,'description',2,'Estados Unidos e Ilhas Menores Circundantes'),(64,226,'description',1,'Uruguay'),(64,226,'description',2,'Uruguai'),(64,227,'description',1,'Uzbekistan'),(64,227,'description',2,'Uzbekistão'),(64,228,'description',1,'Vanuatu'),(64,228,'description',2,'Vanuatu'),(64,229,'description',1,'Vatican City'),(64,229,'description',2,'Cidade do Vaticano'),(64,230,'description',1,'Venezuela'),(64,230,'description',2,'Venezuela'),(64,231,'description',1,'Viet Nam'),(64,231,'description',2,'Vietname'),(64,232,'description',1,'Virgin Islands - British'),(64,232,'description',2,'Ilhas Virgens Britânicas'),(64,233,'description',1,'Virgin Islands'),(64,233,'description',2,'Ilhas Virgens'),(64,234,'description',1,'Wallis and Futuna'),(64,234,'description',2,'Wallis and Futuna'),(64,235,'description',1,'Yemen'),(64,235,'description',2,'Yemen'),(64,236,'description',1,'Zambia'),(64,236,'description',2,'Zâmbia'),(64,237,'description',1,'Zimbabwe'),(64,237,'description',2,'Zimbabwe'),(69,100,'welcome_message',1,'<div> <br/> <p style=font-size:19px; font-weight: bold;>Welcome to [Comtalk A/S] Billing!</p> <br/> <p style=font-size:14px; text-align=left; padding-left: 15;>From here, you can review your latest invoice and get it paid instantly. You can also view all your previous invoices and payments, and set up the system for automatic payment with your credit card.</p> <p style=font-size:14px; text-align=left; padding-left: 15;>What would you like to do today? </p> <ul style=font-size:13px; text-align=left; padding-left: 25;> <li >To submit a credit card payment, follow the link on the left bar.</li> <li >To view a list of your invoices, click on the ï¿½Invoicesï¿½ menu option. The first invoice on the list is your latest invoice. Click on it to see its details.</li> <li>To view a list of your payments, click on the ï¿½Paymentsï¿½ menu option. The first payment on the list is your latest payment. Click on it to see its details.</li> <li>To provide a credit card to enable automatic payment, click on the menu option Account, and then on Edit Credit Card.</li> </ul> </div>'),(81,1,'description',1,'Active'),(81,2,'description',1,'Pending Unsubscription'),(81,3,'description',1,'Unsubscribed'),(81,4,'description',1,'Pending Expiration'),(81,5,'description',1,'Expired'),(81,6,'description',1,'Nonsubscriber'),(81,7,'description',1,'Discontinued'),(88,1,'description',1,'Active'),(88,2,'description',1,'Inactive'),(88,3,'description',1,'Pending Active'),(88,4,'description',1,'Pending Inactive'),(88,5,'description',1,'Failed'),(88,6,'description',1,'Unavailable'),(89,1,'description',1,'None'),(89,2,'description',1,'Pre-paid balance'),(89,3,'description',1,'Credit limit'),(90,1,'description',1,'Paid'),(90,2,'description',1,'Unpaid'),(90,3,'description',1,'Carried'),(91,1,'description',1,'Done and billable'),(91,2,'description',1,'Done and not billable'),(91,3,'description',1,'Error detected'),(91,4,'description',1,'Error declared'),(92,1,'description',1,'Running'),(92,2,'description',1,'Finished: successful'),(92,3,'description',1,'Finished: failed'),(99,1,'description',1,'Referral Fee'),(99,2,'description',1,'Payment Processor'),(99,3,'description',1,'IP Address'),(100,1,'description',1,'Total amount invoiced grouped by period.'),(100,2,'description',1,'Detailed balance ageing report. Shows the age of outstanding customer balances.'),(100,3,'description',1,'Number of users subscribed to a specific product.'),(100,4,'description',1,'Total payment amount received grouped by period.'),(100,5,'description',1,'Number of customers created within a period.'),(100,6,'description',1,'Total revenue (sum of received payments) per customer.'),(100,7,'description',1,'Simple accounts receivable report showing current account balances.'),(100,8,'description',1,'General ledger details of all invoiced charges for the given day.'),(100,9,'description',1,'General ledger summary of all invoiced charges for the given day, grouped by item type.'),(101,1,'description',1,'Invoice Reports'),(101,2,'description',1,'Order Reports'),(101,3,'description',1,'Payment Reports'),(101,4,'description',1,'User Reports'),(104,1,'description',1,'Invoices'),(104,2,'description',1,'Orders'),(104,3,'description',1,'Payments'),(104,4,'description',1,'Users');

UNLOCK TABLES;

/*Table structure for table `invoice` */

DROP TABLE IF EXISTS `invoice`;

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `billing_process_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `delegated_invoice_id` int(11) DEFAULT NULL,
  `due_date` datetime NOT NULL,
  `total` decimal(22,10) NOT NULL,
  `payment_attempts` int(11) NOT NULL DEFAULT '0',
  `balance` decimal(22,10) DEFAULT NULL,
  `carried_balance` decimal(22,10) NOT NULL,
  `in_process_payment` smallint(6) NOT NULL DEFAULT '1',
  `is_review` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `paper_invoice_batch_id` int(11) DEFAULT NULL,
  `customer_notes` varchar(1000) DEFAULT NULL,
  `public_number` varchar(40) DEFAULT NULL,
  `last_reminder` datetime DEFAULT NULL,
  `overdue_step` int(11) DEFAULT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_invoice_user_id` (`user_id`,`deleted`),
  KEY `ix_invoice_date` (`create_datetime`),
  KEY `ix_invoice_number` (`user_id`,`public_number`),
  KEY `ix_invoice_due_date` (`user_id`,`due_date`),
  KEY `ix_invoice_ts` (`create_timestamp`,`user_id`),
  KEY `ix_invoice_process` (`billing_process_id`),
  KEY `FK74D6432DBF4F395B` (`currency_id`),
  KEY `FK74D6432D69475521` (`billing_process_id`),
  KEY `FK74D6432D3F97B344` (`paper_invoice_batch_id`),
  KEY `FK74D6432DEF3F796` (`delegated_invoice_id`),
  KEY `FK74D6432D7A85DBFE` (`user_id`),
  KEY `FK74D6432D66B0571F` (`status_id`),
  CONSTRAINT `invoice_FK_5` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK74D6432D3F97B344` FOREIGN KEY (`paper_invoice_batch_id`) REFERENCES `paper_invoice_batch` (`id`),
  CONSTRAINT `FK74D6432D66B0571F` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK74D6432D69475521` FOREIGN KEY (`billing_process_id`) REFERENCES `billing_process` (`id`),
  CONSTRAINT `FK74D6432D7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK74D6432DBF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK74D6432DEF3F796` FOREIGN KEY (`delegated_invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_FK_1` FOREIGN KEY (`billing_process_id`) REFERENCES `billing_process` (`id`),
  CONSTRAINT `invoice_FK_2` FOREIGN KEY (`paper_invoice_batch_id`) REFERENCES `paper_invoice_batch` (`id`),
  CONSTRAINT `invoice_FK_3` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `invoice_FK_4` FOREIGN KEY (`delegated_invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invoice` */

LOCK TABLES `invoice` WRITE;

UNLOCK TABLES;

/*Table structure for table `invoice_delivery_method` */

DROP TABLE IF EXISTS `invoice_delivery_method`;

CREATE TABLE `invoice_delivery_method` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invoice_delivery_method` */

LOCK TABLES `invoice_delivery_method` WRITE;

insert  into `invoice_delivery_method`(`id`) values (1),(2),(3);

UNLOCK TABLES;

/*Table structure for table `invoice_line` */

DROP TABLE IF EXISTS `invoice_line`;

CREATE TABLE `invoice_line` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) NOT NULL,
  `quantity` decimal(22,10) DEFAULT NULL,
  `price` decimal(22,10) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `item_id` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `source_user_id` int(11) DEFAULT NULL,
  `is_percentage` smallint(6) NOT NULL DEFAULT '0',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_invoice_line_invoice_id` (`invoice_id`),
  KEY `FKC7D319C6D720726` (`item_id`),
  KEY `FKC7D319C62CAC4AD6` (`invoice_id`),
  KEY `FKC7D319C69924017B` (`type_id`),
  CONSTRAINT `invoice_line_FK_3` FOREIGN KEY (`type_id`) REFERENCES `invoice_line_type` (`id`),
  CONSTRAINT `FKC7D319C62CAC4AD6` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `FKC7D319C69924017B` FOREIGN KEY (`type_id`) REFERENCES `invoice_line_type` (`id`),
  CONSTRAINT `FKC7D319C6D720726` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `invoice_line_FK_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_line_FK_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invoice_line` */

LOCK TABLES `invoice_line` WRITE;

UNLOCK TABLES;

/*Table structure for table `invoice_line_type` */

DROP TABLE IF EXISTS `invoice_line_type`;

CREATE TABLE `invoice_line_type` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  `order_position` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invoice_line_type` */

LOCK TABLES `invoice_line_type` WRITE;

insert  into `invoice_line_type`(`id`,`description`,`order_position`) values (1,'item recurring',2),(2,'tax',6),(3,'due invoice',1),(4,'interests',4),(5,'sub account',5),(6,'item one-time',3);

UNLOCK TABLES;

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `internal_number` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `percentage` decimal(22,10) DEFAULT NULL,
  `price_manual` smallint(6) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `has_decimals` smallint(6) NOT NULL DEFAULT '0',
  `gl_code` varchar(50) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_item_ent` (`entity_id`,`internal_number`),
  KEY `FK317B13A7AC55E` (`entity_id`),
  CONSTRAINT `item_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK317B13A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item` */

LOCK TABLES `item` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_price` */

DROP TABLE IF EXISTS `item_price`;

CREATE TABLE `item_price` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `price` double NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8B7BB51DBF4F395B` (`currency_id`),
  KEY `FK8B7BB51DD720726` (`item_id`),
  CONSTRAINT `item_price_FK_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `FK8B7BB51DBF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK8B7BB51DD720726` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `item_price_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_price` */

LOCK TABLES `item_price` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_type` */

DROP TABLE IF EXISTS `item_type`;

CREATE TABLE `item_type` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `order_line_type_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8060C0E6A7AC55E` (`entity_id`),
  CONSTRAINT `item_type_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK8060C0E6A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_type` */

LOCK TABLES `item_type` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_type_exclude_map` */

DROP TABLE IF EXISTS `item_type_exclude_map`;

CREATE TABLE `item_type_exclude_map` (
  `item_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  KEY `FKA19C2B9ED720726` (`item_id`),
  KEY `FKA19C2B9EEEC96405` (`type_id`),
  CONSTRAINT `item_type_exclude_map_FK_2` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `FKA19C2B9ED720726` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `FKA19C2B9EEEC96405` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `item_type_exclude_map_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_type_exclude_map` */

LOCK TABLES `item_type_exclude_map` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_type_map` */

DROP TABLE IF EXISTS `item_type_map`;

CREATE TABLE `item_type_map` (
  `item_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  KEY `FKEED6B283D720726` (`item_id`),
  KEY `FKEED6B283EEC96405` (`type_id`),
  CONSTRAINT `item_type_map_FK_2` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `FKEED6B283D720726` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `FKEED6B283EEC96405` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `item_type_map_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_type_map` */

LOCK TABLES `item_type_map` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbilling_seqs` */

DROP TABLE IF EXISTS `jbilling_seqs`;

CREATE TABLE `jbilling_seqs` (
  `name` varchar(50) NOT NULL,
  `next_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbilling_seqs` */

LOCK TABLES `jbilling_seqs` WRITE;

insert  into `jbilling_seqs`(`name`,`next_id`) values ('entity_delivery_method_map',4),('contact_field_type',10),('user_role_map',13),('entity_payment_method_map',26),('currency_entity_map',10),('user_credit_card_map',5),('permission_role_map',1),('permission_user',1),('contact_map',6781),('permission_type',9),('period_unit',5),('invoice_delivery_method',4),('user_status',9),('order_line_type',4),('order_billing_type',3),('order_status',5),('pluggable_task_type_category',22),('pluggable_task_type',91),('invoice_line_type',6),('currency',11),('payment_method',9),('payment_result',5),('event_log_module',10),('event_log_message',17),('preference_type',37),('notification_message_type',20),('role',7),('country',238),('permission',120),('currency_exchange',25),('pluggable_task_parameter',2),('billing_process_configuration',2),('order_period',3),('partner_range',1),('item_price',1),('partner',1),('entity',2),('contact_type',3),('promotion',1),('pluggable_task',3),('ach',1),('payment_info_cheque',1),('partner_payout',1),('process_run_total_pm',1),('payment_authorization',1),('billing_process',1),('process_run',1),('process_run_total',1),('paper_invoice_batch',1),('preference',2),('notification_message',2),('notification_message_section',2),('notification_message_line',2),('ageing_entity_step',2),('item_type',1),('item',1),('event_log',1),('purchase_order',1),('order_line',1),('invoice',1),('invoice_line',1),('order_process',1),('payment',1),('notification_message_arch',1),('notification_message_arch_line',1),('base_user',2),('customer',1),('contact',2),('contact_field',1),('credit_card',1),('language',2),('payment_invoice',1),('subscriber_status',7),('mediation_cfg',1),('mediation_process',1),('blacklist',1),('mediation_record_line',1),('generic_status',26),('order_line_provisioning_status',1),('balance_type',0),('mediation_record',0),('filter',0),('filter_set',0),('recent_item',0),('breadcrumb',3),('shortcut',0),('report',0),('report_type',0),('report_parameter',0);

UNLOCK TABLES;

/*Table structure for table `jbilling_table` */

DROP TABLE IF EXISTS `jbilling_table`;

CREATE TABLE `jbilling_table` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbilling_table` */

LOCK TABLES `jbilling_table` WRITE;

insert  into `jbilling_table`(`id`,`name`) values (3,'language'),(4,'currency'),(5,'entity'),(6,'period_unit'),(7,'invoice_delivery_method'),(8,'entity_delivery_method_map'),(9,'user_status'),(10,'base_user'),(11,'partner'),(12,'customer'),(13,'item_type'),(14,'item'),(15,'item_price'),(17,'order_period'),(18,'order_line_type'),(19,'order_billing_type'),(20,'order_status'),(21,'purchase_order'),(22,'order_line'),(23,'pluggable_task_type_category'),(24,'pluggable_task_type'),(25,'pluggable_task'),(26,'pluggable_task_parameter'),(27,'contact'),(28,'contact_type'),(29,'contact_map'),(30,'invoice_line_type'),(31,'paper_invoice_batch'),(32,'billing_process'),(33,'process_run'),(34,'billing_process_configuration'),(35,'payment_method'),(36,'entity_payment_method_map'),(37,'process_run_total'),(38,'process_run_total_pm'),(39,'invoice'),(40,'invoice_line'),(41,'payment_result'),(42,'payment'),(43,'payment_info_cheque'),(44,'credit_card'),(45,'user_credit_card_map'),(46,'event_log_module'),(47,'event_log_message'),(48,'event_log'),(49,'order_process'),(50,'preference_type'),(51,'preference'),(52,'notification_message_type'),(53,'notification_message'),(54,'notification_message_section'),(55,'notification_message_line'),(56,'notification_message_arch'),(57,'notification_message_arch_line'),(58,'permission_type'),(59,'permission'),(60,'role'),(61,'permission_role_map'),(62,'user_role_map'),(64,'country'),(65,'promotion'),(66,'payment_authorization'),(67,'currency_exchange'),(68,'currency_entity_map'),(69,'ageing_entity_step'),(70,'partner_payout'),(75,'ach'),(76,'contact_field'),(79,'partner_range'),(80,'payment_invoice'),(81,'subscriber_status'),(82,'mediation_cfg'),(83,'mediation_process'),(85,'blacklist'),(86,'mediation_record_line'),(87,'generic_status'),(88,'order_line_provisioning_status'),(89,'balance_type'),(90,'invoice_status'),(91,'mediation_record_status'),(92,'process_run_status'),(99,'contact_field_type'),(100,'report'),(101,'report_type'),(102,'report_parameter'),(104,'notification_category');

UNLOCK TABLES;

/*Table structure for table `language` */

DROP TABLE IF EXISTS `language`;

CREATE TABLE `language` (
  `id` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `language` */

LOCK TABLES `language` WRITE;

insert  into `language`(`id`,`code`,`description`) values (1,'en','English'),(2,'pt','Português');

UNLOCK TABLES;

/*Table structure for table `mediation_cfg` */

DROP TABLE IF EXISTS `mediation_cfg`;

CREATE TABLE `mediation_cfg` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(50) NOT NULL,
  `order_value` int(11) NOT NULL,
  `pluggable_task_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA85EA49D9C3403FD` (`pluggable_task_id`),
  CONSTRAINT `mediation_cfg_FK_1` FOREIGN KEY (`pluggable_task_id`) REFERENCES `pluggable_task` (`id`),
  CONSTRAINT `FKA85EA49D9C3403FD` FOREIGN KEY (`pluggable_task_id`) REFERENCES `pluggable_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mediation_cfg` */

LOCK TABLES `mediation_cfg` WRITE;

UNLOCK TABLES;

/*Table structure for table `mediation_order_map` */

DROP TABLE IF EXISTS `mediation_order_map`;

CREATE TABLE `mediation_order_map` (
  `mediation_process_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  KEY `FK3EE35A64423657EB` (`mediation_process_id`),
  KEY `mediation_order_map_FK_2` (`order_id`),
  CONSTRAINT `mediation_order_map_FK_2` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK3EE35A64423657EB` FOREIGN KEY (`mediation_process_id`) REFERENCES `mediation_process` (`id`),
  CONSTRAINT `mediation_order_map_FK_1` FOREIGN KEY (`mediation_process_id`) REFERENCES `mediation_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mediation_order_map` */

LOCK TABLES `mediation_order_map` WRITE;

UNLOCK TABLES;

/*Table structure for table `mediation_process` */

DROP TABLE IF EXISTS `mediation_process`;

CREATE TABLE `mediation_process` (
  `id` int(11) NOT NULL,
  `configuration_id` int(11) NOT NULL,
  `start_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `orders_affected` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1DDB7E28F4904564` (`configuration_id`),
  CONSTRAINT `mediation_process_FK_1` FOREIGN KEY (`configuration_id`) REFERENCES `mediation_cfg` (`id`),
  CONSTRAINT `FK1DDB7E28F4904564` FOREIGN KEY (`configuration_id`) REFERENCES `mediation_cfg` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mediation_process` */

LOCK TABLES `mediation_process` WRITE;

UNLOCK TABLES;

/*Table structure for table `mediation_record` */

DROP TABLE IF EXISTS `mediation_record`;

CREATE TABLE `mediation_record` (
  `id` int(11) NOT NULL,
  `id_key` varchar(100) NOT NULL,
  `start_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mediation_process_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mediation_record_i` (`id`,`status_id`),
  KEY `FK7740B178423657EB` (`mediation_process_id`),
  KEY `FK7740B1785B796CAE` (`status_id`),
  CONSTRAINT `mediation_record_FK_2` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK7740B178423657EB` FOREIGN KEY (`mediation_process_id`) REFERENCES `mediation_process` (`id`),
  CONSTRAINT `FK7740B1785B796CAE` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `mediation_record_FK_1` FOREIGN KEY (`mediation_process_id`) REFERENCES `mediation_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mediation_record` */

LOCK TABLES `mediation_record` WRITE;

UNLOCK TABLES;

/*Table structure for table `mediation_record_line` */

DROP TABLE IF EXISTS `mediation_record_line`;

CREATE TABLE `mediation_record_line` (
  `id` int(11) NOT NULL,
  `mediation_record_id` int(11) NOT NULL,
  `order_line_id` int(11) NOT NULL,
  `event_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` decimal(22,10) NOT NULL,
  `quantity` decimal(22,10) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_mrl_order_line` (`order_line_id`),
  KEY `FKECB8E25BFC95617A` (`mediation_record_id`),
  KEY `FKECB8E25B88CDB5CA` (`order_line_id`),
  CONSTRAINT `mediation_record_line_FK_2` FOREIGN KEY (`order_line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `FKECB8E25B88CDB5CA` FOREIGN KEY (`order_line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `FKECB8E25BFC95617A` FOREIGN KEY (`mediation_record_id`) REFERENCES `mediation_record` (`id`),
  CONSTRAINT `mediation_record_line_FK_1` FOREIGN KEY (`mediation_record_id`) REFERENCES `mediation_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mediation_record_line` */

LOCK TABLES `mediation_record_line` WRITE;

UNLOCK TABLES;

/*Table structure for table `notification_category` */

DROP TABLE IF EXISTS `notification_category`;

CREATE TABLE `notification_category` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_category` */

LOCK TABLES `notification_category` WRITE;

insert  into `notification_category`(`id`) values (1),(2),(3),(4);

UNLOCK TABLES;

/*Table structure for table `notification_message` */

DROP TABLE IF EXISTS `notification_message`;

CREATE TABLE `notification_message` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `entity_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `use_flag` smallint(6) NOT NULL DEFAULT '1',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK44BF14B3A7AC55E` (`entity_id`),
  KEY `FK44BF14B36CE671AE` (`type_id`),
  KEY `FK44BF14B3ED34C00D` (`language_id`),
  CONSTRAINT `notification_message_FK_3` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK44BF14B36CE671AE` FOREIGN KEY (`type_id`) REFERENCES `notification_message_type` (`id`),
  CONSTRAINT `FK44BF14B3A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK44BF14B3ED34C00D` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `notification_message_FK_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `notification_message_FK_2` FOREIGN KEY (`type_id`) REFERENCES `notification_message_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_message` */

LOCK TABLES `notification_message` WRITE;

insert  into `notification_message`(`id`,`type_id`,`entity_id`,`language_id`,`use_flag`,`OPTLOCK`) values (100,1,11,1,1,0),(101,2,11,1,1,0),(102,3,11,1,1,0),(103,13,11,1,1,0),(104,16,11,1,1,0),(105,17,11,1,1,0),(106,18,11,1,1,0),(107,19,11,1,1,0);

UNLOCK TABLES;

/*Table structure for table `notification_message_arch` */

DROP TABLE IF EXISTS `notification_message_arch`;

CREATE TABLE `notification_message_arch` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `result_message` varchar(200) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32696C627A85DBFE` (`user_id`),
  CONSTRAINT `FK32696C627A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_message_arch` */

LOCK TABLES `notification_message_arch` WRITE;

UNLOCK TABLES;

/*Table structure for table `notification_message_arch_line` */

DROP TABLE IF EXISTS `notification_message_arch_line`;

CREATE TABLE `notification_message_arch_line` (
  `id` int(11) NOT NULL,
  `message_archive_id` int(11) DEFAULT NULL,
  `section` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDF4269B1ACB507C2` (`message_archive_id`),
  CONSTRAINT `notif_mess_arch_line_FK_1` FOREIGN KEY (`message_archive_id`) REFERENCES `notification_message_arch` (`id`),
  CONSTRAINT `FKDF4269B1ACB507C2` FOREIGN KEY (`message_archive_id`) REFERENCES `notification_message_arch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_message_arch_line` */

LOCK TABLES `notification_message_arch_line` WRITE;

UNLOCK TABLES;

/*Table structure for table `notification_message_line` */

DROP TABLE IF EXISTS `notification_message_line`;

CREATE TABLE `notification_message_line` (
  `id` int(11) NOT NULL,
  `message_section_id` int(11) DEFAULT NULL,
  `content` varchar(1000) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK326E4C00C6E7F6DE` (`message_section_id`),
  CONSTRAINT `notification_message_line_FK_1` FOREIGN KEY (`message_section_id`) REFERENCES `notification_message_section` (`id`),
  CONSTRAINT `FK326E4C00C6E7F6DE` FOREIGN KEY (`message_section_id`) REFERENCES `notification_message_section` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_message_line` */

LOCK TABLES `notification_message_line` WRITE;

insert  into `notification_message_line`(`id`,`message_section_id`,`content`,`OPTLOCK`) values (100,NULL,'Dear $first_name $last_name,\n\n This is to notify you that your latest invoice (number $number) is now available. The total amount due is: $total. You can view it by login in to:\n\n\" + Util.getSysProp(\"url\") + \"/billing/user/login.jsp?entityId=$company_id\n\nFor security reasons, your statement is password protected.\nTo login in, you will need your user name: $username and your account password: $password\n \n After logging in, please click on the menu option  ï¿½Listï¿½, to see all your invoices.  You can also see your payment history, your current purchase orders, as well as update your payment information and submit online payments.\n\n\nThank you for choosing $company_name, we appreciate your business,\n\nBilling Department\n$company_name',0),(101,101,'Billing Statement from $company_name',0),(102,102,'You account is now up to date',0),(103,NULL,'Dear $first_name $last_name,\n\n  This email is to notify you that we have received your latest payment and your account no longer has an overdue balance.\n\n  Thank you for keeping your account up to date,\n\n\nBilling Department\n$company_name',0),(104,104,'Overdue Balance',0),(105,NULL,'Dear $first_name $last_name,\n\nOur records show that you have an overdue balance on your account. Please submit a payment as soon as possible.\n\nBest regards,\n\nBilling Department\n$company_name',0),(106,NULL,'Dear $first_name $last_name,\n\nYour service with us will expire on $period_end. Please make sure to contact customer service for a renewal.\n\nRegards,\n\nBilling Department\n$company_name',0),(107,107,'Your service from $company_name is about to expire',0),(108,108,'Thank you for your payment',0),(109,NULL,'Dear $first_name $last_name\n\n   We have received your payment made with $method for a total of $total.\n\n   Thank you, we appreciate your business,\n\nBilling Department\n$company_name',0),(110,110,'Payment failed',0),(111,NULL,'Dear $first_name $last_name\n\n   A payment with $method was attempted for a total of $total, but it has been rejected by the payment processor.\nYou can update your payment information and submit an online payment by login into :\n\" + Util.getSysProp(\"url\") + \"/billing/user/login.jsp?entityId=$company_id\n\nFor security reasons, your statement is password protected.\nTo login in, you will need your user name: $username and your account password: $password\n\nThank you,\n\nBilling Department\n$company_name',0),(112,NULL,'Dear $first_name $last_name\n\n   This is a reminder that the invoice number $number remains unpaid. It was sent to you on $date, and its total is $total. Although you still have $days days to pay it (its due date is $dueDate), we would greatly appreciate if you can pay it at your earliest convenience.\n\nYours truly,\n\nBilling Department\n$company_name',0),(113,113,'Invoice remainder',0),(114,NULL,'Dear $first_name $last_name,\n\nWe want to remind you that the credit card that we have in our records for your account is about to expire. Its expiration date is $expiry_date.\n\nUpdating your credit card is easy. Just login into \" + Util.getSysProp(\"url\") + \"/billing/user/login.jsp?entityId=$company_id. using your user name: $username and password: $password. After logging in, click on \'Account\' and then \'Edit Credit Card\'. \nThank you for keeping your account up to date.\n\nBilling Department\n$company_name',0),(115,115,'It is time to update your credit card',0);

UNLOCK TABLES;

/*Table structure for table `notification_message_section` */

DROP TABLE IF EXISTS `notification_message_section`;

CREATE TABLE `notification_message_section` (
  `id` int(11) NOT NULL,
  `message_id` int(11) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1C43D7599B9937DB` (`message_id`),
  CONSTRAINT `notification_message_section_FK_1` FOREIGN KEY (`message_id`) REFERENCES `notification_message` (`id`),
  CONSTRAINT `FK1C43D7599B9937DB` FOREIGN KEY (`message_id`) REFERENCES `notification_message` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_message_section` */

LOCK TABLES `notification_message_section` WRITE;

insert  into `notification_message_section`(`id`,`message_id`,`section`,`OPTLOCK`) values (100,100,2,0),(101,100,1,0),(102,101,1,0),(103,101,2,0),(104,102,1,0),(105,102,2,0),(106,103,2,0),(107,103,1,0),(108,104,1,0),(109,104,2,0),(110,105,1,0),(111,105,2,0),(112,106,2,0),(113,106,1,0),(114,107,2,0),(115,107,1,0);

UNLOCK TABLES;

/*Table structure for table `notification_message_type` */

DROP TABLE IF EXISTS `notification_message_type`;

CREATE TABLE `notification_message_type` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32722B461DA74156` (`category_id`),
  CONSTRAINT `notification_message_type_FK_1` FOREIGN KEY (`category_id`) REFERENCES `notification_category` (`id`),
  CONSTRAINT `FK32722B461DA74156` FOREIGN KEY (`category_id`) REFERENCES `notification_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification_message_type` */

LOCK TABLES `notification_message_type` WRITE;

insert  into `notification_message_type`(`id`,`category_id`,`OPTLOCK`) values (1,1,1),(2,4,1),(3,4,1),(4,4,1),(5,4,1),(6,4,1),(7,4,1),(8,4,1),(9,4,1),(10,3,1),(11,3,1),(12,1,1),(13,2,1),(14,2,1),(15,2,1),(16,3,1),(17,3,1),(18,1,1),(19,4,1),(20,4,1);

UNLOCK TABLES;

/*Table structure for table `order_billing_type` */

DROP TABLE IF EXISTS `order_billing_type`;

CREATE TABLE `order_billing_type` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_billing_type` */

LOCK TABLES `order_billing_type` WRITE;

insert  into `order_billing_type`(`id`) values (1),(2);

UNLOCK TABLES;

/*Table structure for table `order_line` */

DROP TABLE IF EXISTS `order_line`;

CREATE TABLE `order_line` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) NOT NULL,
  `quantity` decimal(22,10) DEFAULT NULL,
  `price` decimal(22,10) DEFAULT NULL,
  `item_price` smallint(6) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `use_item` bit(1) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `provisioning_status` int(11) DEFAULT NULL,
  `provisioning_request_id` varchar(50) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_line_order_id` (`order_id`),
  KEY `ix_order_line_item_id` (`item_id`),
  KEY `FK2D124245D720726` (`item_id`),
  KEY `FK2D12424579CB29B5` (`order_id`),
  KEY `FK2D1242453EC5915D` (`provisioning_status`),
  KEY `FK2D124245F6A9041B` (`type_id`),
  CONSTRAINT `order_line_FK_3` FOREIGN KEY (`type_id`) REFERENCES `order_line_type` (`id`),
  CONSTRAINT `FK2D1242453EC5915D` FOREIGN KEY (`provisioning_status`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK2D12424579CB29B5` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK2D124245D720726` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `FK2D124245F6A9041B` FOREIGN KEY (`type_id`) REFERENCES `order_line_type` (`id`),
  CONSTRAINT `order_line_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `order_line_FK_2` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_line` */

LOCK TABLES `order_line` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_line_type` */

DROP TABLE IF EXISTS `order_line_type`;

CREATE TABLE `order_line_type` (
  `id` int(11) NOT NULL,
  `editable` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_line_type` */

LOCK TABLES `order_line_type` WRITE;

insert  into `order_line_type`(`id`,`editable`) values (1,1),(2,0),(3,0);

UNLOCK TABLES;

/*Table structure for table `order_period` */

DROP TABLE IF EXISTS `order_period`;

CREATE TABLE `order_period` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3827B7D2A7AC55E` (`entity_id`),
  KEY `FK3827B7D23581F017` (`unit_id`),
  CONSTRAINT `order_period_FK_2` FOREIGN KEY (`unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `FK3827B7D23581F017` FOREIGN KEY (`unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `FK3827B7D2A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `order_period_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_period` */

LOCK TABLES `order_period` WRITE;

insert  into `order_period`(`id`,`entity_id`,`value`,`unit_id`,`OPTLOCK`) values (1,NULL,NULL,NULL,1),(200,11,1,1,0);

UNLOCK TABLES;

/*Table structure for table `order_process` */

DROP TABLE IF EXISTS `order_process`;

CREATE TABLE `order_process` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `billing_process_id` int(11) DEFAULT NULL,
  `periods_included` int(11) DEFAULT NULL,
  `period_start` datetime DEFAULT NULL,
  `period_end` datetime DEFAULT NULL,
  `is_review` int(11) NOT NULL,
  `origin` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_uq_order_process_or_in` (`order_id`,`invoice_id`),
  KEY `ix_uq_order_process_or_bp` (`order_id`,`billing_process_id`),
  KEY `ix_order_process_in` (`invoice_id`),
  KEY `FKE2D11E7E2CAC4AD6` (`invoice_id`),
  KEY `FKE2D11E7E69475521` (`billing_process_id`),
  KEY `FKE2D11E7E79CB29B5` (`order_id`),
  CONSTRAINT `order_process_FK_1` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FKE2D11E7E2CAC4AD6` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `FKE2D11E7E69475521` FOREIGN KEY (`billing_process_id`) REFERENCES `billing_process` (`id`),
  CONSTRAINT `FKE2D11E7E79CB29B5` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_process` */

LOCK TABLES `order_process` WRITE;

UNLOCK TABLES;

/*Table structure for table `paper_invoice_batch` */

DROP TABLE IF EXISTS `paper_invoice_batch`;

CREATE TABLE `paper_invoice_batch` (
  `id` int(11) NOT NULL,
  `total_invoices` int(11) NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `is_self_managed` smallint(6) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `paper_invoice_batch` */

LOCK TABLES `paper_invoice_batch` WRITE;

UNLOCK TABLES;

/*Table structure for table `partner` */

DROP TABLE IF EXISTS `partner`;

CREATE TABLE `partner` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `balance` decimal(22,10) NOT NULL,
  `total_payments` decimal(22,10) NOT NULL,
  `total_refunds` decimal(22,10) NOT NULL,
  `total_payouts` decimal(22,10) NOT NULL,
  `percentage_rate` decimal(22,10) DEFAULT NULL,
  `referral_fee` decimal(22,10) DEFAULT NULL,
  `fee_currency_id` int(11) DEFAULT NULL,
  `one_time` smallint(6) NOT NULL,
  `period_unit_id` int(11) NOT NULL,
  `period_value` int(11) NOT NULL,
  `next_payout_date` datetime NOT NULL,
  `due_payout` decimal(22,10) DEFAULT NULL,
  `automatic_process` smallint(6) NOT NULL,
  `related_clerk` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_i_3` (`user_id`),
  KEY `FKD0BCDCC89F939930` (`related_clerk`),
  KEY `FKD0BCDCC87A85DBFE` (`user_id`),
  KEY `FKD0BCDCC8247BB99` (`period_unit_id`),
  KEY `FKD0BCDCC89DDA0A22` (`fee_currency_id`),
  CONSTRAINT `partner_FK_4` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FKD0BCDCC8247BB99` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `FKD0BCDCC87A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FKD0BCDCC89DDA0A22` FOREIGN KEY (`fee_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FKD0BCDCC89F939930` FOREIGN KEY (`related_clerk`) REFERENCES `base_user` (`id`),
  CONSTRAINT `partner_FK_1` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `partner_FK_2` FOREIGN KEY (`fee_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `partner_FK_3` FOREIGN KEY (`related_clerk`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `partner` */

LOCK TABLES `partner` WRITE;

UNLOCK TABLES;

/*Table structure for table `partner_payout` */

DROP TABLE IF EXISTS `partner_payout`;

CREATE TABLE `partner_payout` (
  `id` int(11) NOT NULL,
  `starting_date` datetime NOT NULL,
  `ending_date` datetime NOT NULL,
  `payments_amount` decimal(22,10) NOT NULL,
  `refunds_amount` decimal(22,10) NOT NULL,
  `balance_left` decimal(22,10) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_payout_i_2` (`partner_id`),
  KEY `FK345D0CFD3052B6FD` (`payment_id`),
  KEY `FK345D0CFDBAB9E7B` (`partner_id`),
  CONSTRAINT `partner_payout_FK_1` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`),
  CONSTRAINT `FK345D0CFD3052B6FD` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK345D0CFDBAB9E7B` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `partner_payout` */

LOCK TABLES `partner_payout` WRITE;

UNLOCK TABLES;

/*Table structure for table `partner_range` */

DROP TABLE IF EXISTS `partner_range`;

CREATE TABLE `partner_range` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `percentage_rate` decimal(22,10) DEFAULT NULL,
  `referral_fee` decimal(22,10) DEFAULT NULL,
  `range_from` int(11) NOT NULL,
  `range_to` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_range_p` (`partner_id`),
  KEY `FK2B16C306BAB9E7B` (`partner_id`),
  CONSTRAINT `FK2B16C306BAB9E7B` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `partner_range` */

LOCK TABLES `partner_range` WRITE;

UNLOCK TABLES;

/*Table structure for table `payment` */

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `result_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_date` datetime DEFAULT NULL,
  `method_id` int(11) NOT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `is_refund` smallint(6) NOT NULL DEFAULT '0',
  `is_preauth` smallint(6) NOT NULL DEFAULT '0',
  `payment_id` int(11) DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `payout_id` int(11) DEFAULT NULL,
  `ach_id` int(11) DEFAULT NULL,
  `balance` decimal(22,10) DEFAULT NULL,
  `payment_period` int(11) DEFAULT NULL,
  `payment_notes` varchar(500) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_i_2` (`user_id`,`create_datetime`),
  KEY `payment_i_3` (`user_id`,`balance`),
  KEY `FKD11C3206BF4F395B` (`currency_id`),
  KEY `FKD11C32063052B6FD` (`payment_id`),
  KEY `FKD11C3206DEF90FB2` (`ach_id`),
  KEY `FKD11C32067A85DBFE` (`user_id`),
  KEY `FKD11C32065C0B5E21` (`method_id`),
  KEY `FKD11C3206E9033CA9` (`result_id`),
  KEY `FKD11C32062E23C475` (`credit_card_id`),
  CONSTRAINT `payment_FK_6` FOREIGN KEY (`method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FKD11C32062E23C475` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`id`),
  CONSTRAINT `FKD11C32063052B6FD` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FKD11C32065C0B5E21` FOREIGN KEY (`method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FKD11C32067A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FKD11C3206BF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FKD11C3206DEF90FB2` FOREIGN KEY (`ach_id`) REFERENCES `ach` (`id`),
  CONSTRAINT `FKD11C3206E9033CA9` FOREIGN KEY (`result_id`) REFERENCES `payment_result` (`id`),
  CONSTRAINT `payment_FK_1` FOREIGN KEY (`ach_id`) REFERENCES `ach` (`id`),
  CONSTRAINT `payment_FK_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `payment_FK_3` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_FK_4` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`id`),
  CONSTRAINT `payment_FK_5` FOREIGN KEY (`result_id`) REFERENCES `payment_result` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment` */

LOCK TABLES `payment` WRITE;

UNLOCK TABLES;

/*Table structure for table `payment_authorization` */

DROP TABLE IF EXISTS `payment_authorization`;

CREATE TABLE `payment_authorization` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `processor` varchar(40) NOT NULL,
  `code1` varchar(40) NOT NULL,
  `code2` varchar(40) DEFAULT NULL,
  `code3` varchar(40) DEFAULT NULL,
  `approval_code` varchar(20) DEFAULT NULL,
  `avs` varchar(20) DEFAULT NULL,
  `transaction_id` varchar(40) DEFAULT NULL,
  `md5` varchar(100) DEFAULT NULL,
  `card_code` varchar(100) DEFAULT NULL,
  `create_datetime` datetime NOT NULL,
  `response_message` varchar(200) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `create_datetime` (`create_datetime`),
  KEY `transaction_id` (`transaction_id`),
  KEY `ix_pa_payment` (`payment_id`),
  KEY `FK24B8E2003052B6FD` (`payment_id`),
  CONSTRAINT `payment_authorization_FK_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK24B8E2003052B6FD` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment_authorization` */

LOCK TABLES `payment_authorization` WRITE;

UNLOCK TABLES;

/*Table structure for table `payment_info_cheque` */

DROP TABLE IF EXISTS `payment_info_cheque`;

CREATE TABLE `payment_info_cheque` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `cheque_number` varchar(50) DEFAULT NULL,
  `cheque_date` datetime DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK87EB42193052B6FD` (`payment_id`),
  CONSTRAINT `payment_info_cheque_FK_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK87EB42193052B6FD` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment_info_cheque` */

LOCK TABLES `payment_info_cheque` WRITE;

UNLOCK TABLES;

/*Table structure for table `payment_invoice` */

DROP TABLE IF EXISTS `payment_invoice`;

CREATE TABLE `payment_invoice` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_uq_payment_inv_map_pa_in` (`payment_id`,`invoice_id`),
  KEY `FKCDCAB5F43052B6FD` (`payment_id`),
  KEY `FKCDCAB5F42CAC4AD6` (`invoice_id`),
  CONSTRAINT `payment_invoice_FK_2` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FKCDCAB5F42CAC4AD6` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `FKCDCAB5F43052B6FD` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_invoice_FK_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment_invoice` */

LOCK TABLES `payment_invoice` WRITE;

UNLOCK TABLES;

/*Table structure for table `payment_method` */

DROP TABLE IF EXISTS `payment_method`;

CREATE TABLE `payment_method` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment_method` */

LOCK TABLES `payment_method` WRITE;

insert  into `payment_method`(`id`) values (1),(2),(3),(4),(5),(6),(7),(8),(9);

UNLOCK TABLES;

/*Table structure for table `payment_result` */

DROP TABLE IF EXISTS `payment_result`;

CREATE TABLE `payment_result` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment_result` */

LOCK TABLES `payment_result` WRITE;

insert  into `payment_result`(`id`) values (1),(2),(3),(4);

UNLOCK TABLES;

/*Table structure for table `period_unit` */

DROP TABLE IF EXISTS `period_unit`;

CREATE TABLE `period_unit` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `period_unit` */

LOCK TABLES `period_unit` WRITE;

insert  into `period_unit`(`id`) values (1),(2),(3),(4);

UNLOCK TABLES;

/*Table structure for table `permission` */

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `foreign_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE125C5CFAA95107` (`type_id`),
  CONSTRAINT `permission_FK_1` FOREIGN KEY (`type_id`) REFERENCES `permission_type` (`id`),
  CONSTRAINT `FKE125C5CFAA95107` FOREIGN KEY (`type_id`) REFERENCES `permission_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `permission` */

LOCK TABLES `permission` WRITE;

insert  into `permission`(`id`,`type_id`,`foreign_id`) values (10,1,NULL),(11,1,NULL),(12,1,NULL),(13,1,NULL),(14,1,NULL),(15,1,NULL),(16,1,NULL),(20,2,NULL),(21,2,NULL),(22,2,NULL),(23,2,NULL),(24,2,NULL),(25,2,NULL),(26,2,NULL),(27,2,NULL),(28,2,NULL),(30,3,NULL),(31,3,NULL),(32,3,NULL),(33,3,NULL),(34,3,NULL),(35,3,NULL),(36,3,NULL),(40,4,NULL),(41,4,NULL),(42,4,NULL),(43,4,NULL),(44,4,NULL),(50,5,NULL),(51,5,NULL),(52,5,NULL),(60,6,NULL),(61,6,NULL),(62,6,NULL),(63,6,NULL),(70,7,NULL),(71,7,NULL),(72,7,NULL),(73,7,NULL),(74,7,NULL),(80,8,NULL),(90,9,NULL),(91,9,NULL),(92,9,NULL),(93,9,NULL),(94,9,NULL),(95,9,NULL),(96,9,NULL),(97,9,NULL),(98,9,NULL),(99,9,NULL),(120,10,NULL);

UNLOCK TABLES;

/*Table structure for table `permission_role_map` */

DROP TABLE IF EXISTS `permission_role_map`;

CREATE TABLE `permission_role_map` (
  `permission_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `permission_role_map_i_2` (`permission_id`,`role_id`),
  KEY `FK9970AE83B87C819E` (`role_id`),
  KEY `FK9970AE83D949B0EC` (`permission_id`),
  CONSTRAINT `permission_role_map_FK_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `FK9970AE83B87C819E` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FK9970AE83D949B0EC` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `permission_role_map_FK_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `permission_role_map` */

LOCK TABLES `permission_role_map` WRITE;

insert  into `permission_role_map`(`permission_id`,`role_id`) values (10,60),(10,61),(11,60),(11,61),(12,60),(12,61),(13,60),(13,61),(14,60),(14,61),(15,60),(15,61),(16,60),(20,60),(20,61),(21,60),(21,61),(22,60),(22,61),(23,60),(23,61),(24,60),(24,61),(24,62),(25,60),(26,60),(27,60),(28,60),(28,61),(30,60),(30,61),(30,62),(31,60),(31,61),(32,60),(32,61),(33,60),(33,61),(34,60),(34,61),(34,62),(35,60),(36,60),(36,61),(40,60),(40,61),(41,60),(41,61),(42,60),(42,61),(43,60),(43,61),(44,60),(50,60),(50,61),(51,60),(51,61),(52,60),(52,61),(60,60),(60,61),(61,60),(61,61),(62,60),(62,61),(63,60),(63,61),(70,60),(70,61),(71,60),(71,61),(72,60),(72,61),(72,62),(73,60),(74,60),(74,61),(80,60),(90,60),(90,61),(91,60),(91,61),(91,62),(92,60),(92,61),(92,62),(93,60),(93,61),(93,62),(94,60),(94,61),(95,60),(95,61),(96,60),(96,61),(97,60),(97,61),(98,60),(98,61),(99,60),(120,60);

UNLOCK TABLES;

/*Table structure for table `permission_type` */

DROP TABLE IF EXISTS `permission_type`;

CREATE TABLE `permission_type` (
  `id` int(11) NOT NULL,
  `description` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `permission_type` */

LOCK TABLES `permission_type` WRITE;

insert  into `permission_type`(`id`,`description`) values (1,'Customer'),(2,'Order'),(3,'Payment'),(4,'Product'),(5,'Product Category'),(6,'Plan'),(7,'Invoice'),(8,'Billing'),(9,'Menu'),(10,'API');

UNLOCK TABLES;

/*Table structure for table `permission_user` */

DROP TABLE IF EXISTS `permission_user`;

CREATE TABLE `permission_user` (
  `permission_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_grant` smallint(6) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_user_map_i_2` (`permission_id`,`user_id`),
  KEY `FK9F5A283BD949B0EC` (`permission_id`),
  KEY `FK9F5A283B7A85DBFE` (`user_id`),
  CONSTRAINT `permission_user_FK_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `FK9F5A283B7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK9F5A283BD949B0EC` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `permission_user_FK_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `permission_user` */

LOCK TABLES `permission_user` WRITE;

UNLOCK TABLES;

/*Table structure for table `pluggable_task` */

DROP TABLE IF EXISTS `pluggable_task`;

CREATE TABLE `pluggable_task` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `processing_order` int(11) NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1B1C98D1AE198CDA` (`type_id`),
  KEY `pluggable_task_FK_2` (`entity_id`),
  CONSTRAINT `pluggable_task_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `FK1B1C98D1AE198CDA` FOREIGN KEY (`type_id`) REFERENCES `pluggable_task_type` (`id`),
  CONSTRAINT `pluggable_task_FK_1` FOREIGN KEY (`type_id`) REFERENCES `pluggable_task_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pluggable_task` */

LOCK TABLES `pluggable_task` WRITE;

insert  into `pluggable_task`(`id`,`entity_id`,`type_id`,`processing_order`,`notes`,`OPTLOCK`) values (10,11,21,1,NULL,0),(11,11,9,1,NULL,0),(12,11,12,2,NULL,0),(13,11,1,1,NULL,0),(14,11,3,1,NULL,0),(15,11,4,2,NULL,0),(16,11,5,1,NULL,0),(17,11,6,1,NULL,0),(18,11,7,1,NULL,0),(19,11,10,1,NULL,0),(20,11,25,1,NULL,0),(21,11,28,1,NULL,0),(22,11,33,1,NULL,0),(23,11,54,1,NULL,0),(24,11,61,1,NULL,0),(25,11,82,1,NULL,0),(26,11,87,1,NULL,0),(27,11,88,2,NULL,0);

UNLOCK TABLES;

/*Table structure for table `pluggable_task_parameter` */

DROP TABLE IF EXISTS `pluggable_task_parameter`;

CREATE TABLE `pluggable_task_parameter` (
  `id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `int_value` int(11) DEFAULT NULL,
  `str_value` varchar(500) DEFAULT NULL,
  `float_value` decimal(22,10) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5CB435BB3BB6BAC9` (`task_id`),
  CONSTRAINT `pluggable_task_parameter_FK_1` FOREIGN KEY (`task_id`) REFERENCES `pluggable_task` (`id`),
  CONSTRAINT `FK5CB435BB3BB6BAC9` FOREIGN KEY (`task_id`) REFERENCES `pluggable_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pluggable_task_parameter` */

LOCK TABLES `pluggable_task_parameter` WRITE;

insert  into `pluggable_task_parameter`(`id`,`task_id`,`name`,`int_value`,`str_value`,`float_value`,`OPTLOCK`) values (100,10,'all',NULL,'yes',NULL,0),(101,11,'smtp_server',NULL,'localhost',NULL,0),(102,11,'port',NULL,'25',NULL,0),(103,11,'ssl_auth',NULL,'false',NULL,0),(104,11,'tls',NULL,'false',NULL,0),(105,11,'username',NULL,'username',NULL,0),(106,11,'password',NULL,'password',NULL,0),(107,12,'design',NULL,'simple_invoice_b2b',NULL,0);

UNLOCK TABLES;

/*Table structure for table `pluggable_task_type` */

DROP TABLE IF EXISTS `pluggable_task_type`;

CREATE TABLE `pluggable_task_type` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `class_name` varchar(200) NOT NULL,
  `min_parameters` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK411889E89F752FB8` (`category_id`),
  CONSTRAINT `pluggable_task_type_FK_1` FOREIGN KEY (`category_id`) REFERENCES `pluggable_task_type_category` (`id`),
  CONSTRAINT `FK411889E89F752FB8` FOREIGN KEY (`category_id`) REFERENCES `pluggable_task_type_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pluggable_task_type` */

LOCK TABLES `pluggable_task_type` WRITE;

insert  into `pluggable_task_type`(`id`,`category_id`,`class_name`,`min_parameters`) values (1,1,'com.sapienter.jbilling.server.pluggableTask.BasicLineTotalTask',0),(2,1,'com.sapienter.jbilling.server.pluggableTask.GSTTaxTask',2),(3,4,'com.sapienter.jbilling.server.pluggableTask.CalculateDueDate',0),(4,4,'com.sapienter.jbilling.server.pluggableTask.BasicCompositionTask',0),(5,2,'com.sapienter.jbilling.server.pluggableTask.BasicOrderFilterTask',0),(6,3,'com.sapienter.jbilling.server.pluggableTask.BasicInvoiceFilterTask',0),(7,5,'com.sapienter.jbilling.server.pluggableTask.BasicOrderPeriodTask',0),(8,6,'com.sapienter.jbilling.server.pluggableTask.PaymentAuthorizeNetTask',2),(9,7,'com.sapienter.jbilling.server.pluggableTask.BasicEmailNotificationTask',6),(10,8,'com.sapienter.jbilling.server.pluggableTask.BasicPaymentInfoTask',0),(11,6,'com.sapienter.jbilling.server.pluggableTask.PaymentPartnerTestTask',0),(12,7,'com.sapienter.jbilling.server.pluggableTask.PaperInvoiceNotificationTask',1),(13,4,'com.sapienter.jbilling.server.pluggableTask.CalculateDueDateDfFm',0),(14,3,'com.sapienter.jbilling.server.pluggableTask.NoInvoiceFilterTask',0),(15,9,'com.sapienter.jbilling.server.pluggableTask.BasicPenaltyTask',1),(16,2,'com.sapienter.jbilling.server.pluggableTask.OrderFilterAnticipatedTask',0),(17,5,'com.sapienter.jbilling.server.pluggableTask.OrderPeriodAnticipateTask',0),(19,6,'com.sapienter.jbilling.server.pluggableTask.PaymentEmailAuthorizeNetTask',1),(20,10,'com.sapienter.jbilling.server.pluggableTask.ProcessorEmailAlarmTask',3),(21,6,'com.sapienter.jbilling.server.pluggableTask.PaymentFakeTask',0),(22,6,'com.sapienter.jbilling.server.payment.tasks.PaymentRouterCCFTask',2),(23,11,'com.sapienter.jbilling.server.user.tasks.BasicSubscriptionStatusManagerTask',0),(24,6,'com.sapienter.jbilling.server.user.tasks.PaymentACHCommerceTask',5),(25,12,'com.sapienter.jbilling.server.payment.tasks.NoAsyncParameters',0),(26,12,'com.sapienter.jbilling.server.payment.tasks.RouterAsyncParameters',0),(28,13,'com.sapienter.jbilling.server.item.tasks.BasicItemManager',0),(29,13,'com.sapienter.jbilling.server.item.tasks.RulesItemManager',0),(30,1,'com.sapienter.jbilling.server.order.task.RulesLineTotalTask',0),(31,14,'com.sapienter.jbilling.server.item.tasks.RulesPricingTask',0),(32,15,'com.sapienter.jbilling.server.mediation.task.SeparatorFileReader',2),(33,16,'com.sapienter.jbilling.server.mediation.task.RulesMediationTask',0),(34,15,'com.sapienter.jbilling.server.mediation.task.FixedFileReader',2),(35,8,'com.sapienter.jbilling.server.user.tasks.PaymentInfoNoValidateTask',0),(36,7,'com.sapienter.jbilling.server.notification.task.TestNotificationTask',0),(37,5,'com.sapienter.jbilling.server.process.task.ProRateOrderPeriodTask',0),(38,4,'com.sapienter.jbilling.server.process.task.DailyProRateCompositionTask',0),(39,6,'com.sapienter.jbilling.server.payment.tasks.PaymentAtlasTask',5),(40,17,'com.sapienter.jbilling.server.order.task.RefundOnCancelTask',0),(41,17,'com.sapienter.jbilling.server.order.task.CancellationFeeRulesTask',1),(42,6,'com.sapienter.jbilling.server.payment.tasks.PaymentFilterTask',0),(43,17,'com.sapienter.jbilling.server.payment.blacklist.tasks.BlacklistUserStatusTask',0),(44,15,'com.sapienter.jbilling.server.mediation.task.JDBCReader',0),(45,15,'com.sapienter.jbilling.server.mediation.task.MySQLReader',0),(46,17,'com.sapienter.jbilling.server.provisioning.task.ProvisioningCommandsRulesTask',0),(47,18,'com.sapienter.jbilling.server.provisioning.task.TestExternalProvisioningTask',0),(48,18,'com.sapienter.jbilling.server.provisioning.task.CAIProvisioningTask',2),(49,6,'com.sapienter.jbilling.server.payment.tasks.PaymentRouterCurrencyTask',2),(50,18,'com.sapienter.jbilling.server.provisioning.task.MMSCProvisioningTask',5),(51,3,'com.sapienter.jbilling.server.invoice.task.NegativeBalanceInvoiceFilterTask',0),(52,17,'com.sapienter.jbilling.server.invoice.task.FileInvoiceExportTask',1),(53,17,'com.sapienter.jbilling.server.system.event.task.InternalEventsRulesTask',0),(54,17,'com.sapienter.jbilling.server.user.balance.DynamicBalanceManagerTask',0),(55,19,'com.sapienter.jbilling.server.user.tasks.UserBalanceValidatePurchaseTask',0),(56,19,'com.sapienter.jbilling.server.user.tasks.RulesValidatePurchaseTask',0),(57,6,'com.sapienter.jbilling.server.payment.tasks.PaymentsGatewayTask',4),(58,17,'com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask',1),(59,13,'com.sapienter.jbilling.server.order.task.RulesItemManager2',0),(60,1,'com.sapienter.jbilling.server.order.task.RulesLineTotalTask2',0),(61,14,'com.sapienter.jbilling.server.item.tasks.RulesPricingTask2',0),(62,17,'com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask',1),(63,6,'com.sapienter.jbilling.server.pluggableTask.PaymentFakeExternalStorage',0),(64,6,'com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayTask',3),(65,6,'com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayExternalTask',3),(66,17,'com.sapienter.jbilling.server.user.tasks.AutoRechargeTask',0),(67,6,'com.sapienter.jbilling.server.payment.tasks.PaymentBeanstreamTask',3),(68,6,'com.sapienter.jbilling.server.payment.tasks.PaymentSageTask',2),(69,20,'com.sapienter.jbilling.server.process.task.BasicBillingProcessFilterTask',0),(70,20,'com.sapienter.jbilling.server.process.task.BillableUsersBillingProcessFilterTask',0),(71,21,'com.sapienter.jbilling.server.mediation.task.SaveToFileMediationErrorHandler',0),(73,21,'com.sapienter.jbilling.server.mediation.task.SaveToJDBCMediationErrorHandler',1),(75,6,'com.sapienter.jbilling.server.payment.tasks.PaymentPaypalExternalTask',3),(76,6,'com.sapienter.jbilling.server.payment.tasks.PaymentAuthorizeNetCIMTask',2),(77,6,'com.sapienter.jbilling.server.payment.tasks.PaymentMethodRouterTask',4),(78,23,'com.sapienter.jbilling.server.rule.task.VelocityRulesGeneratorTask',2),(81,22,'com.sapienter.jbilling.server.mediation.task.MediationProcessTask',0),(82,22,'com.sapienter.jbilling.server.billing.task.BillingProcessTask',0),(83,22,'com.sapienter.jbilling.server.process.task.ScpUploadTask',4),(84,17,'com.sapienter.jbilling.server.payment.tasks.SaveACHExternallyTask',1),(85,20,'com.sapienter.jbilling.server.process.task.BillableUserOrdersBillingProcessFilterTask',0),(87,24,'com.sapienter.jbilling.server.process.task.BasicAgeingTask',0),(88,22,'com.sapienter.jbilling.server.process.task.AgeingProcessTask',0),(89,24,'com.sapienter.jbilling.server.process.task.BusinessDayAgeingTask',0),(90,4,'com.sapienter.jbilling.server.process.task.SimpleTaxCompositionTask',1);

UNLOCK TABLES;

/*Table structure for table `pluggable_task_type_category` */

DROP TABLE IF EXISTS `pluggable_task_type_category`;

CREATE TABLE `pluggable_task_type_category` (
  `id` int(11) NOT NULL,
  `interface_name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pluggable_task_type_category` */

LOCK TABLES `pluggable_task_type_category` WRITE;

insert  into `pluggable_task_type_category`(`id`,`interface_name`) values (1,'com.sapienter.jbilling.server.pluggableTask.OrderProcessingTask'),(2,'com.sapienter.jbilling.server.pluggableTask.OrderFilterTask'),(3,'com.sapienter.jbilling.server.pluggableTask.InvoiceFilterTask'),(4,'com.sapienter.jbilling.server.pluggableTask.InvoiceCompositionTask'),(5,'com.sapienter.jbilling.server.pluggableTask.OrderPeriodTask'),(6,'com.sapienter.jbilling.server.pluggableTask.PaymentTask'),(7,'com.sapienter.jbilling.server.pluggableTask.NotificationTask'),(8,'com.sapienter.jbilling.server.pluggableTask.PaymentInfoTask'),(9,'com.sapienter.jbilling.server.pluggableTask.PenaltyTask'),(10,'com.sapienter.jbilling.server.pluggableTask.ProcessorAlarm'),(11,'com.sapienter.jbilling.server.user.tasks.ISubscriptionStatusManager'),(12,'com.sapienter.jbilling.server.payment.tasks.IAsyncPaymentParameters'),(13,'com.sapienter.jbilling.server.item.tasks.IItemPurchaseManager'),(14,'com.sapienter.jbilling.server.item.tasks.IPricing'),(15,'com.sapienter.jbilling.server.mediation.task.IMediationReader'),(16,'com.sapienter.jbilling.server.mediation.task.IMediationProcess'),(17,'com.sapienter.jbilling.server.system.event.task.IInternalEventsTask'),(18,'com.sapienter.jbilling.server.provisioning.task.IExternalProvisioning'),(19,'com.sapienter.jbilling.server.user.tasks.IValidatePurchaseTask'),(20,'com.sapienter.jbilling.server.process.task.IBillingProcessFilterTask'),(21,'com.sapienter.jbilling.server.mediation.task.IMediationErrorHandler'),(22,'com.sapienter.jbilling.server.process.task.IScheduledTask'),(23,'com.sapienter.jbilling.server.rule.task.IRulesGenerator'),(24,'com.sapienter.jbilling.server.process.task.IAgeingTask');

UNLOCK TABLES;

/*Table structure for table `preference` */

DROP TABLE IF EXISTS `preference`;

CREATE TABLE `preference` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `table_id` int(11) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA8FCBCDBD4E53D6E` (`type_id`),
  KEY `FKA8FCBCDBDD2012ED` (`table_id`),
  CONSTRAINT `preference_FK_2` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `FKA8FCBCDBD4E53D6E` FOREIGN KEY (`type_id`) REFERENCES `preference_type` (`id`),
  CONSTRAINT `FKA8FCBCDBDD2012ED` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `preference_FK_1` FOREIGN KEY (`type_id`) REFERENCES `preference_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `preference` */

LOCK TABLES `preference` WRITE;

insert  into `preference`(`id`,`type_id`,`table_id`,`foreign_id`,`value`) values (10,4,5,11,'5'),(11,14,5,11,'1');

UNLOCK TABLES;

/*Table structure for table `preference_type` */

DROP TABLE IF EXISTS `preference_type`;

CREATE TABLE `preference_type` (
  `id` int(11) NOT NULL,
  `def_value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `preference_type` */

LOCK TABLES `preference_type` WRITE;

insert  into `preference_type`(`id`,`def_value`) values (4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,'1'),(20,'1'),(21,'0'),(22,NULL),(23,NULL),(24,'0'),(25,'0'),(27,'0'),(28,NULL),(29,'https://www.paypal.com/en_US/i/btn/x-click-but6.gif'),(30,NULL),(31,'2000-01-01'),(32,'0'),(33,'0'),(35,'0'),(36,'1'),(37,'0'),(38,'1'),(39,'0'),(40,'0'),(41,'0'),(42,'0'),(43,'0'),(44,'0'),(45,'0'),(46,'0'),(47,'0'),(48,'1'),(49,NULL),(50,'2');

UNLOCK TABLES;

/*Table structure for table `process_run` */

DROP TABLE IF EXISTS `process_run`;

CREATE TABLE `process_run` (
  `id` int(11) NOT NULL,
  `process_id` int(11) DEFAULT NULL,
  `run_date` datetime NOT NULL,
  `started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `finished` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_finished` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoices_generated` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_run_process_ix` (`process_id`),
  KEY `FKC1738BB16E66B40` (`status_id`),
  KEY `FKC1738BB880BECDD` (`process_id`),
  CONSTRAINT `process_run_FK_2` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FKC1738BB16E66B40` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FKC1738BB880BECDD` FOREIGN KEY (`process_id`) REFERENCES `billing_process` (`id`),
  CONSTRAINT `process_run_FK_1` FOREIGN KEY (`process_id`) REFERENCES `billing_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `process_run` */

LOCK TABLES `process_run` WRITE;

UNLOCK TABLES;

/*Table structure for table `process_run_total` */

DROP TABLE IF EXISTS `process_run_total`;

CREATE TABLE `process_run_total` (
  `id` int(11) NOT NULL,
  `process_run_id` int(11) DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `total_invoiced` decimal(22,10) DEFAULT NULL,
  `total_paid` decimal(22,10) DEFAULT NULL,
  `total_not_paid` decimal(22,10) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_run_total_run_ix` (`process_run_id`),
  KEY `FK8ADBEC083E7C369` (`process_run_id`),
  KEY `FK8ADBEC0BF4F395B` (`currency_id`),
  CONSTRAINT `process_run_total_FK_2` FOREIGN KEY (`process_run_id`) REFERENCES `process_run` (`id`),
  CONSTRAINT `FK8ADBEC083E7C369` FOREIGN KEY (`process_run_id`) REFERENCES `process_run` (`id`),
  CONSTRAINT `FK8ADBEC0BF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `process_run_total_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `process_run_total` */

LOCK TABLES `process_run_total` WRITE;

UNLOCK TABLES;

/*Table structure for table `process_run_total_pm` */

DROP TABLE IF EXISTS `process_run_total_pm`;

CREATE TABLE `process_run_total_pm` (
  `id` int(11) NOT NULL,
  `process_run_total_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `total` decimal(22,10) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_pm_index_total` (`process_run_total_id`),
  KEY `FKF2EA3BDC49AE3B28` (`payment_method_id`),
  KEY `FKF2EA3BDC5D99B76A` (`process_run_total_id`),
  CONSTRAINT `process_run_total_pm_FK_1` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FKF2EA3BDC49AE3B28` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FKF2EA3BDC5D99B76A` FOREIGN KEY (`process_run_total_id`) REFERENCES `process_run_total` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `process_run_total_pm` */

LOCK TABLES `process_run_total_pm` WRITE;

UNLOCK TABLES;

/*Table structure for table `process_run_user` */

DROP TABLE IF EXISTS `process_run_user`;

CREATE TABLE `process_run_user` (
  `id` int(11) NOT NULL,
  `process_run_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_run_user_run_ix` (`process_run_id`,`user_id`),
  KEY `FKBE37A8CF83E7C369` (`process_run_id`),
  KEY `FKBE37A8CF7A85DBFE` (`user_id`),
  CONSTRAINT `process_run_user_FK_2` FOREIGN KEY (`process_run_id`) REFERENCES `process_run` (`id`),
  CONSTRAINT `FKBE37A8CF7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FKBE37A8CF83E7C369` FOREIGN KEY (`process_run_id`) REFERENCES `process_run` (`id`),
  CONSTRAINT `process_run_user_FK_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `process_run_user` */

LOCK TABLES `process_run_user` WRITE;

UNLOCK TABLES;

/*Table structure for table `promotion` */

DROP TABLE IF EXISTS `promotion`;

CREATE TABLE `promotion` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `once` smallint(6) NOT NULL,
  `since` datetime DEFAULT NULL,
  `until` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_promotion_code` (`code`),
  KEY `promotion_FK_1` (`item_id`),
  CONSTRAINT `promotion_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `promotion` */

LOCK TABLES `promotion` WRITE;

UNLOCK TABLES;

/*Table structure for table `purchase_order` */

DROP TABLE IF EXISTS `purchase_order`;

CREATE TABLE `purchase_order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL,
  `billing_type_id` int(11) NOT NULL,
  `active_since` datetime DEFAULT NULL,
  `active_until` datetime DEFAULT NULL,
  `cycle_start` datetime DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `next_billable_day` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `notify` smallint(6) DEFAULT NULL,
  `last_notified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notification_step` int(11) DEFAULT NULL,
  `due_date_unit_id` int(11) DEFAULT NULL,
  `due_date_value` int(11) DEFAULT NULL,
  `df_fm` smallint(6) DEFAULT NULL,
  `anticipate_periods` int(11) DEFAULT NULL,
  `own_invoice` smallint(6) DEFAULT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `notes_in_invoice` smallint(6) DEFAULT NULL,
  `is_current` smallint(6) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_i_user` (`user_id`,`deleted`),
  KEY `purchase_order_i_notif` (`active_until`,`notification_step`),
  KEY `ix_purchase_order_date` (`user_id`,`create_datetime`),
  KEY `FK71A56A90BF4F395B` (`currency_id`),
  KEY `FK71A56A90D4EE96FD` (`created_by`),
  KEY `FK71A56A90F32A2961` (`period_id`),
  KEY `FK71A56A905F6FB55C` (`billing_type_id`),
  KEY `FK71A56A907A85DBFE` (`user_id`),
  KEY `FK71A56A90B8D581BF` (`status_id`),
  CONSTRAINT `purchase_order_FK_6` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK71A56A905F6FB55C` FOREIGN KEY (`billing_type_id`) REFERENCES `order_billing_type` (`id`),
  CONSTRAINT `FK71A56A907A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK71A56A90B8D581BF` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `FK71A56A90BF4F395B` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK71A56A90D4EE96FD` FOREIGN KEY (`created_by`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FK71A56A90F32A2961` FOREIGN KEY (`period_id`) REFERENCES `order_period` (`id`),
  CONSTRAINT `purchase_order_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `purchase_order_FK_2` FOREIGN KEY (`billing_type_id`) REFERENCES `order_billing_type` (`id`),
  CONSTRAINT `purchase_order_FK_3` FOREIGN KEY (`period_id`) REFERENCES `order_period` (`id`),
  CONSTRAINT `purchase_order_FK_4` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `purchase_order_FK_5` FOREIGN KEY (`created_by`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `purchase_order` */

LOCK TABLES `purchase_order` WRITE;

UNLOCK TABLES;

/*Table structure for table `recent_item` */

DROP TABLE IF EXISTS `recent_item`;

CREATE TABLE `recent_item` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `object_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `recent_item` */

LOCK TABLES `recent_item` WRITE;

UNLOCK TABLES;

/*Table structure for table `report` */

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC84C55345DF2AC03` (`type_id`),
  CONSTRAINT `report_FK_1` FOREIGN KEY (`type_id`) REFERENCES `report_type` (`id`),
  CONSTRAINT `FKC84C55345DF2AC03` FOREIGN KEY (`type_id`) REFERENCES `report_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `report` */

LOCK TABLES `report` WRITE;

insert  into `report`(`id`,`type_id`,`name`,`file_name`,`OPTLOCK`) values (1,1,'total_invoiced','total_invoiced.jasper',0),(2,1,'ageing_balance','ageing_balance.jasper',0),(3,2,'product_subscribers','product_subscribers.jasper',0),(4,3,'total_payments','total_payments.jasper',0),(5,4,'user_signups','user_signups.jasper',0),(6,4,'top_customers','top_customers.jasper',0),(7,1,'accounts_receivable','accounts_receivable.jasper',0),(8,1,'gl_detail','gl_detail.jasper',0),(9,1,'gl_summary','gl_summary.jasper',0);

UNLOCK TABLES;

/*Table structure for table `report_parameter` */

DROP TABLE IF EXISTS `report_parameter`;

CREATE TABLE `report_parameter` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `dtype` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK22DA125E5CD8E463` (`report_id`),
  CONSTRAINT `report_parameter_FK_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
  CONSTRAINT `FK22DA125E5CD8E463` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `report_parameter` */

LOCK TABLES `report_parameter` WRITE;

insert  into `report_parameter`(`id`,`report_id`,`dtype`,`name`) values (1,1,'date','start_date'),(2,1,'date','end_date'),(3,1,'integer','period'),(4,3,'integer','item_id'),(5,4,'date','start_date'),(6,4,'date','end_date'),(7,4,'integer','period'),(8,5,'date','start_date'),(9,5,'date','end_date'),(10,5,'integer','period'),(11,6,'date','start_date'),(12,6,'date','end_date'),(13,8,'date','date'),(14,9,'date','date');

UNLOCK TABLES;

/*Table structure for table `report_type` */

DROP TABLE IF EXISTS `report_type`;

CREATE TABLE `report_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `report_type` */

LOCK TABLES `report_type` WRITE;

insert  into `report_type`(`id`,`name`,`OPTLOCK`) values (1,'invoice',0),(2,'order',0),(3,'payment',0),(4,'user',0);

UNLOCK TABLES;

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role_type_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK358076A7AC55E` (`entity_id`),
  CONSTRAINT `FK358076A7AC55E` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

LOCK TABLES `role` WRITE;

insert  into `role`(`id`,`role_type_id`,`entity_id`) values (2,2,NULL),(3,3,NULL),(5,5,NULL),(60,2,11),(61,3,11),(62,5,11);

UNLOCK TABLES;

/*Table structure for table `shortcut` */

DROP TABLE IF EXISTS `shortcut`;

CREATE TABLE `shortcut` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shortcut` */

LOCK TABLES `shortcut` WRITE;

UNLOCK TABLES;

/*Table structure for table `user_credit_card_map` */

DROP TABLE IF EXISTS `user_credit_card_map`;

CREATE TABLE `user_credit_card_map` (
  `user_id` int(11) DEFAULT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  KEY `user_credit_card_map_i_2` (`user_id`,`credit_card_id`),
  KEY `FKA68A61BF7A85DBFE` (`user_id`),
  KEY `FKA68A61BF2E23C475` (`credit_card_id`),
  CONSTRAINT `FKA68A61BF2E23C475` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`id`),
  CONSTRAINT `FKA68A61BF7A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_credit_card_map` */

LOCK TABLES `user_credit_card_map` WRITE;

UNLOCK TABLES;

/*Table structure for table `user_role_map` */

DROP TABLE IF EXISTS `user_role_map`;

CREATE TABLE `user_role_map` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `user_role_map_i_2` (`user_id`,`role_id`),
  KEY `user_role_map_i_role` (`role_id`),
  KEY `FKF3248407B87C819E` (`role_id`),
  KEY `FKF32484077A85DBFE` (`user_id`),
  CONSTRAINT `user_role_map_FK_2` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FKF32484077A85DBFE` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `FKF3248407B87C819E` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_role_map_FK_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_role_map` */

LOCK TABLES `user_role_map` WRITE;

insert  into `user_role_map`(`user_id`,`role_id`) values (10,60);

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
