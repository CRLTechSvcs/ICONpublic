-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (i386)
--
-- Host: localhost    Database: icondata
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `A1issues_per_publication`
--

DROP TABLE IF EXISTS `A1issues_per_publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `A1issues_per_publication` (
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_valid` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `MINissue_date` date DEFAULT '0000-00-00',
  `MINVALIDissue_date` date DEFAULT '0000-00-00',
  `MAXissue_date` date DEFAULT '0000-00-00',
  `MAXVALIDissue_date` date DEFAULT '0000-00-00',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `A1pub_id` (`pub_id`),
  CONSTRAINT `A1_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `A1issues_per_publication_NO`
--

DROP TABLE IF EXISTS `A1issues_per_publication_NO`;
/*!50001 DROP VIEW IF EXISTS `A1issues_per_publication_NO`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `A1issues_per_publication_NO` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `A2issues_per_organization`
--

DROP TABLE IF EXISTS `A2issues_per_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `A2issues_per_organization` (
  `A2_id` int(10) NOT NULL AUTO_INCREMENT,
  `num_issues` bigint(20) NOT NULL,
  `org_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`A2_id`),
  KEY `org_id` (`org_id`),
  KEY `pub_id` (`pub_id`),
  CONSTRAINT `A2_org_id_fkey` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `A2_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1007734 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `AQMneedsMWAnum`
--

DROP TABLE IF EXISTS `AQMneedsMWAnum`;
/*!50001 DROP VIEW IF EXISTS `AQMneedsMWAnum`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `AQMneedsMWAnum` (
 `pub_id` tinyint NOT NULL,
  `OCLC` tinyint NOT NULL,
  `marc001` tinyint NOT NULL,
  `pub_title` tinyint NOT NULL,
  `pub_city` tinyint NOT NULL,
  `country_id` tinyint NOT NULL,
  `pub_bgnDate` tinyint NOT NULL,
  `pub_endDate` tinyint NOT NULL,
  `date362` tinyint NOT NULL,
  `freq_id_code` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `B1country_issues_per_year`
--

DROP TABLE IF EXISTS `B1country_issues_per_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `B1country_issues_per_year` (
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_name` text COLLATE utf8_unicode_ci,
  `issue_year` text COLLATE utf8_unicode_ci,
  `publications_count` int(10) unsigned DEFAULT '0',
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `B1_county_id_fkey` (`country_id`),
  CONSTRAINT `B1_county_id_fkey` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `B2publication_issues_per_year`
--

DROP TABLE IF EXISTS `B2publication_issues_per_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `B2publication_issues_per_year` (
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `issue_year` text COLLATE utf8_unicode_ci,
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `B2pub_id` (`pub_id`),
  CONSTRAINT `B2_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `B3publications_per_country`
--

DROP TABLE IF EXISTS `B3publications_per_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `B3publications_per_country` (
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `pub_holders_count` int(10) unsigned DEFAULT '0',
  `MINissue_date` date DEFAULT '0000-00-00',
  `MAXissue_date` date DEFAULT '0000-00-00',
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `B2pub_id` (`pub_id`),
  KEY `B3_county_id_fkey` (`country_id`),
  CONSTRAINT `B3_county_id_fkey` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE,
  CONSTRAINT `B3_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BX_digitized_issue_details`
--

DROP TABLE IF EXISTS `BX_digitized_issue_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BX_digitized_issue_details` (
  `BX_id` int(10) NOT NULL AUTO_INCREMENT,
  `country_id` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_name` text COLLATE utf8_unicode_ci,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `org_title` text COLLATE utf8_unicode_ci,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `issue_date` date DEFAULT '0000-00-00',
  `format_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`BX_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3162905 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `C1org_issues_per_year`
--

DROP TABLE IF EXISTS `C1org_issues_per_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `C1org_issues_per_year` (
  `org_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `org_title` text COLLATE utf8_unicode_ci,
  `issue_year` text COLLATE utf8_unicode_ci,
  `publications_count` int(10) unsigned DEFAULT '0',
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `C1org_id` (`org_id`),
  CONSTRAINT `C1_org_id_fkey` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `C2publication_issues_per_org`
--

DROP TABLE IF EXISTS `C2publication_issues_per_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `C2publication_issues_per_org` (
  `org_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `org_title` text COLLATE utf8_unicode_ci,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `org_issue_count_distinct` int(10) unsigned DEFAULT '0',
  `issue_date` date DEFAULT '0000-00-00',
  `org_issue_count_for_date` int(10) unsigned DEFAULT '0',
  `format_count_distinct_for_date` int(10) unsigned DEFAULT '0',
  `format_name` text COLLATE utf8_unicode_ci,
  `rawIssueData` text COLLATE utf8_unicode_ci,
  KEY `C2_pub_id_fkey` (`pub_id`),
  KEY `C2_org_id_fkey` (`org_id`),
  CONSTRAINT `C2_org_id_fkey` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `C2_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `C3issues_view_sn82014768_DLC`
--

DROP TABLE IF EXISTS `C3issues_view_sn82014768_DLC`;
/*!50001 DROP VIEW IF EXISTS `C3issues_view_sn82014768_DLC`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `C3issues_view_sn82014768_DLC` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `C3publications_per_org`
--

DROP TABLE IF EXISTS `C3publications_per_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `C3publications_per_org` (
  `org_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `org_title` text COLLATE utf8_unicode_ci,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `org_issues_count` int(10) unsigned DEFAULT '0',
  `MINissue_date` date DEFAULT '0000-00-00',
  `MAXissue_date` date DEFAULT '0000-00-00',
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `org_rawIssueData` text COLLATE utf8_unicode_ci,
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `C3pub_id` (`pub_id`),
  KEY `C3_org_id_fkey` (`org_id`),
  CONSTRAINT `C3_org_id_fkey` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `C3_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `C3publications_per_org_fill_single_publication_2012225114`
--

DROP TABLE IF EXISTS `C3publications_per_org_fill_single_publication_2012225114`;
/*!50001 DROP VIEW IF EXISTS `C3publications_per_org_fill_single_publication_2012225114`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `C3publications_per_org_fill_single_publication_2012225114` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `C3publications_per_org_fill_single_publication_sn94022381`
--

DROP TABLE IF EXISTS `C3publications_per_org_fill_single_publication_sn94022381`;
/*!50001 DROP VIEW IF EXISTS `C3publications_per_org_fill_single_publication_sn94022381`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `C3publications_per_org_fill_single_publication_sn94022381` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `C3publications_per_org_temp_view`
--

DROP TABLE IF EXISTS `C3publications_per_org_temp_view`;
/*!50001 DROP VIEW IF EXISTS `C3publications_per_org_temp_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `C3publications_per_org_temp_view` (
 `pub_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `D1publications_per_title`
--

DROP TABLE IF EXISTS `D1publications_per_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `D1publications_per_title` (
  `input_title` text COLLATE utf8_unicode_ci,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniform_title` text COLLATE utf8_unicode_ci,
  `MINissue_date` date DEFAULT '0000-00-00',
  `MAXissue_date` date DEFAULT '0000-00-00',
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `D1pub_id` (`pub_id`),
  CONSTRAINT `D1_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `D2publications_suspected_dupes`
--

DROP TABLE IF EXISTS `D2publications_suspected_dupes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `D2publications_suspected_dupes` (
  `input_title` text COLLATE utf8_unicode_ci,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniform_title` text COLLATE utf8_unicode_ci,
  `MINissue_date` date DEFAULT '0000-00-00',
  `MAXissue_date` date DEFAULT '0000-00-00',
  `issue_count_total` int(10) unsigned DEFAULT '0',
  `issue_count_distinct` int(10) unsigned DEFAULT '0',
  `format_count_distinct` int(10) unsigned DEFAULT '0',
  `1_unspecified_unknown` int(10) unsigned DEFAULT '0',
  `2_Paper` int(10) unsigned DEFAULT '0',
  `3_Paper_original` int(10) unsigned DEFAULT '0',
  `4_Microfilm` int(10) unsigned DEFAULT '0',
  `5_Microfiche` int(10) unsigned DEFAULT '0',
  `6_Microopaque` int(10) unsigned DEFAULT '0',
  `7_Reprint` int(10) unsigned DEFAULT '0',
  `8_Digital_pdf` int(10) unsigned DEFAULT '0',
  `9_Facsimile` int(10) unsigned DEFAULT '0',
  `10_Photocopy` int(10) unsigned DEFAULT '0',
  `11_Textile` int(10) unsigned DEFAULT '0',
  `12_Digital_direct_electronic` int(10) unsigned DEFAULT '0',
  `13_Microform` int(10) unsigned DEFAULT '0',
  `14_Digital_unspecified` int(10) unsigned DEFAULT '0',
  `15_Digital_tiff` int(10) unsigned DEFAULT '0',
  KEY `D2pub_id` (`pub_id`),
  CONSTRAINT `D2_pub_id_fkey` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `OrgFirst`
--

DROP TABLE IF EXISTS `OrgFirst`;
/*!50001 DROP VIEW IF EXISTS `OrgFirst`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `OrgFirst` (
 `pub_id` tinyint NOT NULL,
  `OCLC` tinyint NOT NULL,
  `uniform_title` tinyint NOT NULL,
  `held_by_org_1` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `OrgSecond`
--

DROP TABLE IF EXISTS `OrgSecond`;
/*!50001 DROP VIEW IF EXISTS `OrgSecond`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `OrgSecond` (
 `pub_id` tinyint NOT NULL,
  `OCLC` tinyint NOT NULL,
  `uniform_title` tinyint NOT NULL,
  `held_by_org_2` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `archive_status`
--

DROP TABLE IF EXISTS `archive_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive_status` (
  `archive_status_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `archive_status_name` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `archive_status_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`archive_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bib_relationship_types`
--

DROP TABLE IF EXISTS `bib_relationship_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bib_relationship_types` (
  `rel_type_id` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rel_type_description` text COLLATE utf8_unicode_ci,
  `rel_type_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`rel_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bib_relationships`
--

DROP TABLE IF EXISTS `bib_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bib_relationships` (
  `relationship_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `relationship_from_pub_id` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rel_type_id` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relationship_to_title` text COLLATE utf8_unicode_ci,
  `relationship_to_pub_id` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relationship_to_control_num` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relationship_to_ISSN` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`relationship_id`),
  KEY `rel_type_id` (`rel_type_id`),
  KEY `relationship_from_pub_id` (`relationship_from_pub_id`),
  CONSTRAINT `bib_relationships_ibfk_1` FOREIGN KEY (`rel_type_id`) REFERENCES `bib_relationship_types` (`rel_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `bib_relationships_ibfk_2` FOREIGN KEY (`relationship_from_pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=208825 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `collection_issues`
--

DROP TABLE IF EXISTS `collection_issues`;
/*!50001 DROP VIEW IF EXISTS `collection_issues`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `collection_issues` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `collection_publications`
--

DROP TABLE IF EXISTS `collection_publications`;
/*!50001 DROP VIEW IF EXISTS `collection_publications`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `collection_publications` (
 `pub_id` tinyint NOT NULL,
  `pub_title` tinyint NOT NULL,
  `pub_city` tinyint NOT NULL,
  `country_name` tinyint NOT NULL,
  `pub_bgnDate` tinyint NOT NULL,
  `pub_endDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `collection_id` smallint(5) unsigned NOT NULL,
  `collection_title_one` text COLLATE utf8_unicode_ci,
  `collection_title_two` text COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `country_id_subject` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `collection_home_uri` mediumtext COLLATE utf8_unicode_ci,
  `collection_CRLprofile_uri` mediumtext COLLATE utf8_unicode_ci,
  `collection_update_date` date DEFAULT '0000-00-00',
  `collection_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`collection_id`),
  KEY `org_id` (`org_id`),
  KEY `format_id` (`format_id`),
  KEY `country_id_subject` (`country_id_subject`),
  CONSTRAINT `coll_ctry_ibfk_subj` FOREIGN KEY (`country_id_subject`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE,
  CONSTRAINT `coll_format_ibfk` FOREIGN KEY (`format_id`) REFERENCES `formats` (`format_id`) ON UPDATE CASCADE,
  CONSTRAINT `coll_org_ibfk` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `condition_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `country_id` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `country_name` text COLLATE utf8_unicode_ci,
  `country_region` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country_minMax_date`
--

DROP TABLE IF EXISTS `country_minMax_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_minMax_date` (
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MINissue_date` date DEFAULT NULL,
  `MAXissue_date` date DEFAULT NULL,
  KEY `country_id` (`country_id`),
  KEY `MINissue_date` (`MINissue_date`),
  KEY `MAXissue_date` (`MAXissue_date`),
  CONSTRAINT `cmmdate_county_id_fkey` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `flnewCollections`
--

DROP TABLE IF EXISTS `flnewCollections`;
/*!50001 DROP VIEW IF EXISTS `flnewCollections`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `flnewCollections` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `format_view_sn82014768_DLC`
--

DROP TABLE IF EXISTS `format_view_sn82014768_DLC`;
/*!50001 DROP VIEW IF EXISTS `format_view_sn82014768_DLC`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `format_view_sn82014768_DLC` (
 `issue_id` tinyint NOT NULL,
  `pub_id` tinyint NOT NULL,
  `issue_date` tinyint NOT NULL,
  `rawIssueData` tinyint NOT NULL,
  `org_id` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `archive_status_id` tinyint NOT NULL,
  `provenance_id` tinyint NOT NULL,
  `collection_id` tinyint NOT NULL,
  `update_date` tinyint NOT NULL,
  `issue_note` tinyint NOT NULL,
  `specificIssuesCreated` tinyint NOT NULL,
  `specificIssuesCreatedDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `formats`
--

DROP TABLE IF EXISTS `formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formats` (
  `format_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `format_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `format_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`format_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frequencies`
--

DROP TABLE IF EXISTS `frequencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frequencies` (
  `freq_id_code` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `freq_word` text COLLATE utf8_unicode_ci,
  `freq_description` text COLLATE utf8_unicode_ci,
  `freq_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`freq_id_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `issue_id` int(10) NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `condition_id` tinyint(3) unsigned DEFAULT NULL,
  `format` text COLLATE utf8_unicode_ci,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `archive_status_id` tinyint(3) unsigned DEFAULT NULL,
  `provenance_id` int(10) unsigned NOT NULL,
  `collection_id` smallint(5) unsigned DEFAULT '1',
  `update_date` date DEFAULT NULL,
  `issue_note` mediumtext COLLATE utf8_unicode_ci,
  `specificIssuesCreated` tinyint(1) DEFAULT '0',
  `specificIssuesCreatedDate` date DEFAULT '0000-00-00',
  PRIMARY KEY (`issue_id`),
  KEY `issue_id` (`issue_id`),
  KEY `repos_id` (`org_id`),
  KEY `issue_date` (`issue_date`),
  KEY `specificIssuesCreatedDate` (`specificIssuesCreatedDate`),
  KEY `condition_id` (`condition_id`),
  KEY `format_id` (`format_id`),
  KEY `archive_status_id` (`archive_status_id`),
  KEY `pub_date` (`pub_id`,`issue_date`),
  KEY `pub_format` (`pub_id`,`format_id`),
  KEY `date_format` (`issue_date`,`format_id`),
  KEY `issues_ibfk_6` (`provenance_id`),
  KEY `issue_collection_FK` (`collection_id`),
  KEY `pub_collection` (`pub_id`,`collection_id`),
  KEY `pub_org` (`pub_id`,`org_id`),
  CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_3` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_4` FOREIGN KEY (`format_id`) REFERENCES `formats` (`format_id`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_5` FOREIGN KEY (`archive_status_id`) REFERENCES `archive_status` (`archive_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_6` FOREIGN KEY (`provenance_id`) REFERENCES `provenances` (`provenance_id`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_7` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `issue_collection_FK` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111126077 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuesDLCdigital`
--

DROP TABLE IF EXISTS `issuesDLCdigital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuesDLCdigital` (
  `issue_id` int(10) NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `condition_id` tinyint(3) unsigned DEFAULT NULL,
  `format` text COLLATE utf8_unicode_ci,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `archive_status_id` tinyint(3) unsigned DEFAULT NULL,
  `provenance_id` int(10) unsigned NOT NULL,
  `collection_id` smallint(5) unsigned DEFAULT '1',
  `update_date` date DEFAULT NULL,
  `issue_note` mediumtext COLLATE utf8_unicode_ci,
  `specificIssuesCreated` tinyint(1) DEFAULT '0',
  `specificIssuesCreatedDate` date DEFAULT '0000-00-00',
  PRIMARY KEY (`issue_id`),
  KEY `issue_id` (`issue_id`),
  KEY `repos_id` (`org_id`),
  KEY `issue_date` (`issue_date`),
  KEY `specificIssuesCreatedDate` (`specificIssuesCreatedDate`),
  KEY `condition_id` (`condition_id`),
  KEY `format_id` (`format_id`),
  KEY `archive_status_id` (`archive_status_id`),
  KEY `pub_date` (`pub_id`,`issue_date`),
  KEY `pub_format` (`pub_id`,`format_id`),
  KEY `date_format` (`issue_date`,`format_id`),
  KEY `issuesDLCdigital_ibfk_6` (`provenance_id`),
  KEY `issDLC_collection_FK` (`collection_id`),
  KEY `issDLC_pub_collection` (`pub_id`,`collection_id`),
  KEY `issDLC_pub_org` (`pub_id`,`org_id`),
  CONSTRAINT `issDLC_collection_FK` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLC_ibfk_2` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLC_ibfk_3` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLC_ibfk_4` FOREIGN KEY (`format_id`) REFERENCES `formats` (`format_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLC_ibfk_5` FOREIGN KEY (`archive_status_id`) REFERENCES `archive_status` (`archive_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLC_ibfk_6` FOREIGN KEY (`provenance_id`) REFERENCES `provenances` (`provenance_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLC_ibfk_7` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100894238 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuesDLCdigitalNEW`
--

DROP TABLE IF EXISTS `issuesDLCdigitalNEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuesDLCdigitalNEW` (
  `issue_id` int(10) NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `condition_id` tinyint(3) unsigned DEFAULT NULL,
  `format` text COLLATE utf8_unicode_ci,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `archive_status_id` tinyint(3) unsigned DEFAULT NULL,
  `provenance_id` int(10) unsigned NOT NULL,
  `collection_id` smallint(5) unsigned DEFAULT '1',
  `update_date` date DEFAULT NULL,
  `issue_note` mediumtext COLLATE utf8_unicode_ci,
  `specificIssuesCreated` tinyint(1) DEFAULT '0',
  `specificIssuesCreatedDate` date DEFAULT '0000-00-00',
  PRIMARY KEY (`issue_id`),
  KEY `issue_id` (`issue_id`),
  KEY `repos_id` (`org_id`),
  KEY `issue_date` (`issue_date`),
  KEY `specificIssuesCreatedDate` (`specificIssuesCreatedDate`),
  KEY `condition_id` (`condition_id`),
  KEY `format_id` (`format_id`),
  KEY `archive_status_id` (`archive_status_id`),
  KEY `pub_date` (`pub_id`,`issue_date`),
  KEY `pub_format` (`pub_id`,`format_id`),
  KEY `date_format` (`issue_date`,`format_id`),
  KEY `issuesDLCNEW_ibfk_6` (`provenance_id`),
  KEY `issDLCNEW_collection_FK` (`collection_id`),
  KEY `issDLCNEW_pub_collection` (`pub_id`,`collection_id`),
  KEY `issDLCNEW_pub_org` (`pub_id`,`org_id`),
  CONSTRAINT `issDLCNEW_collection_FK` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLCNEW_ibfk_2` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLCNEW_ibfk_3` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLCNEW_ibfk_4` FOREIGN KEY (`format_id`) REFERENCES `formats` (`format_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLCNEW_ibfk_5` FOREIGN KEY (`archive_status_id`) REFERENCES `archive_status` (`archive_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLCNEW_ibfk_6` FOREIGN KEY (`provenance_id`) REFERENCES `provenances` (`provenance_id`) ON UPDATE CASCADE,
  CONSTRAINT `issDLCNEW_ibfk_7` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1512456 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `language_id` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'eng',
  `language_family` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language_name` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `native_name` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ISO639_1` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ISO639_2B` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ISO639_3` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_types`
--

DROP TABLE IF EXISTS `organization_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_types` (
  `org_type_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `org_type_name` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`org_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations` (
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `org_marcOrgCode` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `org_oclc_identifier` int(10) unsigned DEFAULT NULL,
  `org_type_id` smallint(5) unsigned NOT NULL,
  `org_name` mediumtext COLLATE utf8_unicode_ci,
  `org_display_name` mediumtext COLLATE utf8_unicode_ci,
  `org_street1` mediumtext COLLATE utf8_unicode_ci,
  `org_street2` mediumtext COLLATE utf8_unicode_ci,
  `org_city` mediumtext COLLATE utf8_unicode_ci,
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `org_postalCode` text COLLATE utf8_unicode_ci,
  `org_latitude` text COLLATE utf8_unicode_ci,
  `org_longitude` text COLLATE utf8_unicode_ci,
  `org_home_uri` mediumtext COLLATE utf8_unicode_ci,
  `org_opac_uri` mediumtext COLLATE utf8_unicode_ci,
  `org_update_date` date DEFAULT '0000-00-00',
  `org_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`org_id`),
  KEY `repos_type_id` (`org_type_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`org_type_id`) REFERENCES `organization_types` (`org_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `organizations_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provenances`
--

DROP TABLE IF EXISTS `provenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provenances` (
  `provenance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reproduction_id` int(10) unsigned NOT NULL DEFAULT '1',
  `provenance_update_date` date DEFAULT NULL,
  `provenance_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`provenance_id`),
  KEY `provenance_id` (`provenance_id`),
  KEY `reproduction_id` (`reproduction_id`),
  CONSTRAINT `prov_ibfk_1` FOREIGN KEY (`reproduction_id`) REFERENCES `reproductions` (`reproduction_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_collections`
--

DROP TABLE IF EXISTS `pub_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_collections` (
  `pub_collections_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `collection_id` smallint(5) unsigned NOT NULL,
  `pub_coll_update_date` date DEFAULT '0000-00-00',
  `pub_coll_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`pub_collections_id`),
  KEY `collection_id` (`collection_id`),
  KEY `pub_id` (`pub_id`),
  KEY `coll_pub_id` (`collection_id`,`pub_id`),
  CONSTRAINT `colpub_coll_id_ibfk` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`) ON UPDATE CASCADE,
  CONSTRAINT `colpub_pub_id_ibfk` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10851 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_frequencies`
--

DROP TABLE IF EXISTS `pub_frequencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_frequencies` (
  `pff_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `freq_id_code` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `freq_statement` text COLLATE utf8_unicode_ci,
  `freq_bgnDate` date DEFAULT NULL,
  `freq_endDate` date DEFAULT NULL,
  PRIMARY KEY (`pff_id`),
  KEY `pub_id` (`pub_id`),
  KEY `freq_id_code` (`freq_id_code`),
  CONSTRAINT `pub_frequencies_ibfk_1` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE,
  CONSTRAINT `pub_frequencies_ibfk_2` FOREIGN KEY (`freq_id_code`) REFERENCES `frequencies` (`freq_id_code`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=204879 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publications`
--

DROP TABLE IF EXISTS `publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publications` (
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ISSN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OCLC` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marc001` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `pub_title_alt` text COLLATE utf8_unicode_ci,
  `pub_city` text COLLATE utf8_unicode_ci,
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_bgnDate` text COLLATE utf8_unicode_ci,
  `pub_endDate` text COLLATE utf8_unicode_ci,
  `date260C` text COLLATE utf8_unicode_ci,
  `date362` text COLLATE utf8_unicode_ci,
  `freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frequency310` text COLLATE utf8_unicode_ci,
  `former_freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `formerFrequency321` text COLLATE utf8_unicode_ci,
  `language_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'und',
  `numberingNote515` text COLLATE utf8_unicode_ci,
  `summary520` text COLLATE utf8_unicode_ci,
  `descriptionNote588` text COLLATE utf8_unicode_ci,
  `bib_relationships` text COLLATE utf8_unicode_ci,
  `link856` text COLLATE utf8_unicode_ci,
  `pub_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`pub_id`),
  KEY `marc001` (`marc001`),
  KEY `OCLC` (`OCLC`),
  KEY `ISSN` (`ISSN`),
  KEY `country_id` (`country_id`),
  KEY `freq_id_code` (`freq_id_code`),
  KEY `former_freq_id_code` (`former_freq_id_code`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `publications_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE,
  CONSTRAINT `publications_ibfk_2` FOREIGN KEY (`freq_id_code`) REFERENCES `frequencies` (`freq_id_code`) ON UPDATE CASCADE,
  CONSTRAINT `publications_ibfk_3` FOREIGN KEY (`former_freq_id_code`) REFERENCES `frequencies` (`freq_id_code`) ON UPDATE CASCADE,
  CONSTRAINT `publications_ibfk_4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publicationsIngestTest`
--

DROP TABLE IF EXISTS `publicationsIngestTest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publicationsIngestTest` (
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ISSN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OCLC` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marc001` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `pub_title_alt` text COLLATE utf8_unicode_ci,
  `pub_city` text COLLATE utf8_unicode_ci,
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_bgnDate` text COLLATE utf8_unicode_ci,
  `pub_endDate` text COLLATE utf8_unicode_ci,
  `date260C` text COLLATE utf8_unicode_ci,
  `date362` text COLLATE utf8_unicode_ci,
  `freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frequency310` text COLLATE utf8_unicode_ci,
  `former_freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `formerFrequency321` text COLLATE utf8_unicode_ci,
  `language_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'und',
  `numberingNote515` text COLLATE utf8_unicode_ci,
  `summary520` text COLLATE utf8_unicode_ci,
  `descriptionNote588` text COLLATE utf8_unicode_ci,
  `bib_relationships` text COLLATE utf8_unicode_ci,
  `link856` text COLLATE utf8_unicode_ci,
  `pub_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`pub_id`),
  KEY `marc001` (`marc001`),
  KEY `OCLC` (`OCLC`),
  KEY `ISSN` (`ISSN`),
  KEY `country_id` (`country_id`),
  KEY `freq_id_code` (`freq_id_code`),
  KEY `former_freq_id_code` (`former_freq_id_code`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `pIT_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE,
  CONSTRAINT `pIT_ibfk_2` FOREIGN KEY (`freq_id_code`) REFERENCES `frequencies` (`freq_id_code`) ON UPDATE CASCADE,
  CONSTRAINT `pIT_ibfk_3` FOREIGN KEY (`former_freq_id_code`) REFERENCES `frequencies` (`freq_id_code`) ON UPDATE CASCADE,
  CONSTRAINT `pIT_ibfk_4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_data`
--

DROP TABLE IF EXISTS `reference_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_data` (
  `ref_data_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_source_id` int(10) unsigned NOT NULL,
  `ref_data_title` text COLLATE utf8_unicode_ci,
  `ref_data_uri` text COLLATE utf8_unicode_ci,
  `ref_data_body` mediumtext COLLATE utf8_unicode_ci,
  `ref_data_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ref_data_id`),
  KEY `ref_source_id` (`ref_source_id`),
  CONSTRAINT `reference_data_ibfk_1` FOREIGN KEY (`ref_source_id`) REFERENCES `reference_sources` (`ref_source_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_linkage`
--

DROP TABLE IF EXISTS `reference_linkage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_linkage` (
  `ref_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_data_id` int(10) unsigned NOT NULL,
  `pub_id` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `b_showFullText` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ref_link_id`),
  KEY `ref_data_id` (`ref_data_id`),
  KEY `pub_id` (`pub_id`),
  CONSTRAINT `reference_linkage_ibfk_2` FOREIGN KEY (`ref_data_id`) REFERENCES `reference_data` (`ref_data_id`) ON UPDATE CASCADE,
  CONSTRAINT `reference_linkage_ibfk_3` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_sources`
--

DROP TABLE IF EXISTS `reference_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_sources` (
  `ref_source_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_source_title` mediumtext COLLATE utf8_unicode_ci,
  `ref_source_author` mediumtext COLLATE utf8_unicode_ci,
  `ref_source_publisher` mediumtext COLLATE utf8_unicode_ci,
  `ref_source_city` mediumtext COLLATE utf8_unicode_ci,
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'xx',
  `ref_source_uri` text COLLATE utf8_unicode_ci,
  `ref_source_update_date` date DEFAULT NULL,
  `ref_source_note` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ref_source_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `reference_sources_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reproductions`
--

DROP TABLE IF EXISTS `reproductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reproductions` (
  `reproduction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `reproducer_org_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reproduction_date_produced` text COLLATE utf8_unicode_ci,
  `reproduction_description` text COLLATE utf8_unicode_ci,
  `reproduction_series` text COLLATE utf8_unicode_ci,
  `reproduction_datesVols` text COLLATE utf8_unicode_ci,
  `reproduction_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`reproduction_id`),
  KEY `reproduction_id` (`reproduction_id`),
  KEY `reproducer_id` (`reproducer_org_id`),
  KEY `format_id` (`format_id`),
  CONSTRAINT `reproductions_ibfk_1` FOREIGN KEY (`reproducer_org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `rprdn_fmat_ibfk` FOREIGN KEY (`format_id`) REFERENCES `formats` (`format_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semiweeklyCheckerboardArrestees`
--

DROP TABLE IF EXISTS `semiweeklyCheckerboardArrestees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semiweeklyCheckerboardArrestees` (
  `issue_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `condition_id` tinyint(3) unsigned DEFAULT NULL,
  `format` text COLLATE utf8_unicode_ci,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `archive_status_id` tinyint(3) unsigned DEFAULT NULL,
  `provenance_id` int(10) unsigned NOT NULL,
  `collection_id` smallint(5) unsigned DEFAULT '1',
  `update_date` date DEFAULT NULL,
  `issue_note` mediumtext COLLATE utf8_unicode_ci,
  `specificIssuesCreated` tinyint(1) DEFAULT '0',
  `specificIssuesCreatedDate` date DEFAULT '0000-00-00',
  PRIMARY KEY (`issue_id`),
  KEY `issue_id` (`issue_id`),
  KEY `repos_id` (`org_id`),
  KEY `issue_date` (`issue_date`),
  KEY `specificIssuesCreatedDate` (`specificIssuesCreatedDate`),
  KEY `pub_id` (`pub_id`),
  KEY `condition_id` (`condition_id`),
  KEY `format_id` (`format_id`),
  KEY `archive_status_id` (`archive_status_id`),
  KEY `provenance_id` (`provenance_id`),
  KEY `idx_pub_id_issue_date_repos_id` (`pub_id`,`issue_date`,`org_id`),
  KEY `pub_org` (`pub_id`,`org_id`),
  KEY `issue_collection_FK` (`collection_id`),
  KEY `pub_collection` (`pub_id`,`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111111947 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semiweeklyCheckerboardSuspects`
--

DROP TABLE IF EXISTS `semiweeklyCheckerboardSuspects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semiweeklyCheckerboardSuspects` (
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ISSN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OCLC` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marc001` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `pub_title_alt` text COLLATE utf8_unicode_ci,
  `pub_city` text COLLATE utf8_unicode_ci,
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_bgnDate` text COLLATE utf8_unicode_ci,
  `pub_endDate` text COLLATE utf8_unicode_ci,
  `date260C` text COLLATE utf8_unicode_ci,
  `date362` text COLLATE utf8_unicode_ci,
  `freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frequency310` text COLLATE utf8_unicode_ci,
  `former_freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `formerFrequency321` text COLLATE utf8_unicode_ci,
  `language_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'und',
  `numberingNote515` text COLLATE utf8_unicode_ci,
  `summary520` text COLLATE utf8_unicode_ci,
  `descriptionNote588` text COLLATE utf8_unicode_ci,
  `bib_relationships` text COLLATE utf8_unicode_ci,
  `link856` text COLLATE utf8_unicode_ci,
  `pub_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`pub_id`),
  KEY `marc001` (`marc001`),
  KEY `OCLC` (`OCLC`),
  KEY `ISSN` (`ISSN`),
  KEY `country_id` (`country_id`),
  KEY `freq_id_code` (`freq_id_code`),
  KEY `former_freq_id_code` (`former_freq_id_code`),
  KEY `idx_pub_id_country_id` (`pub_id`,`country_id`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `triweeklyCheckerboardArrestees`
--

DROP TABLE IF EXISTS `triweeklyCheckerboardArrestees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triweeklyCheckerboardArrestees` (
  `issue_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `condition_id` tinyint(3) unsigned DEFAULT NULL,
  `format` text COLLATE utf8_unicode_ci,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `archive_status_id` tinyint(3) unsigned DEFAULT NULL,
  `provenance_id` int(10) unsigned NOT NULL,
  `collection_id` smallint(5) unsigned DEFAULT '1',
  `update_date` date DEFAULT NULL,
  `issue_note` mediumtext COLLATE utf8_unicode_ci,
  `specificIssuesCreated` tinyint(1) DEFAULT '0',
  `specificIssuesCreatedDate` date DEFAULT '0000-00-00',
  PRIMARY KEY (`issue_id`),
  KEY `issue_id` (`issue_id`),
  KEY `repos_id` (`org_id`),
  KEY `issue_date` (`issue_date`),
  KEY `specificIssuesCreatedDate` (`specificIssuesCreatedDate`),
  KEY `pub_id` (`pub_id`),
  KEY `condition_id` (`condition_id`),
  KEY `format_id` (`format_id`),
  KEY `archive_status_id` (`archive_status_id`),
  KEY `provenance_id` (`provenance_id`),
  KEY `idx_pub_id_issue_date_repos_id` (`pub_id`,`issue_date`,`org_id`),
  KEY `pub_org` (`pub_id`,`org_id`),
  KEY `issue_collection_FK` (`collection_id`),
  KEY `pub_collection` (`pub_id`,`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97783392 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `triweeklyCheckerboardSuspects`
--

DROP TABLE IF EXISTS `triweeklyCheckerboardSuspects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triweeklyCheckerboardSuspects` (
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ISSN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OCLC` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marc001` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_title` text COLLATE utf8_unicode_ci,
  `pub_title_alt` text COLLATE utf8_unicode_ci,
  `pub_city` text COLLATE utf8_unicode_ci,
  `country_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pub_bgnDate` text COLLATE utf8_unicode_ci,
  `pub_endDate` text COLLATE utf8_unicode_ci,
  `date260C` text COLLATE utf8_unicode_ci,
  `date362` text COLLATE utf8_unicode_ci,
  `freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frequency310` text COLLATE utf8_unicode_ci,
  `former_freq_id_code` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `formerFrequency321` text COLLATE utf8_unicode_ci,
  `language_id` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'und',
  `numberingNote515` text COLLATE utf8_unicode_ci,
  `summary520` text COLLATE utf8_unicode_ci,
  `descriptionNote588` text COLLATE utf8_unicode_ci,
  `bib_relationships` text COLLATE utf8_unicode_ci,
  `link856` text COLLATE utf8_unicode_ci,
  `pub_note` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`pub_id`),
  KEY `marc001` (`marc001`),
  KEY `OCLC` (`OCLC`),
  KEY `ISSN` (`ISSN`),
  KEY `country_id` (`country_id`),
  KEY `freq_id_code` (`freq_id_code`),
  KEY `former_freq_id_code` (`former_freq_id_code`),
  KEY `idx_pub_id_country_id` (`pub_id`,`country_id`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zerodate_issues`
--

DROP TABLE IF EXISTS `zerodate_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zerodate_issues` (
  `zerodate_issue_id` int(10) NOT NULL AUTO_INCREMENT,
  `pub_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `issue_date` date DEFAULT NULL,
  `rawIssueData` mediumtext COLLATE utf8_unicode_ci,
  `org_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `condition_id` tinyint(3) unsigned DEFAULT NULL,
  `format` text COLLATE utf8_unicode_ci,
  `format_id` tinyint(3) unsigned DEFAULT NULL,
  `archive_status_id` tinyint(3) unsigned DEFAULT NULL,
  `provenance_id` int(10) unsigned NOT NULL,
  `collection_id` smallint(5) unsigned DEFAULT '1',
  `update_date` date DEFAULT NULL,
  `issue_note` mediumtext COLLATE utf8_unicode_ci,
  `specificIssuesCreated` tinyint(1) DEFAULT '0',
  `specificIssuesCreatedDate` date DEFAULT '0000-00-00',
  PRIMARY KEY (`zerodate_issue_id`),
  KEY `zd_issue_id_original` (`zerodate_issue_id`),
  KEY `org_id` (`org_id`),
  KEY `issue_date` (`issue_date`),
  KEY `specificIssuesCreatedDate` (`specificIssuesCreatedDate`),
  KEY `condition_id` (`condition_id`),
  KEY `format_id` (`format_id`),
  KEY `archive_status_id` (`archive_status_id`),
  KEY `pub_date` (`pub_id`,`issue_date`),
  KEY `pub_format` (`pub_id`,`format_id`),
  KEY `date_format` (`issue_date`,`format_id`),
  KEY `zd_issues_ibfk_6` (`provenance_id`),
  KEY `zd_issue_collection_FK` (`collection_id`),
  KEY `pub_collection` (`pub_id`,`collection_id`),
  KEY `pub_org` (`pub_id`,`org_id`),
  CONSTRAINT `zd_issues_ibfk_2` FOREIGN KEY (`pub_id`) REFERENCES `publications` (`pub_id`) ON UPDATE CASCADE,
  CONSTRAINT `zd_issues_ibfk_3` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON UPDATE CASCADE,
  CONSTRAINT `zd_issues_ibfk_4` FOREIGN KEY (`format_id`) REFERENCES `formats` (`format_id`) ON UPDATE CASCADE,
  CONSTRAINT `zd_issues_ibfk_5` FOREIGN KEY (`archive_status_id`) REFERENCES `archive_status` (`archive_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `zd_issues_ibfk_6` FOREIGN KEY (`provenance_id`) REFERENCES `provenances` (`provenance_id`) ON UPDATE CASCADE,
  CONSTRAINT `zd_issues_ibfk_7` FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`) ON UPDATE CASCADE,
  CONSTRAINT `zd_issue_collection_FK` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`collection_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111215134 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'icondata'
--

--
-- Dumping routines for database 'icondata'
--
/*!50003 DROP PROCEDURE IF EXISTS `A1issues_per_publication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `A1issues_per_publication`(
	IN pub_id TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;	DECLARE issue_count_valid	INT;

    DECLARE MINissue_date	DATE;	DECLARE MINVALIDissue_date	DATE;
    DECLARE MAXissue_date	DATE;	DECLARE MAXVALIDissue_date	DATE;

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('A1issues_per_publication ', pub_id, '; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET outputTableName = 'A1issues_per_publication';
	SET table_name 	= CONCAT('A1issues_per_publication_', pub_id);

		/* uniform_title needs to be set just once:
			since B2 is interested in the title level, here we'll generate a uniform title with geographical and date information
		*/
	CALL build_uniform_title( pub_id, @uniform_title );

	SET insertClause = CONCAT('INSERT INTO ', outputTableName, '( pub_id, pub_title, ');
	SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_valid, issue_count_distinct, ');
	SET insertClause = CONCAT(insertClause, 'MINissue_date, MINVALIDissue_date, ');
	SET insertClause = CONCAT(insertClause, 'MAXissue_date, MAXVALIDissue_date, ');
	SET insertClause = CONCAT(insertClause, 'format_count_distinct, 1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
	SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
	SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
	SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');

	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', table_name, ' AS ( SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' );');
    SELECT @thisSQL AS createViewSQL;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ': CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */
	/* now the view exists, its name is in the variable 'table_name' we use table_name as we used the temporary table name in the first version */


	/* fill the values to be inserted in the output table */

    		/* how many TOTAL ISSUES for this title? */
	SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @issue_count_total FROM ', table_name, ';');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: SELECT COUNT(*) INTO @issue_count_total = ', CAST(@issue_count_total AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;

	IF @issue_count_total > 0 THEN

			/* how many VALID ISSUE DATES for this title?
            NON-ZERO dates */
        /* 2015-05-15 all issue_dates are valid now     
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @issue_count_valid FROM ', table_name, ' ');
        SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date <> \'0000-00-00\';'); 
		SELECT @thisSQL AS valid_dateSQL;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: SELECT COUNT(*) INTO @issue_count_valid = ', CAST(@issue_count_valid AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;
        */
        /* 2015-05-15 all issue_dates are valid now , SO */
        SET @issue_count_valid = @issue_count_total;

			/* how many DISTINCT ISSUE DATES for this title?
            includes Zero dates */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct FROM ', table_name, ';');
		SELECT @thisSQL AS distdateSQL;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; */


			/* MIN-MAX issue_date fields: for each one, first get the very MIN/MAX,
				then the NON-ZERO, VALID DATE MIN/MAX */
		SET @thisSQL = CONCAT('SELECT MIN(issue_date) INTO @MINissue_date FROM ', table_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: MIN ', CAST(@MINissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

			/* trouble arises when only ZERO dates for a title
				SO 2 IF clauses below to set the MIN/MAX in those cases: */
		/* SET @thisSQL = CONCAT('SELECT MIN(issue_date) INTO @MINVALIDissue_date FROM ', table_name, ' ');
		SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date <> \'0000-00-00\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: MINVALID ', CAST(@MINVALIDissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		IF @MINVALIDissue_date IS NULL THEN
			SELECT 'NO VALID MIN DATE' AS MINS_INVALIDSonly;
			SET @MINVALIDissue_date = '0000-00-00';
		END IF;
		*/
		SET @MINVALIDissue_date = @MINissue_date;

		SET @thisSQL = CONCAT('SELECT MAX(issue_date) INTO @MAXissue_date FROM ', table_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: MAX ', CAST(@MAXissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;
		
        /* 
		SET @thisSQL = CONCAT('SELECT MAX(issue_date) INTO @MAXVALIDissue_date FROM ', table_name, ' ');
		SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date <> \'0000-00-00\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: MAXVALID ', CAST(@MAXVALIDissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		IF @MAXVALIDissue_date IS NULL THEN
			SELECT 'NO VALID MAX DATE' AS MINS_INVALIDSonly;
			SET @MAXVALIDissue_date = '0000-00-00';
		END IF;
		*/
        SET @MAXVALIDissue_date = @MAXissue_date;


		/* done with issue_date fields */

			/* how many distinct FORMATS for this pub_id? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM ', table_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		/* get the number of issues in each format for this pub_id */
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);
		/* END FORMATS */
	ELSE /* no issues */
		SET @issue_count_distinct = 0;
        SET @MINissue_date = '0000-00-00';	SET @MINVALIDissue_date = '0000-00-00';
        SET @MAXissue_date = '0000-00-00';	SET @MAXVALIDissue_date = '0000-00-00';
        SET @format_count_distinct = 0;
		SET @format_count_1 = 0;		SET @format_count_2 = 0;		SET @format_count_3 = 0;
		SET @format_count_4 = 0;		SET @format_count_5 = 0;		SET @format_count_6 = 0;
		SET @format_count_7 = 0;		SET @format_count_8 = 0;		SET @format_count_9 = 0;
		SET @format_count_10 = 0;		SET @format_count_11 = 0;		SET @format_count_12 = 0;
		SET @format_count_13 = 0;		SET @format_count_14 = 0;		SET @format_count_15 = 0;
    END IF;



    /* before INSERT, DELETE OLD from outputTableName */
	SET @thisSQL = CONCAT('DELETE FROM ', outputTableName ,' WHERE pub_id="', pub_id, '"');
	SELECT @thisSQL AS CLEAN_outputTableName_SQL;
  SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;


	/* perform the INSERT */
	SET @thisSQL = CONCAT(insertClause, ' (\'', pub_id, '\', "', @uniform_title, '", ');
	SET @thisSQL = CONCAT(@thisSQL, @issue_count_total,  ', ', @issue_count_valid, ', ', @issue_count_distinct, ', ');
	SET @thisSQL = CONCAT(@thisSQL, "'", CAST(@MINissue_date AS CHAR), "', '", CAST(@MINVALIDissue_date AS CHAR), "', ");
	SET @thisSQL = CONCAT(@thisSQL, "'", CAST(@MAXissue_date AS CHAR), "', '", CAST(@MAXVALIDissue_date AS CHAR), "', ");
	SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
							@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
							@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
							@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
							@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
							@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
	SET @thisSQL = CONCAT(@thisSQL, ');');
	SELECT CAST(@thisSQL AS CHAR) AS A1issues_per_publication_INSERT;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ' A1issues_per_publication: INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

	/* release resources and exit */
    /* SELECT 'NOT DROPPING JUNK VIEW DURING DEV' AS warning; */
	SET @thisSQL = CONCAT('DROP VIEW ', table_name, ';');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `A2issues_per_organization` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `A2issues_per_organization`(
	IN pub_id TEXT
)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('A2issues_per_organization ', pub_id, '; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET outputTableName = 'A2issues_per_organization';
	SET table_name 	= CONCAT('A2issues_per_organization_', pub_id);
	SELECT table_name AS A2_table_name;

		/* uniform_title needs to be set just once:
			since B2 is interested in the title level, here we'll generate a uniform title with geographical and date information
		*/
	CALL build_uniform_title( pub_id, @uniform_title );
	SELECT @uniform_title AS have_uniform_title; 

    /* before INSERT, DELETE OLD from outputTableName */
	SET @thisSQL = CONCAT('DELETE FROM ', outputTableName ,' WHERE pub_id="', pub_id, '"');
	SELECT @thisSQL AS CLEAN_outputTableName_SQL;
  SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;



	SET @thisSQL = CONCAT('INSERT ', outputTableName, ' ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT 0 AS A2_id, ');
	SET @thisSQL = CONCAT(@thisSQL, 'COUNT(*) AS num_issues, ');
	SET @thisSQL = CONCAT(@thisSQL, 'org_id, pub_id ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM issues  ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', pub_id, '\' ');
    /* SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' '); /* new for v.2 ; rescinded 2016-05-15 */
	SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY org_id HAVING COUNT(*) > 0 ');

	SELECT CAST(@thisSQL AS CHAR) AS A2issues_per_organization_INSERT;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ': INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer; 

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `advanceIssueDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `advanceIssueDate`(
    IN myFreqID TINYTEXT,
    IN prevIssueDate DATE,
    INOUT thisIssueDate DATE
)
BEGIN
	DECLARE strDebugAdvIssDate TEXT;
	SET strDebugAdvIssDate = CONCAT("advanceIssueDate rcvd prevIssueDate=", prevIssueDate, "; ");

	CASE myFreqID
		WHEN "d" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 1 DAY ) INTO thisIssueDate;
		WHEN "i" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 2 DAY ) INTO thisIssueDate;
		WHEN "c" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 3 DAY ) INTO thisIssueDate;
		WHEN "w" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 7 DAY ) INTO thisIssueDate;
		WHEN "j" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 10 DAY ) INTO thisIssueDate;
		WHEN "e" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 2 WEEK ) INTO thisIssueDate;
		WHEN "s" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 2 WEEK ) INTO thisIssueDate;
		WHEN "m" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 1 MONTH ) INTO thisIssueDate;
		WHEN "b" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 2 MONTH ) INTO thisIssueDate;
		WHEN "q" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 3 MONTH ) INTO thisIssueDate;
		WHEN "t" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 4 MONTH ) INTO thisIssueDate;
		WHEN "f" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 6 MONTH ) INTO thisIssueDate;
		WHEN "a" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 1 YEAR )  INTO thisIssueDate;
		WHEN "g" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 2 YEAR )  INTO thisIssueDate;
		WHEN "h" THEN SELECT DATE_ADD( prevIssueDate, INTERVAL 3 YEAR )  INTO thisIssueDate;
		ELSE SET thisIssueDate = '0000-00-00';
	END CASE;

SET strDebugAdvIssDate = CONCAT(strDebugAdvIssDate, " and has set thisIssueDate=", thisIssueDate);


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B1country_issues_per_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B1country_issues_per_year`(
	IN country_id TEXT,
	IN begin_year TEXT,
    IN end_year TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE issues_view	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE country_name 		TEXT;
    DECLARE publications_count	INT;
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('B1country_issues_per_year ', country_id, ', ', begin_year, '-', end_year,' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET outputTableName = 'B1country_issues_per_year';
	SET issues_view 	= CONCAT('B1country_issues_per_year_', country_id);

		/* begin_date and end_date will have their values modified on every pass through the loop below:
			here, we want to use them to create a VIEW of the issues records between them */
	SET begin_date 	= CAST( CONCAT(begin_year, '-01-01') AS DATE); /* SELECT begin_date; */
    SET end_date 	= CAST( CONCAT(end_year, '-12-31') AS DATE); /* SELECT end_date; */
	/*******************************
    this is where the CREATE OR REPLACE VIEW was located until version 7: now it's in the loop
    *******************************/

		/* country_name needs to be set just once */
    SET @thisSQL = CONCAT('SELECT country_name INTO @country_name FROM countries WHERE country_id = \'', country_id, '\';');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT country_name INTO ', @country_name, ', ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

/*
	SET insertClause = 'INSERT INTO B1country_issues_per_year_output( country_id, country_name, issue_year, numIssues, numPublications, ';
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, 6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, 11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, 15_Digital_tiff ) VALUES ');
*/
	SET insertClause = CONCAT('INSERT INTO ', outputTableName, '( country_id, country_name, issue_year, ');
    SET insertClause = CONCAT(insertClause, 'publications_count, issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, 1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');




		/* tried dynamically picking begin and end dates: adds a long time to query but code is in: p2_B1_issues_per_year_format_dynamic_date_snippet.sql */
    SET this_year = CAST(begin_year AS UNSIGNED);
    SET last_date = CAST( CONCAT(end_year, '-12-31') AS DATE);
    /* SELECT CONCAT('last_date = ', CAST(last_date AS CHAR)) AS showing_last_date; */
    insertionLoop: LOOP
		SET begin_date 	= CAST( CONCAT(this_year, '-01-01') AS DATE);
		SET end_date 	= CAST( CONCAT(this_year, '-12-31') AS DATE);
        SET messagePrefix = CONCAT(@country_name, ' ', CAST(this_year AS CHAR), ': ');

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', issues_view, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id IN ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT pub_id FROM publications WHERE country_id = \'', country_id ,'\' ) ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        /* SET @thisSQL = CONCAT(@thisSQL, ') ORDER BY pub_id  ;'); */
        SET @thisSQL = CONCAT(@thisSQL, ') ;');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(messagePrefix, 'CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;
		/* now the view exists, its name is in the variable 'issues_view' we use issues_view as we used the temporary table name in the first version */

		/* fill the values to be inserted in the output table */
        /* see file B1country_issues_per_year_testing_time_notes.sql for extended comments
			about how slow it was to look up the total number of issues and some of the strategies.
			- Total number of issues is the same as the sum of all the formats, so @issue_count will be set after the formats
		*/


			/* how many PUBLICATIONS for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', issues_view,'.pub_id ) INTO @publications_count FROM ', issues_view, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT pub_id) INTO @publications_count = ', @publications_count, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer;


IF @publications_count > 0 THEN

			/* how many distinct FORMATS for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', issues_view,'.format_id ) INTO @format_count_distinct FROM ', issues_view, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer;




		/* get the number of issues in each format for this year */
		CALL get_format_count_for_country( country_id, begin_date, end_date, 1, @format_count_1);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 2, @format_count_2);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 3, @format_count_3);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
		CALL get_format_count_for_country( country_id, begin_date, end_date, 5, @format_count_5);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 6, @format_count_6);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 7, @format_count_7);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
		CALL get_format_count_for_country( country_id, begin_date, end_date, 9, @format_count_9);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 10, @format_count_10);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 11, @format_count_11);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 12, @format_count_12);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 13, @format_count_13);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 14, @format_count_14);
		CALL get_format_count_for_country( country_id, begin_date, end_date, 15, @format_count_15);

		/*
		END FORMATS
		TOTAL NUMBER OF ISSUES IN THE YEAR? is the same as the total of all the formats, so:  */
		SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;

			/* how many distinct ISSUES for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', issues_view,'.issue_date ) INTO @issue_count_distinct FROM ', issues_view, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', @issue_count_distinct, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer;

ELSE /* @publications_count was 0 : fill the variables */
    SET issue_count_total = 0; 	SET @issue_count_distinct = 0; 	SET @format_count_distinct = 0;
    SET @format_count_1 = 0;	SET @format_count_2 = 0;		SET @format_count_3 = 0;
    SET @format_count_4 = 0;	SET @format_count_5 = 0;		SET @format_count_6 = 0;
    SET @format_count_7 = 0;	SET @format_count_8 = 0;		SET @format_count_9 = 0;
    SET @format_count_10 = 0;	SET @format_count_11 = 0;		SET @format_count_12 = 0;
    SET @format_count_13 = 0;	SET @format_count_14 = 0;		SET @format_count_15 = 0;
END IF;

		/* perform the INSERT */
		SET @thisSQL = CONCAT(insertClause, ' (\'', country_id, '\', "', @country_name, '", ',  CAST(this_year AS CHAR), ', ');
        SET @thisSQL = CONCAT(@thisSQL, @publications_count, ', ', issue_count_total, ', ', @issue_count_distinct, ', ');
        SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
								@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
								@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
                                @format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
                                @format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
                                @format_count_13, ', ', @format_count_14, ', ', @format_count_15);
		SET @thisSQL = CONCAT(@thisSQL, ');');
		/* SELECT CAST(@thisSQL AS CHAR) AS B1country_issues_per_year_INSERT; */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer; */

		IF CAST(CONCAT(this_year, '-12-31') AS DATE) <> last_date THEN
			SET this_year = this_year + 1; /* advance the year for next pass */
			ITERATE insertionLoop;
		END IF;
		SET strDebug = CONCAT('skipped IF with this_year=', CAST(this_year AS CHAR), ', next is LEAVE');
		/* SELECT strDebug; */
		LEAVE  insertionLoop;
    END LOOP insertionLoop;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', issues_view, ';');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2Apublication_zerodate_issues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B2Apublication_zerodate_issues`(
	IN pub_id TEXT,
    IN boolSendToOutfile TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('B2Apublication_zerodate_issues ', pub_id, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	CALL build_uniform_title( pub_id, @uniform_title );
    SET outfileName = CONCAT('/home/mysql/tmp/B2Apublication_zerodate_issues_', pub_id, '.csv');

  SET @thisSQL = 'SELECT IONE.pub_id, @uniform_title, ';
  SET @thisSQL = CONCAT(@thisSQL, 'COUNT(DISTINCT ITWO.issue_id) AS num_total_issues, ');
  SET @thisSQL = CONCAT(@thisSQL, 'COUNT(DISTINCT ITWO.issue_date) AS num_distinct_issue_dates, ');
  SET @thisSQL = CONCAT(@thisSQL, 'COUNT(DISTINCT ITWO.issue_id) - COUNT(DISTINCT IONE.issue_date) AS num_valid_issue_dates, ');
  SET @thisSQL = CONCAT(@thisSQL, '((COUNT(DISTINCT ITWO.issue_date) - COUNT(DISTINCT IONE.issue_date)) * 100) DIV COUNT(DISTINCT ITWO.issue_id) AS pct_of_issues_valid_dates, ');
  SET @thisSQL = CONCAT(@thisSQL, 'COUNT(DISTINCT IONE.issue_id) AS num_zerodate_issue_dates, ');
  SET @thisSQL = CONCAT(@thisSQL, '((COUNT(DISTINCT IONE.issue_id) * 100) DIV COUNT(DISTINCT ITWO.issue_id)) AS pct_of_issues_zerodates ');
  SET @thisSQL = CONCAT(@thisSQL, 'FROM issues IONE ');
  SET @thisSQL = CONCAT(@thisSQL, 'INNER JOIN issues ITWO ON ITWO.pub_id = IONE.pub_id ');
  SET @thisSQL = CONCAT(@thisSQL, 'WHERE IONE.issue_date = \'0000-00-00\' ');
  SET @thisSQL = CONCAT(@thisSQL, 'AND IONE.pub_id = "', pub_id, '" '); 
  SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY IONE.pub_id ');
	/* SELECT @thisSQL AS step1; */

	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;


/* sometimes results to outfile */
IF boolSendToOutfile = 'outfile' THEN
	SET @thisSQL = CONCAT(@thisSQL, 'INTO OUTFILE \'', outfileName, '\' CHARACTER SET utf8 FIELDS TERMINATED BY \'|\' LINES TERMINATED BY \'\\n\'');
    /* SELECT @thisSQL AS next_is_outfile; */
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    /*
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('OUTFILE FROM', pub_id, '. ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
    */
	SELECT CONCAT('outfile: ', outfileName, ' completed; exiting.\n');
ELSE	
	/* sometimes results to screen */
    SELECT @thisSQL AS next_is_results_to_screen;
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    /*
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT FROM', pub_id, ': ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
    */
END IF;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2move_build_calls_SW_checkerboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B2move_build_calls_SW_checkerboard`(
    IN boolSendToOutfile TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE loop_ticker INT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE str_where_pub_and_org_clause TEXT; /* SQL WHERE */
    DECLARE str_call_statement_clause TEXT;
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
	DECLARE outfileName	TEXT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

	/* dates from the view, issues which exist */
	DECLARE first_issue_date DATE; 	DECLARE this_issue_date DATE; 	DECLARE next_issue_date DATE; DECLARE last_issue_date DATE;
	DECLARE max_date_with_bad_dayname date;
	/* dates which, if present in the view, indicate likely checkerboard :
			- they are on a DAYNAME() that is not VALID_DATESTEP (3 for semiweekly ????? ) after DAYNAME(first_issue_date)
		*/
	DECLARE checkerboard_candi_date DATE;
	DECLARE checkerboard_increment INT; /* number of days from first_issue_date that might indicate a checkerboard pattern  */
	DECLARE num_days_to_move INT; /* number of days, positive or negative, to move this issue to be on a correct day: parameter for B2move_issues_to_other_weekday */

	DECLARE int_checkerboard_flag INT; /* should we suspect this title of being a checkerboard ? */
	DECLARE int_insertion_flag INT; /* did we already add this pub_id to the list of suspects? */

	DECLARE this_pub_id TEXT; /* filled by cursor */
    DECLARE this_org_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR
	SELECT pub_id FROM semiweeklyCheckerboardCandidatePUBS;

	DECLARE org_issues_cursor CURSOR FOR
	SELECT DISTINCT org_id FROM semiweeklyCheckerboardCandidateISS WHERE pub_id = this_pub_id COLLATE utf8_unicode_ci;


/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('B2move_build_calls_SW_checkerboard("', boolSendToOutfile, '" \'); from ', CAST(totalExecutionBegin AS CHAR), '\n');
/*  SET outfileName = CONCAT('/home/mysql/tmp/B2move_build_calls_SW_checkerboard_', boolSendToOutfile, '.csv');
    SET outfileName = CONCAT('/home/mysql/tmp/B2move_build_calls_SW_checkerboard_', this_pub_id, '.csv'); */
SET outfileName = CONCAT('B2move_build_calls_SW_checkerboard_', boolSendToOutfile, '.csv');


	SET checkerboard_increment = 6;

    /* see file: create_semiweeklyCheckerboardSuspects.sql
    	- SUSPECTS are publication-level
    	- ARRESTEES as issue-level
     */
	SET @thisSQL = 'DELETE FROM semiweeklyCheckerboardSuspects WHERE 1 > 0';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('Clean semiweeklyCheckerboardSuspects: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS semiweeklyCheckerboardSuspects_Cleaned;
    /* empty junk table exists, loop will fill it with PUBLICATIONS records (copies) and save stuff in pub_note, numberingNote515 etc. */

    /* see file: semiweeklyCheckerboardArrestees.sql
    	- ARRESTEES as issue-level
    	- SUSPECTS are publication-level
    */
	SET @thisSQL = 'DELETE FROM semiweeklyCheckerboardArrestees WHERE 1 > 0';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('Clean semiweeklyCheckerboardArrestees: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS semiweeklyCheckerboardArrestees_Cleaned;
    /* empty junk table exists, loop will fill it with ISSUES records (copies) and save stuff in issue_note, etc. */


/* create a view of SEMIWEEKLY publications */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW semiweeklyCheckerboardCandidatePUBS AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM publications ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE freq_id_code IN ("c","c+SY","c17","c36") ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY pub_title, pub_bgnDate, pub_endDate );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS pubsview;
	/* now the view exists, main SELECT SQL will use it in JOIN  */

/* create a view of ISSUES from SEMIWEEKLY publications */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW semiweeklyCheckerboardCandidateISS AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id IN (SELECT pub_id FROM semiweeklyCheckerboardCandidatePUBS) ');
  SET @thisSQL = CONCAT(@thisSQL, 'AND org_id NOT IN ("AQM", "FLNEW", "MITGS", "PQHN") ');
  /* above: exclude issues from vendors 2016-06-13 */
	SET @thisSQL = CONCAT(@thisSQL, ' );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS issview;
	/* now the view exists, main SELECT SQL will use it in JOIN  */

/* build main SELECT SQL */
SET @thisSQL = 'SELECT DISTINCT DAYNAME(I.issue_date) as dayname, ';
SET @thisSQL = CONCAT(@thisSQL, 'MIN(I.issue_date) AS org_first_issue, MAX(I.issue_date) AS org_last_issue, COUNT(*) AS issues_this_org_this_date_range_this_dayname, ');
SET @thisSQL = CONCAT(@thisSQL, 'I.org_id, O.org_name, ');
SET @thisSQL = CONCAT(@thisSQL, 'P.pub_id, P.pub_title, P.freq_id_code, P.frequency310, P.former_freq_id_code, P.formerFrequency321 ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM `icondata`.`semiweeklyCheckerboardCandidateISS` I ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`semiweeklyCheckerboardCandidatePUBS` P ON P.pub_id = I.pub_id ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`organizations` O ON O.org_id = I.org_id ');
/* SET @thisSQL = CONCAT(@thisSQL, 'WHERE 1=1 '); */
SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY P.pub_id, DAYOFWEEK(I.issue_date), I.org_id ');  /* # good, retain */
SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY org_first_issue, org_last_issue ');
SELECT @thisSQL AS B2move_build_calls_SW_checkerboardSQL;

SET loop_ticker = 1;
SET end_recordset = 0;
SET @next_issue_date = '0000-00-00'; /* 2016-06-14 13:01:52 unused in this version */

	/* SELECT CONCAT("CKB_TW: entered if org_pubs_count with ", @org_pubs_count, ", and loop_ticker = ", CAST(loop_ticker AS CHAR)) AS CKB_TWif_org_pubs_count;    */
OPEN pubs_cursor;
	/* SELECT CONCAT("CKB_TW: opened pubs_cursor") AS CKB_TWopened_pub_cursor; */
	pubs_cursor_loop: WHILE end_recordset = 0 DO
		/* SELECT CONCAT("CKB_TW: into pubs_cursor_loop") AS CKB_TWpubs_cursor_loop;  */
		FETCH pubs_cursor INTO this_pub_id;
		/* SELECT CONCAT("CKB_TW: this_pub_id = ", this_pub_id) AS CKB_TWfetched_pub_cursor;   */

		IF end_recordset THEN
			SELECT 'End of PUBS recordset' AS endRecsMsg;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
			/* CLOSE pubs_cursor; # outside loop end */
		END IF;

		CALL get_issue_MINMAX_for_pub(this_pub_id, @first_issue_date, @last_issue_date); /* fill some date variables */

		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @pub_issue_count FROM semiweeklyCheckerboardCandidateISS WHERE pub_id = \'', this_pub_id, '\';');
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SELECT CONCAT(' pub_issue_count: ', CAST(@pub_issue_count AS CHAR), ' issues') AS num_iss_for_pub;

/* IF @pub_issue_count > 3 THEN /* 3 for semiweekly ????? , change to a var later... */
IF @pub_issue_count > 50 THEN /* 50 for convenience check ; 
reduced number of titles 252 to 164 ; then back to 201 once changed checkerboard_increment if block below ca. 350
... 
*/

	/* if checkerboard_candi_date is present...
	starting from first_issue_date, when looking at the PUB level	*/
	SET @thisSQL = CONCAT('SELECT ADDDATE(@first_issue_date, ', CAST(checkerboard_increment AS CHAR), ') INTO @checkerboard_candi_date ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM issues LIMIT 1 '); 	/* or any table, just needs a FROM clause */
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	/*SELECT @thisSQL AS checkerboard_candi_date_top_SQL;*/
	SELECT @checkerboard_candi_date AS checkerboard_candi_date_top;

	/* number of issues at date suspected of being wrong if present */
	SET @thisSQL = 'SELECT COUNT(*) INTO @int_checkerboard_flag ';
  SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardCandidateISS ');
  SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', this_pub_id, '\' AND issue_date = \'', @checkerboard_candi_date, '\' ');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @int_checkerboard_flag AS int_checkerboard_flag_PUBlevel;

		IF @int_checkerboard_flag > 0 THEN /* insert this pub into SUSPECTS table, editing the pub_note field */
			/* works, retain
			SELECT this_pub_id, @first_issue_date AS first_issue_date,
				@checkerboard_candi_date AS checkerboard_candi_date, @last_issue_date AS last_issue_date,
				@int_checkerboard_flag AS int_checkerboard_flag;   */

			/* did we already flag this title ? */
			SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @int_insertion_flag ');
			SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardSuspects WHERE pub_id = \'', this_pub_id, '\' ');
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			SELECT @int_insertion_flag AS suspect_already_logged;

			IF @int_insertion_flag = 0 THEN
				SET @thisSQL = CONCAT('INSERT INTO semiweeklyCheckerboardSuspects ');
				SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM semiweeklyCheckerboardCandidatePUBS WHERE pub_id = \'', this_pub_id, '\' ');
				PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

				SET strDebug = CONCAT('first_issue_date \'', @first_issue_date, '\' checkerboard_candi_date = \'', @checkerboard_candi_date, '\' last_issue_date \'', @last_issue_date, ' ; ');
				SET strDebug = CONCAT(strDebug, 'on ', CAST(NOW() AS CHAR), ' ; int_checkerboard_flag = ', CAST(@int_checkerboard_flag AS CHAR), '.');
				/* SELECT strDebug AS new_pub_note_for_suspect; */

				SET @thisSQL = CONCAT('UPDATE semiweeklyCheckerboardSuspects ');
				SET @thisSQL = CONCAT(@thisSQL, 'SET pub_note = "', strDebug, '" WHERE pub_id = \'', this_pub_id, '\' ');
				/* SELECT @thisSQL AS UPDATE_pub_note_for_suspect; */
				PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

			/* finished with PUBS level here, the title is in the table of suspected checkerboards
				- now issues of that title
				- B2move_issues_to_other_weekday wants an org_id, so LOOP THROUGH ISSUES VIEW TO GET ORG_IDS */
				OPEN org_issues_cursor;
					org_issues_cursor_loop: WHILE end_recordset = 0 DO

						FETCH org_issues_cursor INTO this_org_id;

						IF end_recordset THEN
							SELECT 'End of ISS recordset' AS endRecsMsg;
							LEAVE org_issues_cursor_loop;
							/* CLOSE org_issues_cursor; # outside of loop end */
						END IF; /* org_issues_cursor */

						/* SELECT this_org_id AS just_plain_this_org_id;	*/

					/*
						first time through the issues, this_issue_date will be same as first_issue_date
						- from now on after get_issue_MINMAX_for_org:
							first_issue_date, this_issue_date, next_issue_date, checkerboard_candi_date, last_issue_date
							refer only to the set held by this ORG
					*/
					CALL get_issue_MINMAX_for_org(this_pub_id, this_org_id, @first_issue_date, @last_issue_date, @strDebug);
					SET @str_where_pub_and_org_clause = CONCAT('WHERE pub_id = \'', this_pub_id, '\' AND org_id = \'', this_org_id, '\' ');

					SET @thisSQL = CONCAT('SELECT \'', @first_issue_date, '\' INTO @this_issue_date ');
					SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardCandidateISS LIMIT 1 ');
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

					SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @num_iss_for_pub_and_org ');
				  SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
					/* SELECT @num_iss_for_pub_and_org; */

					/* if checkerboard_candi_date is present...
					starting from first_issue_date 	*/
					SET @thisSQL = CONCAT('SELECT ADDDATE(@first_issue_date, ', CAST(checkerboard_increment AS CHAR), ') INTO @checkerboard_candi_date ');
					SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardArrestees LIMIT 1 '); 	# or any table, just needs a FROM clause
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

					/* number of issues at date suspected of being checkerboard_candi_date if present */
					SET @thisSQL = 'SELECT COUNT(*) INTO @int_checkerboard_flag ';
					SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
					SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
					/* SELECT @thisSQL AS next_count_checkerboard_candi_date; */
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
					/* SELECT @int_checkerboard_flag AS int_checkerboard_flag_ISS_level; */

				/* 2016-06-10 08:25:41 */
# make this a while 2016-06-14 13:20:15
					IF @num_iss_for_pub_and_org > 5 THEN /* 3 for semiweekly ????? CHANGED TO 5, DEVNOTE make var */

						IF @int_checkerboard_flag > 0 THEN /* insert this issue into ARRESTEES table, editing the issue_note field */
							/* works, retain */
							SELECT this_pub_id, @this_issue_date AS this_issue_date,
								@checkerboard_candi_date AS checkerboard_candi_date, @last_issue_date AS last_issue_date,
								@int_checkerboard_flag AS int_checkerboard_flag, this_org_id;


  						/* did we already flag this PUB_ORG_DATE ? */
  						SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @int_insertion_flag ');
  						SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardArrestees ', @str_where_pub_and_org_clause);
  						SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
  						PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
  						/* SELECT @int_insertion_flag AS arrestee_already_logged;  */

						/* ISSUES: flag, insert, update */
							IF @int_insertion_flag = 0 THEN /* save this issue */
								org_issues_arrestees_insertion_loop:
								/*WHILE @checkerboard_candi_date <= ADDDATE(@first_issue_date, 12) 
								# don't do every beloved date of the title !  
								# but look at enough dates/weeks to get whole pattern */
								WHILE @checkerboard_candi_date <= ADDDATE(@first_issue_date, 14)
								DO

									/* get BAD_DAYNAME from checkerboard_candi_date :
									only insert to semiweeklyCheckerboardArrestees the issues that match BAD_DAYNAME */

                  /* explicitly reset bad_dayname on each pass for gods sake */
                  SET @thisSQL = CONCAT('SELECT "XingqiWu" INTO @bad_dayname FROM semiweeklyCheckerboardCandidateISS LIMIT 1 ');
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
                  /* SET @thisSQL = CONCAT('SELECT DAYNAME(issue_date) INTO @bad_dayname '); */
                  SET @thisSQL = CONCAT('SELECT COALESCE(DAYNAME(issue_date), "Blortensday") INTO @bad_dayname ');
									SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' LIMIT 1 '); /* LIMIT because the DAYNAME is always the same */
                  /* SELECT @thisSQL AS bad_dayname_is_this_the_right_day; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									/* SELECT @bad_dayname AS only_insert_this_weekday_to_arrestees; */

									SET @thisSQL = CONCAT('INSERT INTO semiweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM semiweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' ');
									SET @thisSQL = CONCAT(@thisSQL, 'AND format_id NOT IN (8,12) ');
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

									SET @thisSQL = CONCAT('SELECT COALESCE(MAX(issue_date), @last_issue_date) INTO @max_date_with_bad_dayname ');
									SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardArrestees ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' LIMIT 1 '); /* LIMIT because the DAYNAME is always the same */
									/*SELECT @thisSQL AS max_date_with_bad_daynameSQL;*/
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @max_date_with_bad_dayname;
									/* DEVNOTE: 2016-06-24 this should be refined so as not to push a date into the next year */

									SET strDebug = CONCAT('this_issue_date \'', @this_issue_date, '\' next_issue_date_value = \'', @next_issue_date, '\' checkerboard_candi_date = \'', @checkerboard_candi_date, '\' last_issue_date \'', @last_issue_date, '; on ', CAST(NOW() AS CHAR), ' ; ');
									SET strDebug = CONCAT(strDebug, 'int_checkerboard_flag = ', CAST(@int_checkerboard_flag AS CHAR), '.');
									/* SELECT strDebug AS new_issue_note_for_arrestee; */

									SET @thisSQL = CONCAT('UPDATE semiweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SET issue_note = CONCAT(issue_note, " ; ', strDebug, '") ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
								/*	SELECT @thisSQL AS UPDATE_issue_note_for_arrestee; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;




								/* COMPOSE THE FIX FOR BAD DATES: want CALL B2move_issues_to_other_weekday ; first have to set num_days_to_move */
									IF @checkerboard_candi_date = ADDDATE(@first_issue_date, checkerboard_increment) THEN 
									/* is first pass through loop, don't want to move this date */
										SET checkerboard_increment = 3; 
										/* advance the checkerboard_candi_date to be examined next */
										SET @thisSQL = CONCAT('SELECT ADDDATE(@checkerboard_candi_date, ', CAST(checkerboard_increment AS CHAR), ') INTO @checkerboard_candi_date FROM semiweeklyCheckerboardArrestees LIMIT 1 '); 
										PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
										/* SELECT @checkerboard_candi_date AS checkerboard_candi_date_first_pass; */
										
										SET @num_days_to_move = 0; 
										ITERATE org_issues_arrestees_insertion_loop;
										
									ELSEIF @checkerboard_candi_date < ADDDATE(@first_issue_date, 10) THEN 
										SET @num_days_to_move = 1; 
										SET checkerboard_increment = 3; 
									ELSE 
										SET @num_days_to_move = 2; /* somehow 1,1,2,2 */
										SET checkerboard_increment = 3;
									END IF;

									SET @thisSQL = CONCAT('SELECT CONCAT( "CALL B2move_issues_to_other_weekday(\'', this_pub_id, '\', \'', this_org_id, '\',  ');
									/* SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', \'', CAST(@checkerboard_candi_date AS CHAR), '\', '); */
									/* SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', \'', CAST(@last_issue_date AS CHAR), '\', '); */
									SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', ');
									SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@max_date_with_bad_dayname AS CHAR), '\', ');
									SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@num_days_to_move AS CHAR), '\', ' );
									SET @thisSQL = CONCAT(@thisSQL, '\'', @bad_dayname, '\'); ');  /* end CALL statement here */
									SET @thisSQL = CONCAT(@thisSQL, '") '); /* End CONCAT here */
									SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
									/* next is for cases like ocn809384055 with > issue / day / org */
									/* SET @thisSQL = CONCAT(@thisSQL, 'AND format_id NOT IN (8,12) '); 	*/
									SET @thisSQL = CONCAT(@thisSQL, 'LIMIT 1 ');
									SET @thisSQL = CONCAT(@thisSQL, 'INTO @B2move_str_call_statement_clause ');
									/* SELECT @thisSQL AS compose_B2_call; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @B2move_str_call_statement_clause;

									/* save B2 call in some random field of the arrestees table: rawIssueData */
									SET @thisSQL = CONCAT('UPDATE semiweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SET rawIssueData = "', @B2move_str_call_statement_clause, '" ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
									/*SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' ');*/
									/* SELECT @thisSQL AS prep_for_B2_insert; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
								/* END COMPOSE THE FIX FOR BAD DATES */


								/* advance the checkerboard_candi_date to be examined next */
								SET @thisSQL = CONCAT('SELECT ADDDATE(@checkerboard_candi_date, ', CAST(checkerboard_increment AS CHAR), ') INTO @checkerboard_candi_date ');
								SET @thisSQL = CONCAT(@thisSQL, 'FROM semiweeklyCheckerboardArrestees LIMIT 1 '); 	# or any table, just needs a FROM clause
								PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
								SELECT @checkerboard_candi_date AS checkerboard_candi_date_bottom;


								END WHILE org_issues_arrestees_insertion_loop;
							END IF; /* int_insertion_flag at ISS level */
					END IF; /* int_checkerboard_flag at ISS level */
				END IF; /* num_iss_for_pub_and_org meets criteria */
				/* end new 2016-06-10 08:25:58 */





				END WHILE org_issues_cursor_loop;
				CLOSE org_issues_cursor;
				SET end_recordset = 0; /* will have been tripped by org_issues_cursor */

			END IF; /* int_insertion_flag at PUBS level */
		END IF; /* int_checkerboard_flag at PUBS level */
		END IF; /* pub has at least the right amount of issues */

  SET loop_ticker = loop_ticker + 1;
END WHILE pubs_cursor_loop;
CLOSE pubs_cursor;

SET @thisSQL = 'SELECT pub_id, pub_title, pub_note FROM semiweeklyCheckerboardSuspects LIMIT 5';
SELECT @thisSQL AS just_sample_possible_checkerboard_PUBS;
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

SET @thisSQL = 'SELECT DISTINCT pub_id, issue_date, rawIssueData, org_id, issue_note FROM semiweeklyCheckerboardArrestees LIMIT 50';
SELECT @thisSQL AS just_sample_possible_checkerboard_ISS;
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;


SELECT 'Dropping PUBS and ISS views' AS will_cleanup_2;
SET @thisSQL = 'DROP VIEW semiweeklyCheckerboardCandidatePUBS';
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
SET @thisSQL = 'DROP VIEW semiweeklyCheckerboardCandidateISS';
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

SET totalExecutionEnd = CURRENT_TIME();
 SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
  /* SELECT totalExecutionTimer; */
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2move_build_calls_TW_checkerboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`192.168.1.80`*/ /*!50003 PROCEDURE `B2move_build_calls_TW_checkerboard`(
    IN boolSendToOutfile TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE loop_ticker INT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE str_where_pub_and_org_clause TEXT; /* SQL WHERE */
    DECLARE str_call_statement_clause TEXT;
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
	DECLARE outfileName	TEXT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

	/* dates from the view, issues which exist */
	DECLARE first_issue_date DATE; 	DECLARE this_issue_date DATE; 	DECLARE next_issue_date DATE; DECLARE last_issue_date DATE;
	DECLARE max_date_with_bad_dayname date;
	/* dates which, if present in the view, indicate likely checkerboard :
			- they are on a DAYNAME() that is not VALID_DATESTEP (3 for triweekly) after DAYNAME(first_issue_date)
		*/
	DECLARE checkerboard_candi_date DATE;
	DECLARE num_days_to_move INT; /* number of days, positive or negative, to move this issue to be on a correct day: parameter for B2move_issues_to_other_weekday */

	DECLARE int_checkerboard_flag INT; /* should we suspect this title of being a checkerboard ? */
	DECLARE int_insertion_flag INT; /* did we already add this pub_id to the list of suspects? */

	DECLARE this_pub_id TEXT; /* filled by cursor */
    DECLARE this_org_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR
	SELECT pub_id FROM triweeklyCheckerboardCandidatePUBS;

	DECLARE org_issues_cursor CURSOR FOR
	SELECT DISTINCT org_id FROM triweeklyCheckerboardCandidateISS WHERE pub_id = this_pub_id COLLATE utf8_unicode_ci;


/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('B2move_build_calls_TW_checkerboard("', boolSendToOutfile, '" \'); from ', CAST(totalExecutionBegin AS CHAR), '\n');
/*  SET outfileName = CONCAT('/home/mysql/tmp/B2move_build_calls_TW_checkerboard_', boolSendToOutfile, '.csv');
    SET outfileName = CONCAT('/home/mysql/tmp/B2move_build_calls_TW_checkerboard_', this_pub_id, '.csv'); */
SET outfileName = CONCAT('B2move_build_calls_TW_checkerboard_', boolSendToOutfile, '.csv');



    /* see file: create_triweeklyCheckerboardSuspects.sql
    	- SUSPECTS are publication-level
    	- ARRESTEES as issue-level
     */
	SET @thisSQL = 'DELETE FROM triweeklyCheckerboardSuspects WHERE 1 > 0';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('Clean triweeklyCheckerboardSuspects: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS triweeklyCheckerboardSuspects_Cleaned;
    /* empty junk table exists, loop will fill it with PUBLICATIONS records (copies) and save stuff in pub_note, numberingNote515 etc. */

    /* see file: triweeklyCheckerboardArrestees.sql
    	- ARRESTEES as issue-level
    	- SUSPECTS are publication-level
    */
	SET @thisSQL = 'DELETE FROM triweeklyCheckerboardArrestees WHERE 1 > 0';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('Clean triweeklyCheckerboardArrestees: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS triweeklyCheckerboardArrestees_Cleaned;
    /* empty junk table exists, loop will fill it with ISSUES records (copies) and save stuff in issue_note, etc. */


/* create a view of TRIWEEKLY publications */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW triweeklyCheckerboardCandidatePUBS AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM publications ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE freq_id_code ="i" ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY pub_title, pub_bgnDate, pub_endDate );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS pubsview;
	/* now the view exists, main SELECT SQL will use it in JOIN  */

/* create a view of ISSUES from TRIWEEKLY publications */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW triweeklyCheckerboardCandidateISS AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id IN (SELECT pub_id FROM triweeklyCheckerboardCandidatePUBS) ');
  SET @thisSQL = CONCAT(@thisSQL, 'AND org_id NOT IN ("AQM", "FLNEW", "MITGS", "PQHN") ');
  /* above: exclude issues from vendors 2016-06-13 */
	SET @thisSQL = CONCAT(@thisSQL, ' );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS issview;
	/* now the view exists, main SELECT SQL will use it in JOIN  */

/* build main SELECT SQL */
SET @thisSQL = 'SELECT DISTINCT DAYNAME(I.issue_date) as dayname, ';
SET @thisSQL = CONCAT(@thisSQL, 'MIN(I.issue_date) AS org_first_issue, MAX(I.issue_date) AS org_last_issue, COUNT(*) AS issues_this_org_this_date_range_this_dayname, ');
SET @thisSQL = CONCAT(@thisSQL, 'I.org_id, O.org_name, ');
SET @thisSQL = CONCAT(@thisSQL, 'P.pub_id, P.pub_title, P.freq_id_code, P.frequency310, P.former_freq_id_code, P.formerFrequency321 ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM `icondata`.`triweeklyCheckerboardCandidateISS` I ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`triweeklyCheckerboardCandidatePUBS` P ON P.pub_id = I.pub_id ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`organizations` O ON O.org_id = I.org_id ');
/* SET @thisSQL = CONCAT(@thisSQL, 'WHERE 1=1 '); */
SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY P.pub_id, DAYOFWEEK(I.issue_date), I.org_id ');  /* # good, retain */
SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY org_first_issue, org_last_issue ');
SELECT @thisSQL AS B2move_build_calls_TW_checkerboardSQL;

SET loop_ticker = 1;
SET end_recordset = 0;
SET @next_issue_date = '0000-00-00'; /* 2016-06-14 13:01:52 unused in this version */

	/* SELECT CONCAT("CKB_TW: entered if org_pubs_count with ", @org_pubs_count, ", and loop_ticker = ", CAST(loop_ticker AS CHAR)) AS CKB_TWif_org_pubs_count;    */
OPEN pubs_cursor;
	/* SELECT CONCAT("CKB_TW: opened pubs_cursor") AS CKB_TWopened_pub_cursor; */
	pubs_cursor_loop: WHILE end_recordset = 0 DO
		/* SELECT CONCAT("CKB_TW: into pubs_cursor_loop") AS CKB_TWpubs_cursor_loop;  */
		FETCH pubs_cursor INTO this_pub_id;
		/* SELECT CONCAT("CKB_TW: this_pub_id = ", this_pub_id) AS CKB_TWfetched_pub_cursor;   */

		IF end_recordset THEN
			SELECT 'End of PUBS recordset' AS endRecsMsg;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
			/* CLOSE pubs_cursor; # outside loop end */
		END IF;

		CALL get_issue_MINMAX_for_pub(this_pub_id, @first_issue_date, @last_issue_date); /* fill some date variables */

		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @pub_issue_count FROM triweeklyCheckerboardCandidateISS WHERE pub_id = \'', this_pub_id, '\';');
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SELECT CONCAT(' pub_issue_count: ', CAST(@pub_issue_count AS CHAR), ' issues') AS num_iss_for_pub;

IF @pub_issue_count > 3 THEN /* 3 for triweekly, change to a var later... */

	/* if checkerboard_candi_date is present...
	starting from first_issue_date, when looking at the PUB level	*/
	SET @thisSQL = 'SELECT ADDDATE(@first_issue_date, 8) INTO @checkerboard_candi_date ';
	SET @thisSQL = CONCAT(@thisSQL, 'FROM issues LIMIT 1 '); 	/* or any table, just needs a FROM clause */
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @checkerboard_candi_date AS checkerboard_candi_date_top;

	/* number of issues at date suspected of being wrong if present */
	SET @thisSQL = 'SELECT COUNT(*) INTO @int_checkerboard_flag ';
  SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ');
  SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', this_pub_id, '\' AND issue_date = \'', @checkerboard_candi_date, '\' ');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @int_checkerboard_flag AS int_checkerboard_flag_PUBlevel;

		IF @int_checkerboard_flag > 0 THEN /* insert this pub into SUSPECTS table, editing the pub_note field */
			/* works, retain
			SELECT this_pub_id, @first_issue_date AS first_issue_date,
				@checkerboard_candi_date AS checkerboard_candi_date, @last_issue_date AS last_issue_date,
				@int_checkerboard_flag AS int_checkerboard_flag;   */

			/* did we already flag this title ? */
			SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @int_insertion_flag ');
			SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardSuspects WHERE pub_id = \'', this_pub_id, '\' ');
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			SELECT @int_insertion_flag AS suspect_already_logged;

			IF @int_insertion_flag = 0 THEN
				SET @thisSQL = CONCAT('INSERT INTO triweeklyCheckerboardSuspects ');
				SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM triweeklyCheckerboardCandidatePUBS WHERE pub_id = \'', this_pub_id, '\' ');
				PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

				SET strDebug = CONCAT('first_issue_date \'', @first_issue_date, '\' checkerboard_candi_date = \'', @checkerboard_candi_date, '\' last_issue_date \'', @last_issue_date, ' ; ');
				SET strDebug = CONCAT(strDebug, 'on ', CAST(NOW() AS CHAR), ' ; int_checkerboard_flag = ', CAST(@int_checkerboard_flag AS CHAR), '.');
				/* SELECT strDebug AS new_pub_note_for_suspect; */

				SET @thisSQL = CONCAT('UPDATE triweeklyCheckerboardSuspects ');
				SET @thisSQL = CONCAT(@thisSQL, 'SET pub_note = "', strDebug, '" WHERE pub_id = \'', this_pub_id, '\' ');
				/* SELECT @thisSQL AS UPDATE_pub_note_for_suspect; */
				PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

			/* finished with PUBS level here, the title is in the table of suspected checkerboards
				- now issues of that title
				- B2move_issues_to_other_weekday wants an org_id, so LOOP THROUGH ISSUES VIEW TO GET ORG_IDS */
				OPEN org_issues_cursor;
					org_issues_cursor_loop: WHILE end_recordset = 0 DO

						FETCH org_issues_cursor INTO this_org_id;

						IF end_recordset THEN
							SELECT 'End of ISS recordset' AS endRecsMsg;
							LEAVE org_issues_cursor_loop;
							/* CLOSE org_issues_cursor; # outside of loop end */
						END IF; /* org_issues_cursor */

						/* SELECT this_org_id AS just_plain_this_org_id;	*/

					/*
						first time through the issues, this_issue_date will be same as first_issue_date
						- from now on after get_issue_MINMAX_for_org:
							first_issue_date, this_issue_date, next_issue_date, checkerboard_candi_date, last_issue_date
							refer only to the set held by this ORG
					*/
					CALL get_issue_MINMAX_for_org(this_pub_id, this_org_id, @first_issue_date, @last_issue_date, @strDebug);
					SET @str_where_pub_and_org_clause = CONCAT('WHERE pub_id = \'', this_pub_id, '\' AND org_id = \'', this_org_id, '\' ');

					SET @thisSQL = CONCAT('SELECT \'', @first_issue_date, '\' INTO @this_issue_date ');
					SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS LIMIT 1 ');
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

					SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @num_iss_for_pub_and_org ');
				  SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
					/* SELECT @num_iss_for_pub_and_org; */

					/* if checkerboard_candi_date is present...
					starting from first_issue_date
					*/
					SET @thisSQL = 'SELECT ADDDATE(@first_issue_date, 8)  INTO @checkerboard_candi_date '; /* 8 for triweekly, change to a var later... */
					SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees LIMIT 1 '); 	# or any table, just needs a FROM clause
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

					/* number of issues at date suspected of being checkerboard_candi_date if present */
					SET @thisSQL = 'SELECT COUNT(*) INTO @int_checkerboard_flag ';
					SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
					SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
					/* SELECT @thisSQL AS next_count_checkerboard_candi_date; */
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
					/* SELECT @int_checkerboard_flag AS int_checkerboard_flag_ISS_level; */

				/* 2016-06-10 08:25:41 */
# make this a while 2016-06-14 13:20:15
					IF @num_iss_for_pub_and_org > 3 THEN /* 3 for triweekly, DEVNOTE make var */

						IF @int_checkerboard_flag > 0 THEN /* insert this issue into ARRESTEES table, editing the issue_note field */
							/* works, retain */
							SELECT this_pub_id, @this_issue_date AS this_issue_date,
								@checkerboard_candi_date AS checkerboard_candi_date, @last_issue_date AS last_issue_date,
								@int_checkerboard_flag AS int_checkerboard_flag, this_org_id;


  						/* did we already flag this PUB_ORG_DATE ? */
  						SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @int_insertion_flag ');
  						SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees ', @str_where_pub_and_org_clause);
  						SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
  						PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
  						/* SELECT @int_insertion_flag AS arrestee_already_logged;  */

						/* ISSUES: flag, insert, update */
							IF @int_insertion_flag = 0 THEN /* save this issue */
								org_issues_arrestees_insertion_loop:
								WHILE @checkerboard_candi_date <= ADDDATE(@first_issue_date, 12)
								DO

									/* get BAD_DAYNAME from checkerboard_candi_date :
									only insert to triweeklyCheckerboardArrestees the issues that match BAD_DAYNAME */

                  /* explicitly reset bad_dayname on each pass for gods sake */
                  SET @thisSQL = CONCAT('SELECT "XingqiWu" INTO @bad_dayname FROM triweeklyCheckerboardCandidateISS LIMIT 1 ');
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
                  /* SET @thisSQL = CONCAT('SELECT DAYNAME(issue_date) INTO @bad_dayname '); */
                  SET @thisSQL = CONCAT('SELECT COALESCE(DAYNAME(issue_date), "Blortensday") INTO @bad_dayname ');
									SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' LIMIT 1 '); /* LIMIT because the DAYNAME is always the same */
                  /* SELECT @thisSQL AS bad_dayname_is_this_the_right_day; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @bad_dayname AS only_insert_this_weekday_to_arrestees;

									SET @thisSQL = CONCAT('INSERT INTO triweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' ');
									SET @thisSQL = CONCAT(@thisSQL, 'AND format_id NOT IN (8,12) ');
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

									SET @thisSQL = CONCAT('SELECT COALESCE(MAX(issue_date), @last_issue_date) INTO @max_date_with_bad_dayname ');
									SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' LIMIT 1 '); /* LIMIT because the DAYNAME is always the same */
									SELECT @thisSQL AS max_date_with_bad_daynameSQL;
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @max_date_with_bad_dayname;

									SET strDebug = CONCAT('this_issue_date \'', @this_issue_date, '\' next_issue_date_value = \'', @next_issue_date, '\' checkerboard_candi_date = \'', @checkerboard_candi_date, '\' last_issue_date \'', @last_issue_date, '; on ', CAST(NOW() AS CHAR), ' ; ');
									SET strDebug = CONCAT(strDebug, 'int_checkerboard_flag = ', CAST(@int_checkerboard_flag AS CHAR), '.');
									/* SELECT strDebug AS new_issue_note_for_arrestee; */

									SET @thisSQL = CONCAT('UPDATE triweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SET issue_note = CONCAT(issue_note, " ; ', strDebug, '") ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
								/*	SELECT @thisSQL AS UPDATE_issue_note_for_arrestee; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

						/* COMPOSE THE FIX FOR BAD DATES:
									want CALL B2move_issues_to_other_weekday */


						SET @num_days_to_move = -1; /* 2016-06-14  */

									SET @thisSQL = CONCAT('SELECT CONCAT( "CALL B2move_issues_to_other_weekday(\'', this_pub_id, '\', \'', this_org_id, '\',  ');
									/* SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', \'', CAST(@checkerboard_candi_date AS CHAR), '\', '); */
									/* SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', \'', CAST(@last_issue_date AS CHAR), '\', '); */
									SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', ');
									SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@max_date_with_bad_dayname AS CHAR), '\', ');
									SET @thisSQL = CONCAT(@thisSQL, '\'num_days_to_move=', CAST(@num_days_to_move AS CHAR), '\', ' );
									SET @thisSQL = CONCAT(@thisSQL, '\'', @bad_dayname, '\'); ');  /* end CALL statement here */
									SET @thisSQL = CONCAT(@thisSQL, '") '); /* End CONCAT here */
									SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
									/* next is for cases like ocn809384055 with > issue / day / org */
									/* SET @thisSQL = CONCAT(@thisSQL, 'AND format_id NOT IN (8,12) '); 	*/
									SET @thisSQL = CONCAT(@thisSQL, 'LIMIT 1 ');
									SET @thisSQL = CONCAT(@thisSQL, 'INTO @B2move_str_call_statement_clause ');
									/* SELECT @thisSQL AS compose_B2_call; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @B2move_str_call_statement_clause;

									/* save B2 call in some random field of the arrestees table: rawIssueData */
									SET @thisSQL = CONCAT('UPDATE triweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SET rawIssueData = "', @B2move_str_call_statement_clause, '" ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
									/*SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' ');*/
									/* SELECT @thisSQL AS prep_for_B2_insert; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		/* END COMPOSE THE FIX FOR BAD DATES */


	/* advance the checkerboard_candi_date to be examined next */
	SET @thisSQL = 'SELECT ADDDATE(@checkerboard_candi_date, 2) INTO @checkerboard_candi_date ';
	SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees LIMIT 1 '); 	# or any table, just needs a FROM clause
	/* SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
	SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @this_issue_date, '\' LIMIT 1 '); */
	/* SELECT @thisSQL AS change_checkerboard_candi_date_SQL; */
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @checkerboard_candi_date AS checkerboard_candi_date_bottom;


								END WHILE org_issues_arrestees_insertion_loop;
							END IF; /* int_insertion_flag at ISS level */
					END IF; /* int_checkerboard_flag at ISS level */
				END IF; /* num_iss_for_pub_and_org meets criteria */
				/* end new 2016-06-10 08:25:58 */





				END WHILE org_issues_cursor_loop;
				CLOSE org_issues_cursor;
				SET end_recordset = 0; /* will have been tripped by org_issues_cursor */

			END IF; /* int_insertion_flag at PUBS level */
		END IF; /* int_checkerboard_flag at PUBS level */
		END IF; /* pub has at least the right amount of issues */

  SET loop_ticker = loop_ticker + 1;
END WHILE pubs_cursor_loop;
CLOSE pubs_cursor;

SET @thisSQL = 'SELECT pub_id, pub_title, pub_note FROM triweeklyCheckerboardSuspects LIMIT 5';
SELECT @thisSQL AS just_sample_possible_checkerboard_PUBS;
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

SET @thisSQL = 'SELECT DISTINCT pub_id, issue_date, rawIssueData, org_id, issue_note FROM triweeklyCheckerboardArrestees LIMIT 50';
SELECT @thisSQL AS just_sample_possible_checkerboard_ISS;
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;


SELECT 'Dropping PUBS and ISS views' AS will_cleanup_2;
SET @thisSQL = 'DROP VIEW triweeklyCheckerboardCandidatePUBS';
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
SET @thisSQL = 'DROP VIEW triweeklyCheckerboardCandidateISS';
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

SET totalExecutionEnd = CURRENT_TIME();
 SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
  /* SELECT totalExecutionTimer; */
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2move_issues_to_other_weekday` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B2move_issues_to_other_weekday`(
	IN this_pub_id TEXT, 
    IN this_org_id TEXT, 
    IN from_date DATE, 
    IN to_date DATE, 
    IN num_days_to_move INT, 
    IN bad_day_name TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE where_clause TEXT;
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A1Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A2Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE C3Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A1_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A2_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE C3_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
    SET strDebug = CONCAT('B2move_issues_to_other_weekday("', this_pub_id, '", "', this_org_id, '", \'', CAST(from_date AS CHAR), '\', \'', CAST(to_date AS CHAR), '\' num_days_to_move=', CAST(num_days_to_move AS CHAR), '); from ', CAST(totalExecutionBegin AS CHAR), '\n');
	SET totalExecutionTimer = strDebug;
    SELECT strDebug AS B2move_issues_to_other_weekday_start;
    
	SET where_clause = CONCAT('WHERE pub_id = "', this_pub_id, '" ');
	SET where_clause = CONCAT(where_clause, 'AND specificIssuesCreated = 1 '); /* trying not to kill any good issues with next 2 lines */
	SET where_clause = CONCAT(where_clause, 'AND org_id NOT IN("AQM","FLNEW","MITGS","PQHN" ) '); 
	SET where_clause = CONCAT(where_clause, 'AND org_id = "', this_org_id, '" ');
	SET where_clause = CONCAT(where_clause, 'AND issue_date BETWEEN \'', CAST(from_date AS CHAR), '\' AND \'', CAST(to_date AS CHAR), '\' ');
    SET where_clause = CONCAT(where_clause, 'AND DAYNAME(issue_date) = "', bad_day_name, '" ');
	SET where_clause = CONCAT(where_clause, 'ORDER BY issue_date ');
    
    /* we really want to update these issues, but first build correct syntax, then when ready: */
	SET @thisSQL = CONCAT('SELECT DISTINCT DAYNAME(issue_date) AS existing_dow, issue_date AS existing_iss_date, org_id, ');
	SET @thisSQL = CONCAT(@thisSQL, 'ADDDATE(issue_date, \'', CAST(num_days_to_move AS CHAR), '\') AS new_dow, ' );
	SET @thisSQL = CONCAT(@thisSQL, 'DAYNAME(ADDDATE(issue_date, \'', CAST(num_days_to_move AS CHAR), '\')) AS new_iss_date ' );
	SET @thisSQL = CONCAT(@thisSQL, 'FROM issues ');
	SET @thisSQL = CONCAT(@thisSQL, where_clause);
	SELECT @thisSQL AS SELECT_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
    PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
    
    /* DEVNOTE: ADD PARAMS: WEEKDAY NAME? */
    
	SET @thisSQL = CONCAT('UPDATE issues SET issue_date = ADDDATE(issue_date, ', CAST(num_days_to_move AS CHAR), ') ');
	SET @thisSQL = CONCAT(@thisSQL, where_clause);
	SELECT @thisSQL AS UPDATE_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;  
	/* SELECT "NO UPDATE PERFORMED DURING DEV" AS only_testing; */
    
	SET @A1_SQL = CONCAT('CALL A1issues_per_publication("', this_pub_id, '")');
	SELECT @A1_SQL AS A1_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	IF ( 1 > 0 ) THEN /* quick way to toggle whether to call the time-consuming helpler functions */
		PREPARE A1Statement FROM @A1_SQL; EXECUTE A1Statement; DEALLOCATE PREPARE A1Statement;   
	ELSE
		SELECT "NO A1issues_per_publication DURING DEV" AS only_testing_A1;
	END IF;     

	SET @A2_SQL = CONCAT('CALL A2issues_per_organization("', this_pub_id, '")');
	SELECT @A2_SQL AS A2_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	IF ( 1 > 0 ) THEN 
		PREPARE A2Statement FROM @A2_SQL; EXECUTE A2Statement; DEALLOCATE PREPARE A2Statement;  
	ELSE
		SELECT "NO A2issues_per_organization DURING DEV" AS only_testing_A2;
	END IF;     

	/* SET @C3_SQL = CONCAT('CALL C3publications_per_org("', this_org_id, '")'); */
	SET @C3_SQL = CONCAT('CALL C3publications_per_org_fill_single_pub("', this_org_id, '", "', this_pub_id, '" )'); 
	SELECT @C3_SQL AS C3_SQL; 
    SET queryExecutionBegin = CURRENT_TIME();
	IF ( 1 > 0 ) THEN 
		PREPARE C3Statement FROM @C3_SQL; EXECUTE C3Statement; DEALLOCATE PREPARE C3Statement;  
	ELSE
		SELECT "NO C3publications_per_org_fill_single_pub DURING DEV" AS only_testing_C3; 
	END IF; 
    
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(this_pub_id, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
    
	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2publication_issues_per_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B2publication_issues_per_year`(
	IN pub_id TEXT,
	IN begin_year TEXT,
    IN end_year TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('B2publication_issues_per_year ', pub_id, ', ', begin_year, '-', end_year,' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET outputTableName = 'B2publication_issues_per_year';
	SET table_name 	= CONCAT('B2publication_issues_per_year_', pub_id);

		/* begin_date and end_date will have their values modified on every pass through the loop below:
			here, we want to use them to create a VIEW of the issues records between them */
	SET begin_date 	= CAST( CONCAT(begin_year, '-01-01') AS DATE); /* SELECT begin_date; */
    SET end_date 	= CAST( CONCAT(end_year, '-12-31') AS DATE); /* SELECT end_date; */
	/*******************************
    this is where the CREATE OR REPLACE VIEW was located until version 7: now it's in the loop
    *******************************/

		/* uniform_title needs to be set just once: 
			since B2 is interested in the title level, here we'll generate a uniform title with geographical and date information
		*/
	CALL build_uniform_title( pub_id, @uniform_title );


	SET insertClause = CONCAT('INSERT INTO ', outputTableName, '( pub_id, pub_title, ');
    SET insertClause = CONCAT(insertClause, 'issue_year, issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, 1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');

		/* tried dynamically picking begin and end dates: adds a long time to query but code is in: p2_B1_issues_per_year_format_dynamic_date_snippet.sql */
    SET this_year = CAST(begin_year AS UNSIGNED);
    SET last_date = CAST( CONCAT(end_year, '-12-31') AS DATE);
    /* SELECT CONCAT('last_date = ', CAST(last_date AS CHAR)) AS showing_last_date; */
    insertionLoop: LOOP
		SET begin_date 	= CAST( CONCAT(this_year, '-01-01') AS DATE);
		SET end_date 	= CAST( CONCAT(this_year, '-12-31') AS DATE);
        SET messagePrefix = CONCAT(pub_id, ' ', CAST(this_year AS CHAR), ': ');

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', table_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date, format_id );');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(messagePrefix, 'CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;
		/* now the view exists, its name is in the variable 'table_name' we use table_name as we used the temporary table name in the first version */

		/* fill the values to be inserted in the output table */
        /* see file B2publication_issues_per_year_testing_time_notes.sql for extended comments
			about how slow it was to look up the total number of issues and some of the strategies.
			- Total number of issues is the same as the sum of all the formats, so @issue_count will be set after the formats
		*/


			/* how many distinct FORMATS for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', table_name,'.format_id ) INTO @format_count_distinct FROM ', table_name, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer;  */


		/* get the number of issues in each format for this year */
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 1, @format_count_1);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 2, @format_count_2);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 3, @format_count_3);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 5, @format_count_5);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 6, @format_count_6);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 7, @format_count_7);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 9, @format_count_9);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 10, @format_count_10);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 11, @format_count_11);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 12, @format_count_12);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 13, @format_count_13);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 14, @format_count_14);
		CALL get_format_count_for_pub( pub_id, begin_date, end_date, 15, @format_count_15);


		/*
		END FORMATS
		TOTAL NUMBER OF ISSUES IN THE YEAR? is the same as the total of all the formats, so:  */
		SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;


			/* how many distinct ISSUE DATES for this title? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', table_name,'.issue_date ) INTO @issue_count_distinct FROM ', table_name, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer; */
        

		/* perform the INSERT */
		SET @thisSQL = CONCAT(insertClause, ' (\'', pub_id, '\', "', @uniform_title, '", ',  CAST(this_year AS CHAR), ', ');
        SET @thisSQL = CONCAT(@thisSQL, issue_count_total, ', ', @issue_count_distinct, ', ');
        SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ', 
								@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
								@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
                                @format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
                                @format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
                                @format_count_13, ', ', @format_count_14, ', ', @format_count_15);
        SET @thisSQL = CONCAT(@thisSQL, ');');
		/* SELECT CAST(@thisSQL AS CHAR) AS B2publication_issues_per_year_INSERT;  */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer; */

		IF CAST(CONCAT(this_year, '-12-31') AS DATE) <> last_date THEN
			SET this_year = this_year + 1; /* advance the year for next pass */
			ITERATE insertionLoop;
		END IF;
		SET strDebug = CONCAT('skipped IF with this_year=', CAST(this_year AS CHAR), ', next is LEAVE');
		/* SELECT strDebug; */
		LEAVE  insertionLoop;
    END LOOP insertionLoop;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', table_name, ';');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2remove_issues_and_update_A1A2C3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B2remove_issues_and_update_A1A2C3`(
	IN this_pub_id TEXT, 
    IN this_org_id TEXT, 
    IN from_date DATE, 
    IN to_date DATE
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE where_clause TEXT;
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A1Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A2Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE C3Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A1_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A2_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE C3_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
    SET strDebug = CONCAT('B2remove_issues_and_update_A1A2C3("', this_pub_id, '", "', this_org_id, '", \'', CAST(from_date AS CHAR), '\', \'', CAST(to_date AS CHAR), '\' ; from ', CAST(totalExecutionBegin AS CHAR), '\n');
	SET totalExecutionTimer = strDebug;
    SELECT strDebug AS B2remove_issues_and_update_A1A2C3_start;
    
	SET @thisSQL = CONCAT('DELETE FROM issues  ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = "', this_pub_id, '" ');
	SET @thisSQL = CONCAT(@thisSQL, 'AND specificIssuesCreated = 1 '); /* trying not to kill any good issues with next 2 lines */
	SET @thisSQL = CONCAT(@thisSQL, 'AND org_id NOT IN("AQM","FLNEW","MITGS","PQHN" ) '); 
	SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = "', this_org_id, '" ');
	SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', CAST(from_date AS CHAR), '\' AND \'', CAST(to_date AS CHAR), '\' ');
	SELECT @thisSQL AS UPDATE_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;  
/* SELECT "NO UPDATE PERFORMED DURING DEV" AS only_testing; */
    
	SET @A1_SQL = CONCAT('CALL A1issues_per_publication("', this_pub_id, '")');
	SELECT @A1_SQL AS A1_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	IF ( 0 > 1 ) THEN /* quick way to toggle whether to call the time-consuming helpler functions */
		PREPARE A1Statement FROM @A1_SQL; EXECUTE A1Statement; DEALLOCATE PREPARE A1Statement;   
	ELSE
		SELECT "NO A1issues_per_publication DURING DEV" AS only_testing_A1;
	END IF;  
    
	SET @A2_SQL = CONCAT('CALL A2issues_per_organization("', this_pub_id, '")');
	SELECT @A2_SQL AS A2_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	IF ( 0 > 1 ) THEN 
		PREPARE A2Statement FROM @A2_SQL; EXECUTE A2Statement; DEALLOCATE PREPARE A2Statement;  
	ELSE
		SELECT "NO A2issues_per_organization DURING DEV" AS only_testing_A2;
	END IF; 
    
    
	/* SET @C3_SQL = CONCAT('CALL C3publications_per_org("', this_org_id, '")'); */
	SET @C3_SQL = CONCAT('CALL C3publications_per_org_fill_single_pub("', this_org_id, '", "', this_pub_id, '" )');
	SELECT @C3_SQL AS C3_SQL; 
    SET queryExecutionBegin = CURRENT_TIME();
	IF ( 0 > 1 ) THEN 
		PREPARE C3Statement FROM @C3_SQL; EXECUTE C3Statement; DEALLOCATE PREPARE C3Statement;  
	ELSE
		SELECT "NO C3publications_per_org_fill_single_pub DURING DEV" AS only_testing_C3; 
	END IF; 
    
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(this_pub_id, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
    
    
	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B2trim_issues_outside_valid_dates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B2trim_issues_outside_valid_dates`(
	IN this_pub_id TEXT, 
    IN this_org_id TEXT, 
    IN from_date DATE, 
    IN to_date DATE
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A1Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A2Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE C3Statement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A1_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE A2_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
    DECLARE C3_SQL TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
    SET strDebug = CONCAT('B2trim_issues_outside_valid_dates("', this_pub_id, '", "', this_org_id, '", \'', CAST(from_date AS CHAR), '\', \'', CAST(to_date AS CHAR), '\'); from ', CAST(totalExecutionBegin AS CHAR), '\n');
	SET totalExecutionTimer = strDebug;
    SELECT strDebug AS B2trim_issues_outside_valid_dates_start;
    
    /* we really want to delete these issues, but first build correct syntax, then when ready: */
	SET @thisSQL = CONCAT('SELECT * FROM issues ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = "', this_pub_id, '" ');
	SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = "', this_org_id, '" ');
	SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', CAST(from_date AS CHAR), '\' AND \'', CAST(to_date AS CHAR), '\' ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date ');
	SELECT @thisSQL AS SELECT_SQL;
    
	SET @thisSQL = CONCAT('DELETE FROM issues ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = "', this_pub_id, '" ');
	SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = "', this_org_id, '" ');
	SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', CAST(from_date AS CHAR), '\' AND \'', CAST(to_date AS CHAR), '\' ');
	SELECT @thisSQL AS DELETION_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; 
    /* SELECT "NO DELETION PERFORMED DURING DEV" AS only_testing; */
    
    /* have to clean up the small tables, beginning with 
		A1issues_per_publication 

	2016-05-05 : A1, A2, C3 now clean themselves before running
    
	SET @thisSQL = CONCAT('DELETE FROM A1issues_per_publication WHERE pub_id="', this_pub_id, '" ');
	SELECT @thisSQL AS A1_CLEAN_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; 
    */
    /* SELECT "A1issues_per_publication now cleans itself, so NO DELETE from B2trim_issues_outside_valid_dates" AS no_delete_for_A1_from_B2trim; */
	SET @A1_SQL = CONCAT('CALL A1issues_per_publication("', this_pub_id, '")');
	SELECT @A1_SQL AS A1_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE A1Statement FROM @A1_SQL; EXECUTE A1Statement; DEALLOCATE PREPARE A1Statement; 
    /* SELECT "NO A1issues_per_publication DURING DEV" AS only_testing_A1;    */
    
    /*SELECT "A2issues_per_organization now cleans itself, so NO DELETE from B2trim_issues_outside_valid_dates" AS no_delete_for_A2_from_B2trim; */
	SET @A2_SQL = CONCAT('CALL A2issues_per_organization("', this_pub_id, '")');
	SELECT @A2_SQL AS A2_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE A2Statement FROM @A2_SQL; EXECUTE A2Statement; DEALLOCATE PREPARE A2Statement; 
    /* SELECT "NO A2issues_per_organization DURING DEV" AS only_testing_A1; */

	/* SELECT "C3publications_per_org_fill_single_pub now cleans itself, so NO DELETE from B2trim_issues_outside_valid_dates" AS no_delete_for_C3_from_B2trim; */
	/* SET @C3_SQL = CONCAT('CALL C3publications_per_org("', this_org_id, '")'); */
	SET @C3_SQL = CONCAT('CALL C3publications_per_org_fill_single_pub("', this_org_id, '", "', this_pub_id, '" )');
	SELECT @C3_SQL AS C3publications_per_org_fill_single_pub;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE C3Statement FROM @C3_SQL; EXECUTE C3Statement; DEALLOCATE PREPARE C3Statement; 
    /* SELECT "NO C3publications_per_org_fill_single_pub DURING DEV" AS only_testing_C3; */
    
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(this_pub_id, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
    
    
	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `B3publications_per_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `B3publications_per_country`(
	IN this_country_id TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
    DECLARE loop_ticker INT;

	DECLARE country_pubs_view	TEXT;
	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into output_table_name */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;

    DECLARE MINissue_date	DATE;	DECLARE MAXissue_date	DATE;

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

    DECLARE pub_holders_count INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */

	DECLARE this_pub_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR
	SELECT pub_id FROM publications WHERE country_id = this_country_id ORDER BY pub_id;

/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();

		/* country_name needs to be set just once */
    SET @thisSQL = CONCAT('SELECT country_name INTO @country_name FROM countries WHERE country_id = \'', this_country_id, '\';');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT country_name INTO ', @country_name, ', ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

	SET totalExecutionTimer = CONCAT('B3publications_per_country ', this_country_id ,'=', @country_name, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET output_table_name 	= 'B3publications_per_country';
	SET country_pubs_view 	= CONCAT('B3publications_per_country_', this_country_id);

	SET insertClause = CONCAT('INSERT INTO ', output_table_name, '( country_id, pub_id, pub_title, ');
    SET insertClause = CONCAT(insertClause, 'pub_holders_count, MINissue_date, MAXissue_date, ');
    SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, ');
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');

	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', country_pubs_view, ' AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM publications WHERE country_id = \'', this_country_id ,'\' ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY pub_id );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: country_pubs_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

		/* test for number of valid publications */
	SET @thisSQL = CONCAT('SELECT COUNT(*)  FROM ', country_pubs_view, ' INTO @country_pubs_count;');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(@country_name, ' has ', CAST(@country_pubs_count AS CHAR), ' titles');
	SELECT queryExecutionTimer AS num_pubs_in_country;

	SET strDebug = "";
IF @country_pubs_count > 0 THEN
	SET loop_ticker = 1;
	OPEN pubs_cursor;
	pubs_cursor_loop: WHILE end_recordset = 0 DO

		FETCH pubs_cursor INTO this_pub_id;

		IF end_recordset THEN
			SELECT 'End of recordset' AS endRecsMsg;
			CLOSE pubs_cursor;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
		ELSE

			CALL build_uniform_title( this_pub_id, @uniform_title );

			SET strDebug = CONCAT(CAST(loop_ticker AS CHAR), ') ', this_pub_id, ' = ', @uniform_title);
			/* SELECT strDebug AS pub_country_output; */

			/* create a view to look up ISSUES values */
			SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW issues_view AS ( ');
			SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', this_pub_id ,'\' ');
			SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' ');
			SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date, format_id );');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('CREATE VIEW: issues_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			/* fill the values to be inserted in the output table */

			/* how many distinct ORGANIZATIONS hold this publication? */
			SET @pub_holders_count = -1;
			CALL get_holding_org_count_for_pub(this_pub_id, @pub_holders_count);

				/* 
					what are the first and last dates held for this title? 
                    - null dates are handled in get_issue_MINMAX_for_pub
                */
			CALL get_issue_MINMAX_for_pub(this_pub_id, @MINissue_date, @MAXissue_date);
IF this_pub_id = '2010225028' THEN 
SELECT CONCAT('MIN-MAX dates received for ', this_pub_id, ': ', @MINissue_date, '-', @MAXissue_date) AS B3hasMINMAX;
END IF;

				/* how many distinct ISSUE DATES for this title? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date ) INTO @issue_count_distinct FROM issues_view;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			SELECT queryExecutionTimer; 

				/* how many distinct FORMATS for this year? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM issues_view;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			SELECT queryExecutionTimer; 


			/* get the number of issues in each format for this year */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);


			/*
			END FORMATS
			TOTAL NUMBER OF ISSUES IN THE YEAR? is the same as the total of all the formats, so:  */
			SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;
			/* perform the INSERT */
			SET @thisSQL = CONCAT(insertClause, ' ("', this_country_id, '", "', this_pub_id, '", "', @uniform_title, '", ');
			SET @thisSQL = CONCAT(@thisSQL, @pub_holders_count, ', \'', @MINissue_date, '\', \'', @MAXissue_date, '\', ');
            SET @thisSQL = CONCAT(@thisSQL, issue_count_total, ', ', @issue_count_distinct, ', ');
			SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
									@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
									@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
									@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
									@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
									@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
			SET @thisSQL = CONCAT(@thisSQL, ');');
			/* SELECT CAST(@thisSQL AS CHAR) AS B3publications_per_country_INSERT;  */
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			DROP VIEW issues_view;
			SET loop_ticker = loop_ticker + 1;
			/* end ELSE: there were publications in this country */
		END IF; /* end_of_recordset*/
	END WHILE pubs_cursor_loop;
ELSE
	SET strDebug = CONCAT('NOT getting pub details for ', CAST(@country_pubs_count AS CHAR), ' publications ; NO INSERT to ', output_table, '.');
END IF; /* there are publications in this country */
    SELECT strDebug AS pub_country_output;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', country_pubs_view, ';');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `build_org_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `build_org_title`(
IN 	org_id	TEXT,
OUT org_title TEXT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;

        DECLARE org_name 		TEXT;
        DECLARE org_city		TEXT;
        DECLARE country_name	TEXT;

		SET queryExecutionTimer = CONCAT('B2get_this_format_count rcvd: ', org_id, ', ; will get org_name;');
        /* SELECT queryExecutionTimer AS build_org_title_step1; */
		SET @thisSQL = CONCAT('SELECT org_name INTO @org_name FROM organizations WHERE org_id = \'', org_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement;  DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_org_title: got title: ', @org_name, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step1; */

		SET @thisSQL = CONCAT('SELECT org_city INTO @org_city FROM organizations WHERE org_id = \'', org_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement;  DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_org_title: got org_city: ', @org_city, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step2; */

		SET @thisSQL = CONCAT('SELECT country_name INTO @country_name FROM countries WHERE country_id = ( ');
        SET @thisSQL = CONCAT(@thisSQL, 'SELECT country_id FROM organizations WHERE org_id = \'', org_id ,'\'); ');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement;  DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_org_title: got country_name: ', @country_name, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step3; */

		SET org_title = CONCAT(@org_name, ' (', @org_city, ', ', @country_name, ')');
        /* SELECT org_title AS Exit_build_org_title; */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `build_uniform_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `build_uniform_title`(
IN 	pub_id	TEXT,
OUT uniform_title TEXT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;

        DECLARE pub_title 		TEXT;
        DECLARE pub_city		TEXT;
        DECLARE country_name	TEXT;
		DECLARE pub_bgnDate		TEXT;
        DECLARE pub_endDate		TEXT;

		SET queryExecutionTimer = CONCAT('build_uniform_title rcvd: ', pub_id, ', ; will get pub_title;');
        /* SELECT queryExecutionTimer AS build_uniform_title_step1; */
		SET @thisSQL = CONCAT('SELECT pub_title INTO @pub_title FROM publications WHERE pub_id = \'', pub_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement; 
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_uniform_title: got title: ', @pub_title, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.'); 
        /* special handling for quotations */
        SET @pub_title = REPLACE(@pub_title, '"', '');
		/* SELECT queryExecutionTimer as step1; */

		SET @thisSQL = CONCAT('SELECT pub_city INTO @pub_city FROM publications WHERE pub_id = \'', pub_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement; 
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_uniform_title: got pub_city: ', @pub_city, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step2; */

		SET @thisSQL = CONCAT('SELECT country_name INTO @country_name FROM countries WHERE country_id = ( ');
        SET @thisSQL = CONCAT(@thisSQL, 'SELECT country_id FROM publications WHERE pub_id = \'', pub_id ,'\'); ');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement; 
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_uniform_title: got country_name: ', @country_name, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step3; */
        
		SET @thisSQL = CONCAT('SELECT pub_bgnDate INTO @pub_bgnDate FROM publications WHERE pub_id = \'', pub_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement; 
		DEALLOCATE PREPARE thisStatement;
		IF @pub_bgnDate IS NULL THEN 
			SET @pub_bgnDate = '[empty date]';
		END IF;          
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_uniform_title: got pub_bgnDate: ', @pub_bgnDate, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step4; */
	
		SET @thisSQL = CONCAT('SELECT pub_endDate INTO @pub_endDate FROM publications WHERE pub_id = \'', pub_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement; 
		DEALLOCATE PREPARE thisStatement;
		IF @pub_endDate IS NULL THEN 
			SET @pub_endDate = '[empty date]';
		END IF;  
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('build_uniform_title: got pub_endDate: ', @pub_endDate, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer as step5; */

		SET uniform_title = CONCAT(@pub_title, ' (', @pub_city, ', ', @country_name, ' : ', @pub_bgnDate, ' to ', @pub_endDate, ')');
        /* SELECT uniform_title AS Exit_build_uniform_title; */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C1org_issues_per_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `C1org_issues_per_year`(
	IN org_id TEXT,
	IN begin_year TEXT,
    IN end_year TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE org_title 		TEXT;
    DECLARE publications_count	INT;
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
    /* count of the format with this ID */
    DECLARE format_count_distinct INT;
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('C1org_issues_per_year ', org_id, ', ', begin_year, '-', end_year,' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET outputTableName = 'C1org_issues_per_year';
	SET table_name 	= CONCAT('C1org_issues_per_year_temp_view'); /* can't use org_id because it might have an @ character */

		/* begin_date and end_date will have their values modified on every pass through the loop below:
			here, we want to use them to create a VIEW of the issues records between them */
	SET begin_date 	= CAST( CONCAT(begin_year, '-01-01') AS DATE); /* SELECT begin_date; */
    SET end_date 	= CAST( CONCAT(end_year, '-12-31') AS DATE); /* SELECT end_date; */
	/*******************************
    this is where the CREATE OR REPLACE VIEW was located until version 7: now it's in the loop
    *******************************/

		/* org_title needs to be set just once : it's like a uniform title */
	CALL build_org_title( org_id, @org_title );
	SELECT @org_title AS have_org_title;

/*
	SET insertClause = 'INSERT INTO C1org_issues_per_year_output( org_id, org_title, issue_year, numIssues, numPublications, ';
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, 6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, 11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, 15_Digital_tiff ) VALUES ');
*/
	SET insertClause = 'INSERT INTO C1org_issues_per_year_output( org_id, org_title, issue_year, ';
    SET insertClause = CONCAT(insertClause, 'publications_count, issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, 1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');


		/* tried dynamically picking begin and end dates: adds a long time to query but code is in: p2_B1_issues_per_year_format_dynamic_date_snippet.sql */
    SET this_year = CAST(begin_year AS UNSIGNED);
    SET last_date = CAST( CONCAT(end_year, '-12-31') AS DATE);
    /* SELECT CONCAT('last_date = ', CAST(last_date AS CHAR)) AS showing_last_date; */
    insertionLoop: LOOP
		SET begin_date 	= CAST( CONCAT(this_year, '-01-01') AS DATE);
		SET end_date 	= CAST( CONCAT(this_year, '-12-31') AS DATE);
        SET messagePrefix = CONCAT(@org_title, ' ', CAST(this_year AS CHAR), ': ');

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', table_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE org_id = \'', org_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        /* SET @thisSQL = CONCAT(@thisSQL, ') ORDER BY pub_id  ;'); */
        SET @thisSQL = CONCAT(@thisSQL, ') ;');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(messagePrefix, 'CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; */
		/* now the view exists, its name is in the variable 'table_name' we use table_name as we used the temporary table name in the first version */

		/* fill the values to be inserted in the output table */
        /* see file B1country_issues_per_year_testing_time_notes.sql for extended comments
			about how slow it was to look up the total number of issues and some of the strategies.
			- Total number of issues is the same as the sum of all the formats, so @issue_count will be set after the formats
		*/

			/* how many PUBLICATIONS for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', table_name,'.pub_id ) INTO @publications_count FROM ', table_name, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT pub_id) INTO @publications_count = ', @publications_count, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer; */

IF @publications_count > 0 THEN

			/* how many distinct FORMATS for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', table_name,'.format_id ) INTO @format_count_distinct FROM ', table_name, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer; */




		/* get the number of issues in each format for this year */
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 1, @format_count_1);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 2, @format_count_2);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 3, @format_count_3);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 5, @format_count_5);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 6, @format_count_6);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 7, @format_count_7);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 9, @format_count_9);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 10, @format_count_10);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 11, @format_count_11);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 12, @format_count_12);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 13, @format_count_13);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 14, @format_count_14);
		CALL get_format_count_all_pubs_this_org( org_id, begin_date, end_date, 15, @format_count_15);

		/*
		END FORMATS
		TOTAL NUMBER OF ISSUES IN THE YEAR? is the same as the total of all the formats, so:  */
		SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;

			/* how many distinct ISSUE DATES for this org in this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT ', table_name,'.issue_date ) INTO @issue_count_distinct FROM ', table_name, ';');
        SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', @issue_count_distinct, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer;


ELSE /* @publications_count was 0 : fill the variables */
    SET issue_count_total = 0; 	SET @issue_count_distinct = 0; 	SET @format_count_distinct = 0;
    SET @format_count_1 = 0;	SET @format_count_2 = 0;		SET @format_count_3 = 0;
    SET @format_count_4 = 0;	SET @format_count_5 = 0;		SET @format_count_6 = 0;
    SET @format_count_7 = 0;	SET @format_count_8 = 0;		SET @format_count_9 = 0;
    SET @format_count_10 = 0;	SET @format_count_11 = 0;		SET @format_count_12 = 0;
    SET @format_count_13 = 0;	SET @format_count_14 = 0;		SET @format_count_15 = 0;
END IF;

		/* perform the INSERT */
		SET @thisSQL = CONCAT(insertClause, ' (\'', org_id, '\', "', @org_title, '", ',  CAST(this_year AS CHAR), ', ');
        SET @thisSQL = CONCAT(@thisSQL, @publications_count, ', ', issue_count_total, ', ', @issue_count_distinct, ', ');
        SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
								@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
								@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
                                @format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
                                @format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
                                @format_count_13, ', ', @format_count_14, ', ', @format_count_15);
		SET @thisSQL = CONCAT(@thisSQL, ');');
		/* SELECT CAST(@thisSQL AS CHAR) AS C1org_issues_per_year_INSERT; */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT(messagePrefix, 'INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        /* SELECT queryExecutionTimer; */

		IF CAST(CONCAT(this_year, '-12-31') AS DATE) <> last_date THEN
			SET this_year = this_year + 1; /* advance the year for next pass */
			ITERATE insertionLoop;
		END IF;
		SET strDebug = CONCAT('skipped IF with this_year=', CAST(this_year AS CHAR), ', next is LEAVE');
		/* SELECT strDebug; */
		LEAVE  insertionLoop;
    END LOOP insertionLoop;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', table_name, ';');
    SET queryExecutionBegin = CURRENT_TIME();
    SET queryExecutionTimer = CONCAT( CAST(@thisSQL AS CHAR), ' ; ', CAST(queryExecutionBegin AS CHAR), ' ; ');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
    SET queryExecutionTimer = CONCAT( queryExecutionTimer, queryExecutionEnd, ' ; view shd be gone.');
    /* SELECT queryExecutionTimer; */

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C2get_date_formats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `C2get_date_formats`(
	IN this_pub_id TEXT,
    IN this_issue_date DATE, 
    IN this_org_id TEXT,
    OUT format_name TEXT, 
    OUT rawIssueData TEXT
)
BEGIN
	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE org_title			TEXT; /* similar, for org */
    DECLARE org_issue_count_total	INT;	DECLARE org_issue_count_distinct	INT;

    
    /* vars used in cursor */
    DECLARE date_format_ticker INT;
    DECLARE fake_date DATE;
    DECLARE this_raw MEDIUMTEXT;
    DECLARE this_format_id INT;
    DECLARE this_format_name VARCHAR(30);
    DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */

    /* declare cursors only after variables */
	DECLARE date_format_cursor CURSOR FOR /* TEMPORARY TABLE created below */
		SELECT * FROM C2gdf; /* DAYS OF FAILURE UNTIL USED TEMPORARY TABLE INSTEAD OF A VIEW */

	/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('C2get_date_formats: ', this_pub_id, ', ', CAST(this_issue_date AS CHAR), ', ', this_org_id, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	/* create view NOTE:
		C2pub_issues_per_org is is created in C2publication_issues_per_org,
		so this procedure will fail when called outside that context */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C2multiFormatIssues AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT i.issue_date, i.rawIssueData, i.format_id, ');
    SET @thisSQL = CONCAT(@thisSQL, 'f.format_name ');
    SET @thisSQL = CONCAT(@thisSQL, 'FROM issues i ');
    SET @thisSQL = CONCAT(@thisSQL, 'INNER JOIN formats f ON f.format_id = i.format_id ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date = \'', this_issue_date, '\' '); 
    SET @thisSQL = CONCAT(@thisSQL, 'AND pub_id = \'', this_pub_id ,'\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = \'', this_org_id ,'\' ');    
    SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY f.format_name) ');  
	/* SELECT CONCAT('C2multiFormatIssues: ', CAST(@thisSQL AS CHAR)) AS C2multiFormatIssuesSQL; */
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	/* the cursor would never advance correctly when reading from the VIEW created above.
		tested for days and showed that all VIEWs involved are composed of correct data, 
        even though FETCH has data for only very first date this was called with - it fails to advance 
	SOLUTION: CREATE TEMPORARY TABLE and fill it with the data from the VIEW */
	SET @thisSQL = 'CREATE TEMPORARY TABLE `icondata`.`C2gdf` (`issue_date` DATE, `rawIssueData` MEDIUMTEXT, `this_format_id` INT, `this_format_name` VARCHAR(30))';
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;		
	SET @thisSQL = 'INSERT INTO C2gdf SELECT * FROM C2multiFormatIssues';
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;		
	SET @thisSQL = 'SELECT * FROM C2gdf'; /* this last just debugs ; proves correct data */
	SELECT @thisSQL AS comingNext;
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;	

	SET format_name = ''; 	/* OUT var */
	SET rawIssueData = ''; 	/* OUT var */
    SET strDebug = '';
    
	SET date_format_ticker = 1;
	OPEN date_format_cursor;
    date_format_cursor_loop: LOOP 

		FETCH date_format_cursor INTO fake_date, this_raw, this_format_id, this_format_name;
			SET strDebug = CONCAT(strDebug, ' ... FETCHed ', CAST(date_format_ticker AS CHAR), ') this_issue_date = ', CAST(this_issue_date AS CHAR), ' ; fake_date = ', CAST(fake_date AS CHAR), ' ; format_name = ', format_name, ' ; this_format_name = (', this_format_id, ') ', this_format_name, ' ;  rawIssueData = ', rawIssueData, ' ; this_raw = ', this_raw); 

    	IF end_recordset THEN
			/* SELECT 'End of recordset' AS endRecsMsg; */
			CLOSE date_format_cursor;
			LEAVE date_format_cursor_loop;
		END IF; /* end_recordset - rest of loop is effectively an ELSE */

			/* debug: shows that the VIEWs are composed of correct data, 
			even though FETCH has data for only very first date this was called with - 
            it fails to advance */
			SET @thisSQL = CONCAT('SELECT * FROM C2gdf');
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SELECT strDebug AS fetchFail; 
            /* end debuggers */

		/* if this_format_name is valid and we haven't appended it to the output, do so; 
			separating with semicolon if not first item  */
		IF 	this_format_name <> '' AND this_format_name IS NOT NULL AND NOT INSTR(format_name, this_format_name) THEN 
			IF date_format_ticker <> 1 THEN SET format_name = CONCAT(format_name, '; ', this_format_name); 
				ELSE SET format_name = CONCAT(this_format_name);
			END IF; /* date_format_ticker */
			ELSEIF this_format_name = '' THEN SET strDebug = CONCAT(strDebug, ' ; this_format_name IS EMPTY STRING');
			ELSEIF this_format_name IS NULL THEN SET strDebug = CONCAT(strDebug, ' ; this_format_name IS NULL');
		END IF; /* this_format_name */
		
		/* next same for this_raw, rawIssueData: valid? append if not already, separating with semicolon if not first item */
		IF 	this_raw <> '' AND this_raw IS NOT NULL AND NOT INSTR(rawIssueData, this_raw) THEN 
			IF date_format_ticker <> 1 THEN SET rawIssueData = CONCAT(rawIssueData, ' ; ', this_raw);
				ELSE SET rawIssueData = CONCAT(this_raw); 
			END IF; /* date_format_ticker */
		END IF; /* this_raw */            

		SET date_format_ticker = date_format_ticker + 1;
		
	END LOOP; /* date_format_cursor_loop */

	SET strDebug = CONCAT(strDebug, ' afterWhile completed ', CAST(date_format_ticker AS CHAR), ' passes) for \'', this_issue_date, '\' ; format_name = ', format_name, ' ; rawIssueData = ', rawIssueData); 
	SELECT strDebug AS C2get_date_formats_done;

	SET @thisSQL = CONCAT('DROP TEMPORARY TABLE C2gdf;');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET @thisSQL = CONCAT('DROP VIEW C2multiFormatIssues;');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C2publication_issues_per_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `C2publication_issues_per_org`(
	IN this_pub_id TEXT,
    IN this_org_id TEXT
)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfile_name	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE org_title			TEXT; /* similar, for org */
    DECLARE org_issue_count_for_date	INT;	DECLARE org_issue_count_distinct	INT;
    DECLARE format_count_distinct_for_date	INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */

    /* vars used in cursor */
    DECLARE this_issue_date DATE;
    DECLARE count_inserted_this_issue_date INT;
    DECLARE org_issue_ticker INT;
    DECLARE this_rawIssueData TEXT;
    /* DECLARE this_org_id TEXT; */
    DECLARE this_format TEXT;
    DECLARE this_format_id TEXT;

    DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */

    /* declare cursors only after variables */
	DECLARE org_issue_cursor CURSOR FOR /* VIEW created below */
		SELECT issue_date, rawIssueData, format_name FROM C2pub_issues_per_org;

	/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();

	/* set uniform titles for pub and org */
	CALL build_uniform_title( this_pub_id, @uniform_title );
    CALL build_org_title( this_org_id, @org_title );

	SET output_table_name = 'C2publication_issues_per_org';
	SET totalExecutionTimer = CONCAT('C2publication_issues_per_org: ', @uniform_title, ', ', @org_title,' ; from ', CAST(totalExecutionBegin AS CHAR), '-');
	SELECT totalExecutionTimer AS step1;

	SET messagePrefix = '';

	/* new 2016-05-25 : first, clean the old data from output_table_name */
	SET @C2_SQL = CONCAT('DELETE FROM ', output_table_name, ' WHERE pub_id = "', this_pub_id, '" AND org_id = "', this_org_id, '" ');
	SELECT @C2_SQL AS C2_CLEAN_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @C2_SQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; 
    

	SET insertClause = concat('INSERT INTO ', output_table_name, '( org_id, org_title, pub_id, pub_title, ');
	SET insertClause = CONCAT(insertClause, 'org_issue_count_distinct, issue_date, org_issue_count_for_date, ');
	SET insertClause = CONCAT(insertClause, 'format_count_distinct_for_date, format_name, rawIssueData ) VALUES ');
	/* SELECT insertClause AS C2insert; */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C2pub_issues_per_org AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT i.issue_date, i.rawIssueData, i.format_id, ');
    SET @thisSQL = CONCAT(@thisSQL, 'f.format_name ');
    SET @thisSQL = CONCAT(@thisSQL, 'FROM issues i ');
    SET @thisSQL = CONCAT(@thisSQL, 'INNER JOIN formats f ON f.format_id = i.format_id ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', this_pub_id ,'\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = \'', this_org_id ,'\' ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY i.issue_date, f.format_name );');
	SELECT @thisSQL AS C2pub_issues_per_orgSQL;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(messagePrefix, 'CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS C2pub_issues_per_orgVIEW;


		/* how many DISTINCT ISSUE DATES this title/this org?
			- outside of WHILE here because it only needs to be done once  */
	SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date ) INTO @org_issue_count_distinct FROM C2pub_issues_per_org;');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT issue_date) INTO @org_issue_count_distinct = ', CAST(@org_issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS org_iss_count_distinct;


IF @org_issue_count_distinct > 0 THEN /* go through each one */

SET strDebug = 'About to begin cursor ...';
OPEN org_issue_cursor;
org_issue_cursor_loop: LOOP

	FETCH org_issue_cursor INTO this_issue_date, this_rawIssueData, this_format;

	IF end_recordset THEN
		/* SELECT 'End of recordset' AS endRecsMsg; */
		CLOSE org_issue_cursor;
		LEAVE org_issue_cursor_loop; /* no issues this pub/this org: skip rest of loop */
	END IF; /* end_of_recordset*/

    /* begin with recordset */

		/* did we already put this_issue_date in the output table? */
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @count_inserted_this_issue_date FROM ', output_table_name, ' ');
        SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date = \'', this_issue_date, '\' ');
        SET @thisSQL = CONCAT(@thisSQL, 'AND pub_id = \'', this_pub_id, '\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = \'', this_org_id, '\' ');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('CHECK for this issue date ', CAST(@count_inserted_this_issue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer AS count_inserted_this_iss_date; */

		IF @count_inserted_this_issue_date > 0 THEN
			SET @format_name = '';
			SET @rawIssueData = '';
			ITERATE org_issue_cursor_loop; /* skip rest of loop */
		END IF;

        /* else we have not put this_issue_date into output_table_name for this pub, this org:
			continue */

			/* how many TOTAL ISSUES this title/this org FOR THIS DATE? */
		SET @thisSQL = CONCAT('SELECT COUNT( issue_date ) INTO @org_issue_count_for_date ');
        SET @thisSQL = CONCAT(@thisSQL, 'FROM C2pub_issues_per_org WHERE issue_date = \'', this_issue_date, '\' ');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(messagePrefix, 'SELECT COUNT(DISTINCT issue_date) INTO @org_issue_count_for_date = ', CAST(@org_issue_count_for_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer AS org_iss_count_for_date; */

		/* how many distinct FORMATS for this date? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct_for_date ');
		SET @thisSQL = CONCAT(@thisSQL, 'FROM C2pub_issues_per_org WHERE issue_date = \'', this_issue_date, '\' ;');
		SET queryExecutionBegin = CURRENT_TIME();
    PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('did COUNT(DISTINCT format_id) > @format_count_distinct_for_date = ', CAST(@format_count_distinct_for_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer AS format_ct_distinct_for_date; */

		SET @format_name = '';
		SET @rawIssueData = '';
		/*
			C2get_date_formats goes through issues for that date ;
			concatenates format names + rawIssueData (sets @format_name, @rawIssueData)
		*/
		CALL C2get_date_formats(this_pub_id, this_issue_date, this_org_id, @format_name, @rawIssueData);
		SELECT CONCAT('main C2 rcvd from C2get_date_formats: format_name: ', @format_name, ' ; raw: ', @rawIssueData) AS backInMain;

		/* perform the INSERT */
		SET @thisSQL = CONCAT(insertClause, ' (\'', this_org_id, '\', "', @org_title, '", \'', this_pub_id, '\', "', @uniform_title, '", ');
		SET @thisSQL = CONCAT(@thisSQL, @org_issue_count_distinct, ', \'', this_issue_date, '\', ', @org_issue_count_for_date, ', ');
		SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct_for_date, ', "', @format_name, '", "', @rawIssueData, '"');
		SET @thisSQL = CONCAT(@thisSQL, ');');
		SELECT CAST(@thisSQL AS CHAR) AS C2publication_issues_per_org_INSERT;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(messagePrefix, 'INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer AS post_insert_queryExecutionTimer;

	END LOOP org_issue_cursor_loop;
ELSE
	SET strDebug = CONCAT('NO pub details or INSERT to ', output_table_name, ' for ', CAST(@org_issue_count_distinct AS CHAR), ' issues of ', @uniform_title, ' held by ', @org_title, '.');
    SELECT strDebug;
END IF; /* this_org_id holds dates for this_pub_id */
    /* SELECT strDebug AS loopOutput; */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW C2pub_issues_per_org;');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

	/* show output table during dev
	SET @thisSQL = 'SELECT * FROM C2publication_issues_per_org';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	*/

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C3publications_per_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `C3publications_per_org`(
	IN this_org_id TEXT
)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
    DECLARE loop_ticker INT;

	DECLARE org_pubs_view	TEXT;
	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into output_table_name */
	DECLARE org_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
	DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
	DECLARE MINissue_date	DATE;	DECLARE MAXissue_date	DATE;
	DECLARE org_rawIssueData TEXT; /* empty string if there are valid MIN/MAX dates, else filled with issues.rawIssueData */

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

    DECLARE org_issues_count INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */

  DECLARE this_view_name TEXT;

	DECLARE this_pub_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR
	/* SELECT pub_id FROM org_pubs_view ORDER BY pub_id;
		# there is some weirdness with not quite being able to get authentic dynamic SQL for the cursor;
        # might fail, or might read from a previous run
    */
	/* original failing on LIVE
	SELECT DISTINCT pub_id FROM issues WHERE org_id = this_org_id; */
    /* but test next: hangs on entering loop
	SELECT DISTINCT pub_id FROM issues WHERE org_id COLLATE utf8_unicode_ci = this_org_id COLLATE utf8_unicode_ci;
    */
	SELECT DISTINCT pub_id FROM issues WHERE org_id = this_org_id COLLATE utf8_unicode_ci;


/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();

		/* org_title needs to be set just once : it's like a uniform title */
	CALL build_org_title( this_org_id, @org_title );
	SELECT @org_title AS have_org_title;

	SET totalExecutionTimer = CONCAT('C3publications_per_org: ', @org_title, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET output_table_name 	= 'C3publications_per_org';
	SET org_pubs_view 	= CONCAT('C3publications_per_org_temp_view'); /* can't use org_id because it might have an @ character */

	SET insertClause = CONCAT('INSERT INTO ', output_table_name, '( org_id, org_title, pub_id, pub_title, ');
    SET insertClause = CONCAT(insertClause, 'org_issues_count, MINissue_date, MAXissue_date, ');
    SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'org_rawIssueData, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, ');
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');

/* new 2016-05-17 : first, clean the old data from output_table_name */
	SET @C3_SQL = CONCAT('DELETE FROM C3publications_per_org WHERE org_id = "', this_org_id, '" '); 
	SELECT @C3_SQL AS C3_CLEAN_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @C3_SQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; 

/* create a view to look up ISSUES values */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', org_pubs_view, ' AS ');
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT DISTINCT pub_id FROM issues WHERE org_id = "', this_org_id ,'" ');
    SET @thisSQL = CONCAT(@thisSQL, ' ORDER BY pub_id ;');
	/* SELECT @thisSQL as C3create; */
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(@org_title, ': CREATE VIEW: org_pubs_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;

		/* test for number of valid publications */
	SET @thisSQL = CONCAT('SELECT COUNT(*)  FROM ', org_pubs_view, ' INTO @org_pubs_count;');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(@org_title, ' has ', CAST(@org_pubs_count AS CHAR), ' titles');
	SELECT queryExecutionTimer AS num_pubs_in_org;

	SET strDebug = "";
IF @org_pubs_count > 0 THEN
	SET loop_ticker = 1;
	/* SELECT CONCAT("C3: entered if org_pubs_count with ", @org_pubs_count, ", and loop_ticker = ", CAST(loop_ticker AS CHAR)) AS C3if_org_pubs_count;    */
	OPEN pubs_cursor;
	/* SELECT CONCAT("C3: opened pubs_cursor") AS C3opened_pub_cursor; */
	pubs_cursor_loop: WHILE end_recordset = 0 DO
	/* SELECT CONCAT("C3: into pubs_cursor_loop") AS C3pubs_cursor_loop; */
		FETCH pubs_cursor INTO this_pub_id;
		/* SELECT CONCAT("C3: this_pub_id = ", this_pub_id) AS C3fetched_pub_cursor; */

		IF end_recordset THEN
			SELECT 'End of recordset' AS endRecsMsg;
			CLOSE pubs_cursor;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
		ELSE

			CALL build_uniform_title( this_pub_id, @uniform_title );
			/* SELECT CONCAT("at uniform_title = ", @uniform_title) AS C3got_uniform_title; */

			SET strDebug = CONCAT(CAST(loop_ticker AS CHAR), ' of ', CAST(@org_pubs_count AS CHAR),' for ', this_org_id ,') ', this_pub_id, ' = ', @uniform_title, '; ');
			SELECT strDebug AS pubs_cursor_strDebug; 

			/* create a view to look up ISSUES values */
			SET this_view_name = CONCAT('C3issues_view_', TRIM(this_pub_id), '_', this_org_id);
			SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ( ');
			SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = "', TRIM(this_pub_id) ,'" ');
			/* SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' '); # all isues have valid dates now */
			SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date, format_id );');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('CREATE VIEW: ', this_view_name, ': ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer AS create_view_ISS_in_loop; */

/* # debug block 
SELECT "debug block; waiting for sn77020239";
IF this_pub_id LIKE '%sn77020239%' THEN 
	SET @thisSQL = CONCAT('SELECT * FROM ', this_view_name, ';');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
END IF;
# end debug block */

			/* fill the values to be inserted in the output table */

			/* how many distinct ISSUES held by this organization? */
			SET @org_issues_count = -1;
			CALL get_org_issues_count_for_pub(this_pub_id, this_org_id, @org_issues_count);
            SET strDebug = CONCAT(strDebug, '@ org_issues_count=', CAST(@org_issues_count AS CHAR), '; ');
			/* SELECT strDebug AS C3org_issues_count_check; */

				/*
					what are the first and last dates held for this title?
                    - null dates are handled in get_issue_MINMAX_for_org
                */
			CALL get_issue_MINMAX_for_org(this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, @org_rawIssueData);
			/* SELECT CONCAT(strDebug, '@ MIN date: ', CAST(@MINissue_date AS CHAR), ', @ MAX date: ', CAST(@MAXissue_date AS CHAR), ', @ raw: ', @org_rawIssueData) AS GOTminmax; */

				/* how many distinct ISSUE DATES for this title? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date ) INTO @issue_count_distinct FROM ', this_view_name, ' ;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

				/* how many distinct FORMATS for this year? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM  ', this_view_name, ' ;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */


			/* get the number of issues in each format for this_pub_id held by this_org_id */
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
			CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);

			/*
			END FORMATS
			TOTAL NUMBER OF ISSUES IN THE YEAR? is the same as the total of all the formats, so:  */
			SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;
			/* perform the INSERT */
			SET @thisSQL = CONCAT(insertClause, ' ("', this_org_id, '", "', @org_title, '", "', this_pub_id, '", "', @uniform_title, '", ');
			SET @thisSQL = CONCAT(@thisSQL, @org_issues_count, ', \'', @MINissue_date, '\', \'', @MAXissue_date, '\', ');
            SET @thisSQL = CONCAT(@thisSQL, issue_count_total, ', ', @issue_count_distinct, ', "', @org_rawIssueData, '", ');
			SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
									@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
									@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
									@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
									@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
									@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
			SET @thisSQL = CONCAT(@thisSQL, ');');
			/* SELECT CAST(@thisSQL AS CHAR) AS C3publications_per_org_INSERT; */
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			SET @thisSQL = CONCAT('DROP VIEW ', this_view_name, ';');
      PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
      /* we don't need it now */

			SET loop_ticker = loop_ticker + 1;
			/* end ELSE: there were publications in this country */
		END IF; /* end_of_recordset*/
	END WHILE pubs_cursor_loop;
ELSE
	SET strDebug = CONCAT('NOT getting pub details for ', CAST(@org_pubs_count AS CHAR), ' publications ; NO INSERT to ', output_table, '.');
END IF;/* there are publications in this country */
SELECT strDebug AS exit_loop_with;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', org_pubs_view, ';');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C3publications_per_org_fill_single_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `C3publications_per_org_fill_single_pub`(
	IN this_org_id TEXT, 
	IN this_pub_id TEXT
)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
    DECLARE loop_ticker INT;

	DECLARE this_view_name	TEXT;
	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into output_table_name */
	DECLARE org_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
	DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
	DECLARE MINissue_date	DATE;	DECLARE MAXissue_date	DATE;
	DECLARE org_rawIssueData TEXT; /* empty string if there are valid MIN/MAX dates, else filled with issues.rawIssueData */

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

    DECLARE org_issues_count INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */

/* end declaring variables */

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();
	SET strDebug = CONCAT('C3publications_per_org_fill_single_pub("', this_org_id, '", "', this_pub_id, '") ');
	SELECT strDebug AS C3publications_per_org_fill_single_pub_start;

		/* org_title needs to be set just once : it's like a uniform title */
	CALL build_org_title( this_org_id, @org_title );
	SELECT @org_title AS have_org_title;
	
	CALL build_uniform_title( this_pub_id, @uniform_title );
    SELECT @uniform_title AS have_uniform_title; 

	SET totalExecutionTimer = CONCAT('C3publications_per_org_fill_single_pub: ', @org_title, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');


	SET output_table_name 	= 'C3publications_per_org';
	SET this_view_name 	= CONCAT(output_table_name, '_fill_single_publication_', this_pub_id); /* can't use org_id because it might have an @ character */

	SET insertClause = CONCAT('INSERT INTO ', output_table_name, '( org_id, org_title, pub_id, pub_title, ');
    SET insertClause = CONCAT(insertClause, 'org_issues_count, MINissue_date, MAXissue_date, ');
    SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'org_rawIssueData, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, ');
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');

	/* new 2016-05-17 : first, clean the old data from output_table_name */
	SET @C3_SQL = CONCAT('DELETE FROM ', output_table_name, ' WHERE org_id = "', this_org_id, '" AND pub_id = "', this_pub_id, '" ');
	SELECT @C3_SQL AS C3_CLEAN_SQL;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @C3_SQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; 

/* create a view to look up ISSUES values */
SELECT this_view_name;
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = "', TRIM(this_pub_id) ,'" ');
		/* SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' '); # all isues have valid dates now */
		SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = "', this_org_id, '" ');
		SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date, format_id );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('CREATE VIEW: ', this_view_name, ': ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer AS create_view_ISS_in_loop; 

/* # debug block 
SELECT "debug block; waiting for sn77020239";
IF this_pub_id LIKE '%sn77020239%' THEN 
	SET @thisSQL = CONCAT('SELECT * FROM ', this_view_name, ';');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
END IF;
# end debug block */

		/* fill the values to be inserted in the output table */

		/* how many distinct ISSUES held by this organization? */
		SET @org_issues_count = -1;
		CALL get_org_issues_count_for_pub(this_pub_id, this_org_id, @org_issues_count);
        /* SELECT CONCAT('@ org_issues_count=', CAST(@org_issues_count AS CHAR), '; ') AS C3org_issues_count_check; */

			/*
				what are the first and last dates held for this title?
                  - null dates are handled in get_issue_MINMAX_for_org
              */
		CALL get_issue_MINMAX_for_org(this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, @org_rawIssueData);
		/* SELECT CONCAT(strDebug, '@ MIN date: ', CAST(@MINissue_date AS CHAR), ', @ MAX date: ', CAST(@MAXissue_date AS CHAR), ', @ raw: ', @org_rawIssueData) AS GOTminmax; */

			/* how many distinct ISSUE DATES for this title? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date ) INTO @issue_count_distinct FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; */

			/* how many distinct FORMATS for this year? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM  ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; */

		/* get the number of issues in each format for this_pub_id held by this_org_id */
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
		CALL get_format_count_this_pub_this_org( this_pub_id, this_org_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);

		/*
		END FORMATS
		TOTAL NUMBER OF ISSUES IN THE YEAR? is the same as the total of all the formats, so:  */
		SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;
		/* perform the INSERT */
		SET @thisSQL = CONCAT(insertClause, ' ("', this_org_id, '", "', @org_title, '", "', this_pub_id, '", "', @uniform_title, '", '); 
        /* SET @thisSQL = CONCAT(insertClause, ' ("@@@", "', @org_title, '", "', this_pub_id, '", "', @uniform_title, '", '); */
		SET @thisSQL = CONCAT(@thisSQL, @org_issues_count, ', \'', @MINissue_date, '\', \'', @MAXissue_date, '\', ');
          SET @thisSQL = CONCAT(@thisSQL, issue_count_total, ', ', @issue_count_distinct, ', "', @org_rawIssueData, '", ');
		SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
								@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
								@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
								@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
								@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
								@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
		SET @thisSQL = CONCAT(@thisSQL, ');');
		SELECT CAST(@thisSQL AS CHAR) AS C3publications_per_org_fill_single_pub_INSERT; 
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer; 


	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', this_view_name, ';');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C4compare_org_holdings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `C4compare_org_holdings`(
	IN org_id_1 VARCHAR(20),
    IN org_id_2 VARCHAR(20),
    IN boolSendToOutfile TEXT
)
BEGIN

DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

DECLARE org_title_1 TEXT; /* uniform title for organizations */
DECLARE org_title_2 TEXT;


/**************** end declarations **************/

SET outfileName = CONCAT('/home/mysql/tmp/C4compare_org_holdings_', org_id_1, '_', org_id_2, '.csv');


DROP TABLE IF EXISTS OrgFirst ;
DROP TABLE IF EXISTS OrgSecond ;
DROP TABLE IF EXISTS FirstResultSet ;
DROP TABLE IF EXISTS SecondResultSet ;

CALL build_org_title( org_id_1, @org_title_1 );
CALL build_org_title( org_id_2, @org_title_2 );
SELECT CONCAT('searching titles held by ', @org_title_1, ' ** OR ** ', @org_title_2) AS C4compare_for_ORGS;


CREATE TEMPORARY TABLE  OrgFirst (INDEX(pub_id)) AS
 /* SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS held_by_org_1 */
 SELECT DISTINCT p.pub_id, p.OCLC,
	CONCAT(p.pub_title, ' (', p.pub_city, ', ', c.country_name, ' : ', COALESCE(p.pub_bgnDate, ''), '-', COALESCE(p.pub_endDate, ''), ')') AS uniform_title,
    org_id_1 AS held_by_org_1
 FROM publications p
 INNER JOIN issues i
 ON p.pub_id = i.pub_id
 INNER JOIN countries c
 ON c.country_id = p.country_id
 WHERE i.org_id = org_id_1 /* COLLATE utf8_unicode_ci */ ;
SELECT CONCAT('1) Created temp table for org_id_1: ', org_id_1) AS tempTable1;


CREATE TEMPORARY TABLE  OrgSecond (INDEX(pub_id)) AS
 /* SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS held_by_org_2 */
 SELECT DISTINCT p.pub_id, p.OCLC,
	CONCAT(p.pub_title, ' (', p.pub_city, ', ', c.country_name, ' : ', COALESCE(p.pub_bgnDate, ''), '-', COALESCE(p.pub_endDate, ''), ')') AS uniform_title,
    org_id_2 AS held_by_org_2
 FROM publications p
 INNER JOIN issues i
 ON p.pub_id = i.pub_id
 INNER JOIN countries c
 ON c.country_id = p.country_id
 WHERE org_id = org_id_2 /* COLLATE utf8_unicode_ci */ ;
SELECT CONCAT('2) Created temp table for org_id_2: ', org_id_2) AS tempTable2;


CREATE TEMPORARY TABLE FirstResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.uniform_title, held_by_org_1, held_by_org_2
 FROM OrgFirst a
 LEFT JOIN OrgSecond b
 ON a.pub_id = b.pub_id;

CREATE TEMPORARY TABLE SecondResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.uniform_title, held_by_org_1, held_by_org_2
 FROM OrgSecond a
 LEFT JOIN OrgFirst b
 ON a.pub_id = b.pub_id;


	SET @thisSQL = CONCAT('SELECT pub_id, OCLC, uniform_title, held_by_org_1, held_by_org_2 ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM FirstResultSet ');
	SET @thisSQL = CONCAT(@thisSQL, 'UNION ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT pub_id, OCLC, uniform_title, held_by_org_1, held_by_org_2 ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM SecondResultSet ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY uniform_title ');

/* sometimes results to outfile */
IF boolSendToOutfile = 'outfile' THEN
	SET @thisSQL = CONCAT(@thisSQL, 'INTO OUTFILE \'', outfileName, '\' CHARACTER SET utf8 FIELDS TERMINATED BY \'|\' LINES TERMINATED BY \'\\n\'');
    SELECT @thisSQL AS next_is_outfile;
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SELECT CONCAT('outfile: ', outfileName, ' completed; exiting.\n');
/* sometimes results to screen */
ELSE
	SELECT @thisSQL AS next_is_results_to_screen;
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
END IF;

SELECT CONCAT('C4compare_org_holdings completed; exiting.\n');

DROP TABLE IF EXISTS OrgFirst ;
DROP TABLE IF EXISTS OrgSecond ;
DROP TABLE IF EXISTS FirstResultSet ;
DROP TABLE IF EXISTS SecondResultSet ;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C5common_org_holdings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `C5common_org_holdings`(
/* CREATE PROCEDURE `C5common_org_holdings`( */
	IN org_id_1 VARCHAR(20),
    IN org_id_2 VARCHAR(20),
    IN boolSendToOutfile TEXT
)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE org_title_1 TEXT; /* uniform title for organizations */
	DECLARE org_title_2 TEXT;

/**************** end declarations **************/

SET outfileName = CONCAT('/home/mysql/tmp/C5common_org_holdings_', org_id_1, '_', org_id_2, '.csv');

SET totalExecutionBegin = CURRENT_TIME();
SET totalExecutionTimer = CONCAT('C5common_org_holdings: ', org_id_1, '+', org_id_2, ': from ', CAST(totalExecutionBegin AS CHAR), '-');


DROP TEMPORARY TABLE IF EXISTS OrgFirst ;
DROP TEMPORARY TABLE IF EXISTS OrgSecond ;
DROP VIEW IF EXISTS CommonResultSet ;

CALL build_org_title( org_id_1, @org_title_1 );
CALL build_org_title( org_id_2, @org_title_2 );
SELECT CONCAT('C5common_org_holdings: searching titles held by ', @org_title_1, ' ** AND ** ', @org_title_2) AS C5common_org_holdings;


	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW OrgFirst AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT DISTINCT p.pub_id, p.OCLC, ');
	SET @thisSQL = CONCAT(@thisSQL, 'CONCAT(p.pub_title, \' (\', p.pub_city, \', \', c.country_name, \' : \', COALESCE(p.pub_bgnDate, \'\'), \'-\', COALESCE(p.pub_endDate, \'\'), \')\') AS uniform_title, ');
	SET @thisSQL = CONCAT(@thisSQL, '\'', org_id_1, '\' AS held_by_org_1 ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p INNER JOIN issues i ON p.pub_id = i.pub_id ');
	SET @thisSQL = CONCAT(@thisSQL, 'INNER JOIN countries c ON c.country_id = p.country_id ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.org_id = \'', org_id_1, '\' ');
	SET @thisSQL = CONCAT(@thisSQL, '); ');
	/* SELECT @thisSQL AS org1SQL; */
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('org1 VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;


	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW OrgSecond AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT DISTINCT p.pub_id, p.OCLC, ');
	SET @thisSQL = CONCAT(@thisSQL, 'CONCAT(p.pub_title, \' (\', p.pub_city, \', \', c.country_name, \' : \', COALESCE(p.pub_bgnDate, \'\'), \'-\', COALESCE(p.pub_endDate, \'\'), \')\') AS uniform_title, ');
	SET @thisSQL = CONCAT(@thisSQL, '\'', org_id_2, '\' AS held_by_org_2 ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p INNER JOIN issues i ON p.pub_id = i.pub_id ');
	SET @thisSQL = CONCAT(@thisSQL, 'INNER JOIN countries c ON c.country_id = p.country_id ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.org_id = \'', org_id_2, '\' ');
	SET @thisSQL = CONCAT(@thisSQL, '); ');
	/* SELECT @thisSQL AS org2SQL; */
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('org2 VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;



/** works but takes a bit too long ********************************************
CREATE TEMPORARY TABLE CommonResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.uniform_title, held_by_org_1, held_by_org_2
 FROM OrgFirst a
 LEFT JOIN OrgSecond b
 ON a.pub_id = b.pub_id
 WHERE a.held_by_org_1 = org_id_1 AND b.held_by_org_2 = org_id_2;
*******************************************************************************/

/* try common results as VIEW to try speed up:
	it did not make it any faster */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW CommonResultSet AS ( ');
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT a.pub_id, a.OCLC, a.uniform_title, a.held_by_org_1, b.held_by_org_2 ');
    SET @thisSQL = CONCAT(@thisSQL, 'FROM OrgFirst a ');
    SET @thisSQL = CONCAT(@thisSQL, 'LEFT JOIN OrgSecond b ');
    SET @thisSQL = CONCAT(@thisSQL, 'ON a.pub_id = b.pub_id ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE a.held_by_org_1 = \'', org_id_1, '\' AND b.held_by_org_2 = \'', org_id_2, '\' ');
	SET @thisSQL = CONCAT(@thisSQL, ') ;');
	/* SELECT @thisSQL; */
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CommonResultSet VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;

	SET @thisSQL = CONCAT('SELECT pub_id, OCLC, uniform_title, held_by_org_1, held_by_org_2 ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM CommonResultSet ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY uniform_title ');
    SET queryExecutionBegin = CURRENT_TIME();

/* sometimes results to outfile */
IF boolSendToOutfile = 'outfile' THEN
	SET @thisSQL = CONCAT(@thisSQL, 'INTO OUTFILE \'', outfileName, '\' CHARACTER SET utf8 FIELDS TERMINATED BY \'|\' LINES TERMINATED BY \'\\n\'');
    SELECT @thisSQL AS next_is_outfile;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('OUTFILE FROM view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
	SELECT CONCAT('outfile: ', outfileName, ' completed; exiting.\n');
ELSE	
	/* sometimes results to screen */
    SELECT @thisSQL AS next_is_results_to_screen;
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT FROM view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
    
END IF;

DROP TEMPORARY TABLE IF EXISTS OrgFirst ;
DROP TEMPORARY TABLE IF EXISTS OrgSecond ;
SET @thisSQL = CONCAT('DROP VIEW CommonResultSet');
/* SELECT CONCAT(@thisSQL, ' is next'); */
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;
/* SELECT CONCAT(@thisSQL, ' completed'); */

SELECT CONCAT('C5common_org_holdings completed; exiting.\n');

SET totalExecutionEnd = CURRENT_TIME();
SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
SELECT totalExecutionTimer;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `C8publication_issues_dupe_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `C8publication_issues_dupe_status`(
/* CREATE PROCEDURE `C8publication_issues_dupe_status`( */
	IN this_pub_id TEXT
)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;


	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE strUniformTitleConcat TEXT; /* various pieces of SQL to enhance readability */
    DECLARE summarySelectClause TEXT;
    DECLARE joinStatement TEXT;
	DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE uniform_title TEXT;

/**************** end declarations **************/

SET outfileName = CONCAT('/home/mysql/tmp/C8publication_issues_dupe_status_', this_pub_id, '.csv');

SET totalExecutionBegin = CURRENT_TIME();
SET totalExecutionTimer = CONCAT('C8publication_issues_dupe_status: from ', CAST(totalExecutionBegin AS CHAR), '-');


DROP TEMPORARY TABLE IF EXISTS OrgFirst ;
DROP TEMPORARY TABLE IF EXISTS OrgSecond ;
DROP VIEW IF EXISTS CommonResultSet ;

CALL build_uniform_title( this_pub_id, @uniform_title );
SELECT CONCAT('C8publication_issues_dupe_status: for ', @uniform_title) AS C8publication_issues_dupe_status;

SET strUniformTitleConcat = 'CONCAT(p.pub_title, \' (\', p.pub_city, \', \', c.country_name, \' : \', COALESCE(p.pub_bgnDate, \'\'), \'-\', COALESCE(p.pub_endDate, \'\'), \')\') AS uniform_title ';

SET summarySelectClause = 'SELECT \'0000-00-00\' AS issue_date, ';
SET summarySelectClause = CONCAT(summarySelectClause, 'CAST(COUNT(*) AS CHAR) AS num_orgs_holding, ');
SET summarySelectClause = CONCAT(summarySelectClause, '\'multiple-holder issues\' AS dupe_status, ');
SET summarySelectClause = CONCAT(summarySelectClause, '\'see details for orgs\' AS org_id_name, ');
SET summarySelectClause = CONCAT(summarySelectClause, '\'see details for formats\' AS holds_format, ');
SET summarySelectClause = CONCAT(summarySelectClause, 'p.pub_id, ');
SET summarySelectClause = CONCAT(summarySelectClause, strUniformTitleConcat);


SET joinStatement = 'INNER JOIN countries c ON c.country_id = p.country_id ';
SET joinStatement = CONCAT(joinStatement, 'INNER JOIN issues i ON p.pub_id = i.pub_id ');
SET joinStatement = CONCAT(joinStatement, 'INNER JOIN organizations o ON o.org_id = i.org_id ');
SET joinStatement = CONCAT(joinStatement, 'INNER JOIN formats f ON f.format_id = i.format_id ');
SELECT joinStatement;


/********************* main VIEW for all the non-zero issues for this_pub_id **/
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C8issues AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT CAST(i.issue_date AS CHAR) AS issue_date, ');
    SET @thisSQL = CONCAT(@thisSQL, 'CAST(COUNT(*) AS CHAR) AS num_orgs_holding, ');
	SET @thisSQL = CONCAT(@thisSQL, 'IF(COUNT(*) = 1, \'unique\', \'multiple holders\') AS dupe_status, ');
	SET @thisSQL = CONCAT(@thisSQL, 'CONCAT(i.org_id, \': \', o.org_name) AS first_alpha_holder, ');
	SET @thisSQL = CONCAT(@thisSQL, 'f.format_name AS holds_format, ');
	SET @thisSQL = CONCAT(@thisSQL, 'p.pub_id, ');
    SET @thisSQL = CONCAT(@thisSQL, strUniformTitleConcat);
    SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p ');
    SET @thisSQL = CONCAT(@thisSQL, joinStatement, ' ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.pub_id = \'', this_pub_id, '\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND i.issue_date <> \'0000-00-00'' ');
/* GROUP BY is what can find the dupes */
	SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY i.issue_date ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY i.issue_date, i.org_id, i.format_id ');
    SET @thisSQL = CONCAT(@thisSQL, ') ');
	SELECT @thisSQL; 
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('C8issues VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */


/* always results to screen */
	SET @thisSQL = CONCAT('SELECT issue_date, num_orgs_holding, dupe_status, first_alpha_holder, holds_format, pub_id, uniform_title ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM C8issues ORDER BY issue_date ');
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT FROM view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */




/********************* VIEW for SUMMARY of COUNTS: TOTALS OF DUPES and UNIQUES **/
/* there was some problem that prevented doing a UNION VIEW so they are separate here and UNION comes below */
SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C8issueMULTIPLE_SUMMARY AS ( ');
SET @thisSQL = CONCAT(@thisSQL, summarySelectClause, ' ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p ');
SET @thisSQL = CONCAT(@thisSQL, joinStatement, ' ');
SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.pub_id = \'', this_pub_id, '\' ');
SET @thisSQL = CONCAT(@thisSQL, 'AND i.issue_date IN ( SELECT issue_date FROM C8issues WHERE num_orgs_holding > 1 ) ');
SET @thisSQL = CONCAT(@thisSQL, ' ) ');
/* SELECT @thisSQL AS C8issueMULTIPLE_SUMMARYql; */
SET queryExecutionBegin = CURRENT_TIME();
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;
SET queryExecutionEnd = CURRENT_TIME();
SET queryExecutionTimer = CONCAT('C8issueMULTIPLE_SUMMARYql ran: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
/* SELECT queryExecutionTimer; */
/* now UNIQUE issue dates */
SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C8issueUNIQUE_SUMMARY AS ( ');
SET @thisSQL = CONCAT(@thisSQL, REPLACE(summarySelectClause, 'multiple-holder issues', 'unique issues'), ' ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p ');
SET @thisSQL = CONCAT(@thisSQL, joinStatement, ' ');
SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.pub_id = \'', this_pub_id, '\' ');
SET @thisSQL = CONCAT(@thisSQL, 'AND i.issue_date <> \'0000-00-00\' ');
SET @thisSQL = CONCAT(@thisSQL, 'AND i.issue_date NOT IN ( SELECT issue_date FROM C8issues WHERE num_orgs_holding > 1 ) ');
SET @thisSQL = CONCAT(@thisSQL, ' ) ');
/* SELECT @thisSQL AS C8issueUNIQUE_SUMMARYsql; */
SET queryExecutionBegin = CURRENT_TIME();
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;
SET queryExecutionEnd = CURRENT_TIME();
SET queryExecutionTimer = CONCAT('C8issueUNIQUE_SUMMARYsql ran: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
/* SELECT queryExecutionTimer; */


/* SELECT for BOTH SUMMARIES below in a UNION with the DUPES and UNIQUE issue dates */




/********************* VIEW for DUPE issues that are held by MULTIPLE orgs **/
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C8issueMULTIPLE AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT CAST(i.issue_date AS CHAR) AS issue_date, ');
    SET @thisSQL = CONCAT(@thisSQL, '\'> 1\' AS num_orgs_holding, ');
    SET @thisSQL = CONCAT(@thisSQL, '\'multiple holders\' AS dupe_status, ');
	SET @thisSQL = CONCAT(@thisSQL, 'CONCAT(i.org_id, \': \', o.org_name) AS org_id_name, ');
	SET @thisSQL = CONCAT(@thisSQL, 'f.format_name AS holds_format, ');
	SET @thisSQL = CONCAT(@thisSQL, 'p.pub_id, ');
    SET @thisSQL = CONCAT(@thisSQL, strUniformTitleConcat);
    SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p ');
    SET @thisSQL = CONCAT(@thisSQL, joinStatement, ' ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.pub_id = \'', this_pub_id, '\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date IN ( SELECT issue_date FROM C8issues WHERE num_orgs_holding > 1 ) ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY i.issue_date, i.org_id, i.format_id ');
    SET @thisSQL = CONCAT(@thisSQL, ') ');
	/* SELECT @thisSQL AS C8VIEWdupeDetailsSQL; */
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	/* SET queryExecutionTimer = CONCAT('C8VIEWdupeDetailsSQL ran: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.'); */

	/* SELECT for DUPES below in a UNION with the SUMMARY and UNIQUE issue dates */


/********************* VIEW for UNIQUE issues that are held by SINGLE org **/
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C8issueUNIQUE AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT CAST(i.issue_date AS CHAR) AS issue_date, ');
    /* SET @thisSQL = CONCAT(@thisSQL, 'COUNT(*) AS num_orgs_holding_UNIQ, '); */
    SET @thisSQL = CONCAT(@thisSQL, '\'1\' AS num_orgs_holding, ');
    SET @thisSQL = CONCAT(@thisSQL, '\'unique\' AS dupe_status, ');
	SET @thisSQL = CONCAT(@thisSQL, 'CONCAT(i.org_id, \': \', o.org_name) AS org_id_name, ');
	SET @thisSQL = CONCAT(@thisSQL, 'f.format_name AS holds_format, ');
	SET @thisSQL = CONCAT(@thisSQL, 'p.pub_id, ');
    SET @thisSQL = CONCAT(@thisSQL, strUniformTitleConcat);
    SET @thisSQL = CONCAT(@thisSQL, 'FROM publications p ');
    SET @thisSQL = CONCAT(@thisSQL, joinStatement, ' ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE i.pub_id = \'', this_pub_id, '\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date NOT IN ( SELECT issue_date FROM C8issues WHERE num_orgs_holding > 1 ) ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY i.issue_date, i.org_id, i.format_id ');
    SET @thisSQL = CONCAT(@thisSQL, ') ');
	/* SELECT @thisSQL AS C8UNIQUEdetailsSQL; */
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('C8UNIQUEdetailsSQL ran: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

	/* SELECT for SUMMARY, MULTIPLES and UNIQUES */
    SET @thisSQL = CONCAT('SELECT * FROM C8issueMULTIPLE_SUMMARY ');
    SET @thisSQL = CONCAT(@thisSQL, ' UNION ');
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM C8issueUNIQUE_SUMMARY ');
	SET @thisSQL = CONCAT(@thisSQL, ' UNION ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM C8issueMULTIPLE ');
    SET @thisSQL = CONCAT(@thisSQL, ' UNION ');
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM C8issueUNIQUE ');
    SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date');
	/* SELECT @thisSQL AS C8SELECTuniqueDetailsSQL;  */
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('C8SELECTuniqueDetailsSQL ran: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

SET @thisSQL = CONCAT('DROP VIEW C8issues');
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;

SET @thisSQL = CONCAT('DROP VIEW C8issueMULTIPLE_SUMMARY');
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;

SET @thisSQL = CONCAT('DROP VIEW C8issueUNIQUE_SUMMARY');
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;

SET @thisSQL = CONCAT('DROP VIEW C8issueMULTIPLE');
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;

SET @thisSQL = CONCAT('DROP VIEW C8issueUNIQUE');
PREPARE thisStatement FROM @thisSQL;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;

SET totalExecutionEnd = CURRENT_TIME();
SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
SELECT totalExecutionTimer;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_date_range` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `check_date_range`( 
	IN date_checked DATE, 
    IN date_min_boundary DATE, 
    IN date_max_boundary DATE, 
	INOUT return_value INT
)
BEGIN 
	DECLARE output_message TEXT;
/* must do all declarations before can set any value  */
	SET return_value = -1;
    IF 
		date_checked BETWEEN date_min_boundary AND date_max_boundary 
        OR 
        (date_checked = date_min_boundary) OR (date_checked = date_max_boundary)
	THEN 
		SET return_value = 1;
    ELSE 
		SET return_value = 0;
    END IF;
	SELECT CONCAT('check_date_range(', CAST(date_checked AS CHAR), ', ',  CAST(date_min_boundary AS CHAR),', ',  CAST(date_max_boundary AS CHAR),') return_value = ', CAST(return_value AS CHAR), '.') 
    AS check_date_range_result; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `chooseFormerOrCurrentFrequency` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `chooseFormerOrCurrentFrequency`(
	INOUT thisIssueDate 		DATE,
	IN prevIssueDate				DATE,
	IN dateFormerFreqStop 	DATE,
	IN dateCurrentFreqStart DATE,
	IN myFormerFreqFULL TINYTEXT,
	IN myFormerFreqID 	TINYTEXT,
	IN myFreqFULL 			TINYTEXT,
	IN myFreqID 				TINYTEXT,
	INOUT thisFreqFULL 	TINYTEXT,
	INOUT thisFreqID 		TINYTEXT
)
BEGIN
	DECLARE strDebugChFQ TEXT;

	SET strDebugChFQ = 'chooseFormerOrCurrentFrequency: ';
	SET strDebugChFQ = CONCAT( strDebugChFQ, '\nthisIssueDate ', thisIssueDate, '; prevIssueDate ', prevIssueDate, '; ...\n');
SET strDebugChFQ = CONCAT( strDebugChFQ, 'dateFormerFreqStop ', dateFormerFreqStop, '; dateCurrentFreqStart ', dateCurrentFreqStart, '; ...\n');
	SELECT strDebugChFQ; 

	IF thisIssueDate < dateFormerFreqStop THEN /* use FORMER frequency */
		SET thisFreqFULL 	= myFormerFreqFULL;
		SET thisFreqID 		= myFormerFreqID;
		SET strDebugChFQ = CONCAT( strDebugChFQ, '\nIF block, use FORMER: thisIssueDate=', thisIssueDate, ', dateCurrentFreqStart=', dateCurrentFreqStart, '; ...\n');
		SELECT strDebugChFQ; 
	ELSEIF thisIssueDate > dateCurrentFreqStart AND prevIssueDate <= dateFormerFreqStop THEN /* we stepped past bgn date of new frequency */
		SET thisIssueDate = dateCurrentFreqStart; /* put thisIssueDate back to dateCurrentFreqStart */
		SET thisFreqFULL 	= myFreqFULL; /* use CURRENT frequency */
		SET thisFreqID 		= myFreqID;
		SET strDebugChFQ = CONCAT( strDebugChFQ, '\nELSEIF RESET 1) thisIssueDate=', thisIssueDate, ' bc went past ', dateCurrentFreqStart, '; ...\n');
		SELECT strDebugChFQ; 
	ELSE /* use CURRENT frequency */
		SET thisFreqFULL 	= myFreqFULL;
		SET thisFreqID 		= myFreqID;
		SET strDebugChFQ = CONCAT( strDebugChFQ, '\nELSE block, use CURRENT: thisIssueDate=', thisIssueDate, ', dateCurrentFreqStart=', dateCurrentFreqStart, '; ...\n');
		SELECT strDebugChFQ; 
	END IF;

	SET strDebugChFQ = CONCAT( strDebugChFQ, '\nfinish with thisFreqFULL=', thisFreqFULL, '; thisFreqID=', thisFreqID, '; \n');
	SELECT strDebugChFQ;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COMBINEdupeTitles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `COMBINEdupeTitles`(
    IN  survivor_pub_id TEXT        /* name of table or base name of set of tables where NEW issue records are going */
)
BEGIN
		DECLARE strSQL TEXT;
		DECLARE pub_idClause TEXT;
		DECLARE whereClause TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE strDebug	TEXT;   /* holds debugging info */
	/* end declarations */


		SELECT * FROM publications WHERE pub_id LIKE 'CBN%';  /* MAKE SURE THERE AREN'T ANY */

		SET pub_idClause = CONCAT('SET pub_id = "', survivor_pub_id, '"');
		SET whereClause = CONCAT(' WHERE pub_id LIKE \'CBN%\'; ');

/* first few tables are only on the DEV server */
		SET @strSQL = CONCAT( 'UPDATE issuesNEW ', pub_idClause, whereClause);
		/* SELECT @strSQL AS iNEW;  /* # just debugging */
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

/*
# removed these tables
		SET @strSQL = CONCAT( 'UPDATE issuesBUFFER ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesLargeRepos ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesCRL ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
*/


		SET @strSQL = CONCAT( 'UPDATE issuesNEW ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesNEWxaa ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesNEWxab ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;


		SET @strSQL = CONCAT( 'UPDATE pub_frequencies ', pub_idClause, whereClause);
		/* SELECT @strSQL AS iBUFFER;  /* # just debugging */
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

/*		SET @strSQL = CONCAT( 'UPDATE issuesJUNKtest ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement; */



/* these tables are in Amazon Web Services LIVE server */
		SET @strSQL = CONCAT( 'UPDATE issues ', pub_idClause, whereClause);
		/* SELECT @strSQL AS issuesUPDATER;  /* # just debugging */
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

			/* target field is different here: relationship_from_pub_id */
		SET pub_idClause = CONCAT(' SET relationship_from_pub_id = "', survivor_pub_id, '"');
		SET whereClause = CONCAT(' WHERE relationship_from_pub_id LIKE \'CBN%\'; ');
		SET @strSQL = CONCAT( 'UPDATE bib_relationships SET relationship_from_pub_id = "', survivor_pub_id, '"', whereClause);
		/* SELECT @strSQL AS bibRels;  /* # just debugging */
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		DELETE FROM publications WHERE pub_id LIKE 'CBN%';  /* REMOVE dupes */

		SELECT * FROM publications WHERE pub_id LIKE 'CBN%'; /* show that there's none */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CONSOLIDATEdupeTitles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `CONSOLIDATEdupeTitles`(
    IN  survivor_pub_id TEXT        /* name of table or base name of set of tables where NEW issue records are going */
)
BEGIN
		DECLARE strSQL TEXT;
		DECLARE pub_idClause TEXT;
		DECLARE whereClause TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE strDebug	TEXT;   /* holds debugging info */
	/* end declarations */


		SELECT * FROM publications WHERE pub_id LIKE 'RMV%';  /* MAKE SURE THERE AREN'T ANY */

		SET pub_idClause = CONCAT('SET pub_id = "', survivor_pub_id, '"');
		SET whereClause = CONCAT(' WHERE pub_id LIKE \'RMV%\'; ');

/* first few tables are only on the DEV server */
/************************************** 2015-05-22: these tables no longer exist
		SET @strSQL = CONCAT( 'UPDATE issuesNEW ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesNEW ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesNEWxaa ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE issuesNEWxab ', pub_idClause, whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
# END : these tables no longer exist **************************************/

		SET @strSQL = CONCAT( 'UPDATE pub_frequencies ', pub_idClause, whereClause);
		/* SELECT @strSQL AS iBUFFER;  /* # just debugging */
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

/* these tables are in local TSWEBDEV development server */
		SET @strSQL = CONCAT( 'UPDATE issues ', pub_idClause, whereClause);
		/* SELECT @strSQL AS issuesUPDATER;  /* # just debugging */
		PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE zerodate_issues ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE A1issues_per_publication ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE A2issues_per_organization ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE C2publication_issues_per_org ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE C3publications_per_org ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE D1publications_per_title ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE D2publications_suspected_dupes ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		SET @strSQL = CONCAT( 'UPDATE pub_collections ', pub_idClause, whereClause);
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

			/* target field is different here: relationship_from_pub_id */
		SET pub_idClause = CONCAT(' SET relationship_from_pub_id = "', survivor_pub_id, '"');
		SET whereClause = CONCAT(' WHERE relationship_from_pub_id LIKE \'RMV%\'; ');
		SET @strSQL = CONCAT( 'UPDATE bib_relationships SET relationship_from_pub_id = "', survivor_pub_id, '"', whereClause);
		/* SELECT @strSQL AS bibRels;  /* # just debugging */
    PREPARE thisStatement FROM @strSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		DELETE FROM publications WHERE pub_id LIKE 'RMV%';  /* REMOVE dupes */

		SELECT * FROM publications WHERE pub_id LIKE 'RMV%'; /* show that there's none */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createIssueProcessMonitor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `createIssueProcessMonitor`(
    IN myTARGETtableName TEXT       
)
BEGIN
		DECLARE strTblBase TEXT; 
		DECLARE strTblSuffix TEXT;
		DECLARE intTblNum INT UNSIGNED;

		DECLARE strSQL TEXT;
		DECLARE thisStatement TEXT; 
	
		DECLARE numRecs 		INT UNSIGNED; 
		DECLARE max_issue_id 	INT UNSIGNED;
		DECLARE strIssueNote 	TEXT;
		
		DECLARE strDebug	TEXT;   
		DECLARE output 		TEXT; 
	

		
		SET intTblNum = 0;
		SET strTblSuffix = "";
		CALL getTableSuffix(intTblNum, strTblSuffix); 
		SET output = CONCAT('cIPM: begin intTblNum=', intTblNum, ') myTARGETtableName="', myTARGETtableName, '", strTblSuffix="', strTblSuffix, '"\n');

		SET strTblBase = myTARGETtableName; 
		SET myTARGETtableName = CONCAT(strTblBase, strTblSuffix);




		WHILE intTblNum < 6 DO 

			
			

			CALL getNumRecs(myTARGETtableName, numRecs); 
			SET output = CONCAT(output, strTblSuffix, '|', @numRecs); 

			
			CALL getMaxIssueID(myTARGETtableName, max_issue_id); 
			
			SET @strSQL = CONCAT('SELECT issue_note INTO @strIssueNote FROM ', myTARGETtableName, ' WHERE issue_id = ', @max_issue_id, ';');
			
			PREPARE thisStatement FROM @strSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET output = CONCAT(output, '|', @strIssueNote);

			
			CALL getTableSuffix(intTblNum, strTblSuffix); 
			SET myTARGETtableName = CONCAT(strTblBase, strTblSuffix);
			
			
			

			SET output = CONCAT(output, '\n');
		END WHILE;

		
		SELECT output AS createIssueProcessMonitor;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createNewIssue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `createNewIssue`(
    IN  mySOURCEtableName TEXT,       /* name of table where existing issue_id comes from: our source for pub_id etc. needed for initializeIssueRecordValues() */
    IN  input_issue_id INT UNSIGNED, /* issue_id from mySOURCEtableName */
    IN  firstIssueDate DATE, /* first issue date to insert */
    IN  lastIssueDate DATE,
    IN  myTARGETtableName TEXT /* name of table where NEW issue records should be created: needed for insertThisIssue() */
)
BEGIN
            /* data from existing fields in mother record */
		DECLARE myPubID, myOrgID, myConditionID, myFormat, myFormatID, myArchiveID, myProvenanceID, myIssueNote TINYTEXT;

		DECLARE strSQL TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		DECLARE myFreqFULL 						TINYTEXT; /* get freq_id_code from publications, below */
		DECLARE myFreqID        			TINYTEXT; /* MARC-compliant freq_id_code (fixed field), first letter of myFreqFULL */
		DECLARE myFreq310data       	TINYTEXT; /* value of publications.frequency310 */
		DECLARE myFormerFreqFULL 			TINYTEXT; /* former_freq_id_code in publications */
		DECLARE myFormerFreqID				TINYTEXT; /* MARC-compliant frequency code, fixed-field style sgl letter matching for 321 data */
		DECLARE myFormerFreq321data 	TEXT; 		/* value of publications.formerFrequency321 */
		DECLARE dateFormerFreqStop 		DATE; 		/* up to this date, use FORMER (MARC 321) frequency */
		DECLARE dateCurrentFreqStart 	DATE; 		/* from this date, use CURRENT (most recent, MARC 310) frequency */
		DECLARE thisFreqFULL 					TINYTEXT; /* thisFreq* will be versions used on any given pass through loop */
		DECLARE thisFreqID 						TINYTEXT;

		DECLARE thisIssueDate 	DATE; /* new specific date for issue_date field */
		DECLARE prevIssueDate 	DATE; /* from most recent issue added */

		DECLARE bPerformInsert	TINYINT;
		DECLARE thisWeekdayNum		INT;
			/* 	thisWeekdayNum is weekday number for thisIssueDate;
			used to set value of bPerformInsert (whether thisIssueDate should be added or skipped, for ex., if it's a weekend for a weekday-only publication, then skip) */
		DECLARE thisMonthNum		INT; /* similar idea + use as thisWeekdayNum */

		DECLARE dateDiff        INT;        /* num days btw most recent issue added, and next  */
		DECLARE dateSpread      INT;        /* num days required to keep looping below */

		DECLARE new_issue_id INT UNSIGNED;
		DECLARE max_issue_id INT UNSIGNED;

		DECLARE strDebug        TEXT;   /* holds debugging info */

    /************* end DECLARE, only now can we SET *************/

		SET strDebug = CONCAT( "createNewIssue: mySOURCETableName='", mySOURCETableName, "'; myTARGETtableName='", myTARGETtableName, "'\n");
		SET strDebug = CONCAT( strDebug, " WITH @ SIGNS TO initializeIssueRecordValues");
		SET strDebug = CONCAT( strDebug, ", input_issue_id=", input_issue_id, "; " );
		/* SELECT strDebug; */
		CALL initializeIssueRecordValues(
		  mySOURCEtableName, input_issue_id,
		  myPubID, myOrgID, myConditionID, myFormat, myFormatID, myArchiveID, myProvenanceID, myIssueNote
		);

		SET strDebug = CONCAT("createNewIssue: next is insertThisIssue(myTARGETtableName=", myTARGETtableName, ", ATmyPubID=", @myPubID);
		/* firstIssueDate, ", myOrgID=", myOrgID, ", myConditionID=", myConditionID, ", myFormat=", myFormat, ", myFormatID=", myFormatID, ", myArchiveID=", myArchiveID, ", myIssueNote=", myIssueNote, ")" ); */
		/* SELECT strDebug; */


		/* insertThisIssue with myTARGETtableName PLUS initialized values to insert record for firstIssueDate, 1st date passed in */
		CALL insertThisIssue(
		  myTARGETtableName,
		  @myPubID, firstIssueDate, @myOrgID, @myConditionID, @myFormat, @myFormatID, @myArchiveID, @myProvenanceID, @myIssueNote
		);

			/* call helper procedures to set vars before WHILE loop */
		CALL fillFrequencies( mySOURCEtableName, input_issue_id,
			myFormerFreqFULL,	myFormerFreqID, myFormerFreq321data,
			myFreqFULL, myFreqID, myFreq310data
		);
			/* SELECT CONCAT( strDebug, 'next CALL extractFreqDate( "former", 	', @myFormerFreq321data, ') ...'); */
		CALL extractFreqDate( "former", 	@myFormerFreq321data, dateFormerFreqStop );
		CALL extractFreqDate( "current", 	@myFreq310data, dateCurrentFreqStart );
			/*
			SELECT CONCAT( '@myFormerFreqFULL=', @myFormerFreqFULL );
			SELECT CONCAT( '@myFormerFreqID=', @myFormerFreqID );
			SELECT CONCAT( '@myFreqFULL=', @myFreqFULL );
			SELECT CONCAT( '@myFreqID=', @myFreqID );
			SELECT CONCAT( 'dateFormerFreqStop=', dateFormerFreqStop );
			SELECT CONCAT( 'dateCurrentFreqStart=', dateCurrentFreqStart );
			*/

		CALL fixFreqStopStartDates( dateFormerFreqStop, dateCurrentFreqStart, firstIssueDate, lastIssueDate ); /* adjusts former + current if necc. */
			SET strDebug = CONCAT( 'AFTER CALL fixFreqStopStartDates: dateFormerFreqStop: ', dateFormerFreqStop, '; dateCurrentFreqStart: ', dateCurrentFreqStart, '; \n');
			SELECT strDebug;

		/* SET @strSQL = CONCAT('SELECT MAX(issue_date) INTO @prevIssueDate FROM ', myTARGETtableName, '; '); */
		SET @strSQL = CONCAT('SELECT MAX(issue_date) INTO @prevIssueDate FROM ', myTARGETtableName, ' WHERE issue_note = "',  @myIssueNote, '"; ');
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
			/*
			SET strDebug = CONCAT('did SELECT MAX...have @prevIssueDate = ', @prevIssueDate );
			SELECT strDebug;
			*/


		CALL chooseFormerOrCurrentFrequency( /* fills values of thisFreqFULL + thisFreqID */
			firstIssueDate,  /* send firstIssueDate for first call */
			@prevIssueDate,
			dateFormerFreqStop, dateCurrentFreqStart,
			@myFormerFreqFULL, @myFormerFreqID, @myFreqFULL, @myFreqID,
			thisFreqFULL, thisFreqID
		);

		SET thisIssueDate = firstIssueDate;
			SET strDebug = CONCAT( 'after chooseFormerOrCurrentFrequency thisFreqFULL=', thisFreqFULL, '; thisFreqID=', thisFreqID, '; ');
			SET strDebug = CONCAT( strDebug, 'and CALL advanceIssueDate( thisFreqID ', thisFreqID, ', firstIssueDate, ', firstIssueDate, ', and thisIssueDate will be set there)\n' );
		CALL advanceIssueDate( thisFreqID, firstIssueDate, thisIssueDate);  /* advance to next date of an issue; gives its own debug message */

		CALL setDateSpread( thisFreqID, dateSpread ); /* DIFFERENT: used to be 'myFreqID' when only concerned with CURRENT/most recent freq */
		SET dateDiff = DATEDIFF( lastIssueDate, @prevIssueDate ); /* subtracts second parameter from first */
			/* SET strDebug = CONCAT( strDebug, 'dateSpread=', dateSpread, '; dateDiff: ', lastIssueDate, 'minus', firstIssueDate, '=' , dateDiff, '; \n'); */
			SET strDebug = CONCAT( strDebug, 'dateSpread=', dateSpread, '; dateDiff: ', lastIssueDate, 'minus', @prevIssueDate, '=' , dateDiff, '; \n');
			SELECT strDebug AS dataCheckupBEFOREwhile;

			/* done with helper procedures
			NOW:
			WHILE we have dates btw lastIssueDate (submitted) and thisIssueDate (currently calculated):
    		- decide whether thisFreqID shd be former or current;
    		- decide whether to insert new record (date may be excluded by frequency)
    		- advance issue date vars, reset loop conditions dateDiff + dateSpread  */

/* was WHILE (dateDiff >= dateSpread) AND (thisIssueDate <= lastIssueDate) DO */
WHILE (dateDiff > dateSpread) AND (thisIssueDate < lastIssueDate) DO

			IF dateFormerFreqStop > firstIssueDate THEN /* former freq applies at some point in the date range */
				CALL chooseFormerOrCurrentFrequency( /* update thisFreqFULL + thisFreqID */
					thisIssueDate,  /* WAS firstIssueDate, now looping */
					@prevIssueDate, /* send prevIssueDate for these calls */
					dateFormerFreqStop, dateCurrentFreqStart,
					@myFormerFreqFULL, @myFormerFreqID, @myFreqFULL, @myFreqID,
					thisFreqFULL, thisFreqID
				);
			END IF;

			SET strDebug = CONCAT( 'WHILE: (dateDiff ', dateDiff, ' > dateSpread ', dateSpread, ') AND (thisIssueDate ', thisIssueDate, '< lastIssueDate ', lastIssueDate, ') ' );
			SET strDebug = CONCAT( strDebug, @myPubID, '.', input_issue_id, '.fmrFq:', @myFormerFreqID, '; freq:', @myFreqID, '; thisFreqID: ', thisFreqID, '\ndateDiff: ', lastIssueDate, 'minus', firstIssueDate, '=' , dateDiff, '; \n');
			SET strDebug = CONCAT( strDebug, '(thisIssueDate ', thisIssueDate, ' < dateFormerFreqStop ', dateFormerFreqStop, ')=', (thisIssueDate < dateFormerFreqStop), '; \n');
			SET strDebug = CONCAT( strDebug, '(thisIssueDate ', thisIssueDate, ' > dateCurrentFreqStart ', dateCurrentFreqStart, ')=', (thisIssueDate > dateCurrentFreqStart), '; \n');
			SET strDebug = CONCAT( strDebug, '(prevIssueDate ', @prevIssueDate, ' < dateFormerFreqStop ', dateFormerFreqStop, ')=',  (@prevIssueDate < dateFormerFreqStop) ,'; \n');
			SELECT strDebug AS dataCheckupINSIDEwhile;

			/* is this is an issue we should add? */
			SET bPerformInsert = 1; /* assume yes, want to insert this date */
			SET thisWeekdayNum = CAST( DAYOFWEEK(thisIssueDate) AS UNSIGNED );
			SET thisMonthNum	 = CAST( MONTH(thisIssueDate) AS UNSIGNED );
			SET strDebug = CONCAT( 'add this record? thisFreqFULL=', thisFreqFULL, ' thisFreqID=', thisFreqID, '; thisWeekdayNum=', thisWeekdayNum, '; thisMonthNum=', thisMonthNum, '; \n');
			/* SELECT strDebug AS insertionDecisionFactors; */

			IF LENGTH( thisFreqFULL ) > 1 THEN /* is non-standard (non-MARC) freq code, defined in icondata.frequencies */
					/* look for the EXCLUDED DAYOFWEEK or EXCLUDED MONTH in the long frequency code */
				IF	/* old conditions INSTR( thisFreqFULL, thisWeekdayNum ) OR INSTR( thisFreqFULL, thisMonthNum ) OR */
					((thisFreqID = 'd') AND INSTR( thisFreqFULL, thisWeekdayNum ))
					OR
					((thisFreqID = 'm') AND INSTR( thisFreqFULL, thisMonthNum ))
					OR
					( INSTR( thisFreqFULL, "+SY" ) AND (thisMonthNum >= 6 AND thisMonthNum <= 8) ) /* academic/School Year only: these pubs exclude months 6-8 */
				THEN
					/* DEVNOTE: FREQ CODES DO NOT YET EXCLUDE MONTHS (icondata.frequencies NOT SET FOR MONTHS) */
					/* DEVNOTE: HOLIDAY EXCLUSIONS NOT YET ACCOMODATED IN CODE */
					SET bPerformInsert = 0;
					/*
					SET strDebug = CONCAT( thisFreqFULL, ' date EXCLUDED; bPerformInsert: ', bPerformInsert, '; \n');
					SET strDebug = CONCAT( strDebug, 'now CALL advanceIssueDate( thisFreqID ', thisFreqID, ' @prevIssueDate ', @prevIssueDate, ' fill in  thisIssueDate), even when insertion not performed like when bPerformInsert=', bPerformInsert, '; \n');
					SELECT strDebug AS noInsertionMade;
					*/
				END IF;
			END IF;
			IF bPerformInsert THEN /* do insert: pass thisIssueDate, not firstIssueDate like before loop */
				CALL insertThisIssue(
					myTARGETtableName,
					@myPubID, thisIssueDate, @myOrgID, @myConditionID, @myFormat, @myFormatID, @myArchiveID, @myProvenanceID, @myIssueNote
				);
			END IF;

				/* prepare for next pass thru loop:
					- save prevIssueDate
					- advance thisIssueDate
					- update loop conditions
				*/

			/* prevIssueDate is used to calculate next date  */
			SET @strSQL = CONCAT('SELECT MAX(issue_date) INTO @prevIssueDate FROM ', myTARGETtableName, ' WHERE INSTR(issue_note,', input_issue_id, '); ');
			/* SELECT @strSQL AS maxIssDateSQL_inWhile; # just debugging */
			PREPARE thisStatement FROM @strSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
				/*
				SET strDebug = CONCAT('did maxIssDateSQL_inWhile... now CALL advanceIssueDate( thisFreqID ', thisFreqID, ', thisIssueDate, ', thisIssueDate, ', and thisIssueDate will be set there)' );
				SELECT strDebug;
				*/

			/* 2014-02-20: used to pass @prevIssueDate as 1st param here: fails when we didn't insert the issue */
			CALL advanceIssueDate( thisFreqID, thisIssueDate, thisIssueDate ); /* advance to next date of an issue; gives its own debug message */
				/* loop exit condition depends on these */
			SET dateDiff = DATEDIFF( lastIssueDate, @prevIssueDate );
			CALL setDateSpread( thisFreqID, dateSpread );

		END WHILE;

		/* IF last date passed in was not generated,  THEN insert issue record for that date */
		/* SET strDebug = CONCAT('\n\ngenerate last issue IF @prevIssueDate ', @prevIssueDate, ' <> lastIssueDate ', lastIssueDate, '; \n'); */
		IF @prevIssueDate <> lastIssueDate THEN
			CALL insertThisIssue( /* pass lastIssueDate instead of thisIssueDate like we did in loop */
				myTARGETtableName,
				@myPubID, lastIssueDate, @myOrgID, @myConditionID, @myFormat, @myFormatID, @myArchiveID, @myProvenanceID, @myIssueNote
			);
		END IF;
		/* SELECT strDebug; */

	/* 	get the ID of the last issue generated: */
	CALL getMaxIssueID(myTARGETtableName, max_issue_id);
	/* remove the rest of this when sure new SP call is working */
	/* SET @strSQL = CONCAT('SELECT MAX(issue_id) INTO @max_issue_id FROM ', myTARGETtableName, ';'); */
	/* SELECT @strSQL AS maxIssIDsql;  # just debugging */
	/*
	PREPARE thisStatement FROM @strSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	*/



	/* 	display information about that last issue */
	SET @strSQL = CONCAT('SELECT issue_id, pub_id, issue_date FROM ', myTARGETtableName, ' WHERE issue_id = ', @max_issue_id, ';');
	PREPARE thisStatement FROM @strSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	/* 	display information about the whole run just added */
	SET @strSQL = CONCAT('SELECT COUNT(*) AS totalAddedIssues FROM ', myTARGETtableName, ' WHERE issue_note = "', @myIssueNote, '" AND ((issue_date >= \'', firstIssueDate, '\') AND (issue_date <= \'', lastIssueDate, '\'));');
	PREPARE thisStatement FROM @strSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;



	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `D1publications_per_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `D1publications_per_title`(
	IN input_title TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
    DECLARE loop_ticker INT;

	DECLARE pub_titles_view	TEXT;
	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into output_table_name */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
	DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
	DECLARE MINissue_date	DATE;	DECLARE MAXissue_date	DATE;
	DECLARE org_rawIssueData TEXT; /* empty string if there are valid MIN/MAX dates, else filled with issues.rawIssueData */

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

    DECLARE pub_issues_count INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */

	DECLARE this_pub_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR
	/* SELECT pub_id FROM pub_titles_view ORDER BY pub_id; 
		# there is some weirdness with not quite being able to get authentic dynamic SQL for the cursor;
        # might fail, or might read from a previous run
    */
    SELECT DISTINCT pub_id FROM publications WHERE pub_title = input_title;
    

/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();

	SET totalExecutionTimer = CONCAT('D1publications_per_title: ', input_title, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET output_table_name 	= 'D1publications_per_title';
	SET pub_titles_view 	= CONCAT('D1publications_per_title_VIEW');

	SET insertClause = CONCAT('INSERT INTO ', output_table_name, '( input_title, pub_id, uniform_title, ');
    SET insertClause = CONCAT(insertClause, 'MINissue_date, MAXissue_date, ');
    SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, ');
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');


	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', pub_titles_view, ' AS '); 
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT pub_id FROM publications WHERE pub_title = "', input_title ,'" ');
    SET @thisSQL = CONCAT(@thisSQL, ' ORDER BY pub_city, country_id, pub_bgnDate;');
    SELECT CAST(@thisSQL AS CHAR) AS pub_titles_view;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(@uniform_title, ': CREATE VIEW: pub_titles_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS createView; 

		/* test for number of valid publications */
	SET @thisSQL = CONCAT('SELECT COUNT(*) FROM ', pub_titles_view, ' INTO @title_pubs_count;');
    /* SELECT @thisSQL AS title_pubs_countSQL; */
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(@uniform_title, ' has ', CAST(@title_pubs_count AS CHAR), ' titles');
	SELECT queryExecutionTimer AS title_pubs_count;

	SET strDebug = "";
IF @title_pubs_count > 0 THEN
	SET loop_ticker = 1;
	OPEN pubs_cursor;
	pubs_cursor_loop: WHILE end_recordset = 0 DO

		FETCH pubs_cursor INTO this_pub_id;

		IF end_recordset THEN
			SELECT 'End of recordset' AS endRecsMsg;
			CLOSE pubs_cursor;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
		ELSE

			CALL build_uniform_title( this_pub_id, @uniform_title );

			SET strDebug = CONCAT(CAST(loop_ticker AS CHAR), ') ', this_pub_id, ' = ', @uniform_title, '; ');
			/* SELECT strDebug AS pubs_cursor_strDebug; */

			/* create a view to look up ISSUES values */
			SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW issues_view AS ( ');
			SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', this_pub_id ,'\' ');
			SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' ');
			SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date, format_id );');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('CREATE VIEW: issues_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			/* fill the values to be inserted in the output table */

				/* what are the first and last dates held for this title?
                    - null dates are handled in get_issue_MINMAX_for_pub */
			CALL get_issue_MINMAX_for_pub(this_pub_id, @MINissue_date, @MAXissue_date);
			SELECT CONCAT(strDebug, '@ MIN date: ', CAST(@MINissue_date AS CHAR), ', @ MAX date: ', CAST(@MAXissue_date AS CHAR)) AS GOTminmax;

				/* how many distinct ISSUE DATES for this title? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date ) INTO @issue_count_distinct FROM issues_view;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

				/* how many distinct FORMATS for this title? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM issues_view;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */


			/* get the number of issues in each format for this year */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);

			/*
			END FORMATS
			TOTAL NUMBER OF ISSUES? is the same as the total of all the formats, so:  */
			SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;
			/* perform the INSERT */
			SET @thisSQL = CONCAT(insertClause, ' ("', input_title, '", "', this_pub_id, '", "', @uniform_title, '", ');
			SET @thisSQL = CONCAT(@thisSQL, '\'', @MINissue_date, '\', \'', @MAXissue_date, '\', ');
            SET @thisSQL = CONCAT(@thisSQL, issue_count_total, ', ', @issue_count_distinct, ', ');
			SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
									@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
									@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
									@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
									@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
									@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
			SET @thisSQL = CONCAT(@thisSQL, ');');
			/* SELECT CAST(@thisSQL AS CHAR) AS D1publications_per_title_INSERT; */
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			DROP VIEW issues_view;
			SET loop_ticker = loop_ticker + 1;
			/* end ELSE: there were publications in this country */
		END IF; /* end_of_recordset*/
	END WHILE pubs_cursor_loop;
ELSE
	SET strDebug = CONCAT('NOT getting pub details for ', CAST(@title_pubs_count AS CHAR), ' publications ; NO INSERT to ', output_table, '.');
END IF;/* there are publications in this country */
SELECT strDebug AS exit_loop_with;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit */
	SET @thisSQL = CONCAT('DROP VIEW ', pub_titles_view, ';');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `D2publications_suspected_dupes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `D2publications_suspected_dupes`(
	IN input_title TEXT,
    IN input_city TEXT,
    IN input_bgnDate TEXT,
    IN input_freq_id_code TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
    DECLARE loop_ticker INT;

	DECLARE pub_titles_view	TEXT;
	DECLARE outfileName	TEXT;	DECLARE output_table_name TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE input_title_data TEXT; /* blort together all the IN vars to save in 1 field */

		/* values extracted from the VIEW and INSERTED into output_table_name */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
	DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;
	DECLARE MINissue_date	DATE;	DECLARE MAXissue_date	DATE;
	DECLARE org_rawIssueData TEXT; /* empty string if there are valid MIN/MAX dates, else filled with issues.rawIssueData */

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

    DECLARE pub_issues_count INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
	DECLARE begin_date 	DATE; 	/* first date we search for */
	DECLARE this_year 	TEXT; 	/* the single year we will query for */
	DECLARE last_date 	DATE;	/* date we stop looping on */
	DECLARE end_date 	DATE;	/* last date we search for */

	DECLARE this_pub_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR /* view created below */
		SELECT DISTINCT pub_id FROM D2publications_suspected_dupes_VIEW;


/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET input_title_data = CONCAT(input_title, ' : ', input_city, ' (', input_bgnDate, ' freq: ', input_freq_id_code, ')');

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('D2publications_suspected_dupes: ', input_title_data, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET output_table_name 	= 'D2publications_suspected_dupes';
	SET pub_titles_view 	= CONCAT('D2publications_suspected_dupes_VIEW');

	SET insertClause = CONCAT('INSERT INTO ', output_table_name, '( input_title, pub_id, uniform_title, ');
    SET insertClause = CONCAT(insertClause, 'MINissue_date, MAXissue_date, ');
    SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_distinct, ');
    SET insertClause = CONCAT(insertClause, 'format_count_distinct, ');
    SET insertClause = CONCAT(insertClause, '1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
    SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
    SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
    SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');


	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', pub_titles_view, ' AS ');
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT pub_id FROM publications ');
    SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_title = "', input_title ,'" ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND pub_city = "', input_city, '" ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND pub_bgnDate = "', input_bgnDate, '" ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND freq_id_code = "', input_freq_id_code, '" ');
    SET @thisSQL = CONCAT(@thisSQL, ' ORDER BY pub_city, country_id, pub_bgnDate, freq_id_code;');
    SELECT CAST(@thisSQL AS CHAR) AS pub_titles_view;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(input_title_data, ': CREATE VIEW: pub_titles_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS createView;

		/* test for number of valid publications */
	SET @thisSQL = CONCAT('SELECT COUNT(*) FROM ', pub_titles_view, ' INTO @title_pubs_count;');
    /* SELECT @thisSQL AS title_pubs_countSQL; */
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(input_title_data, ' has ', CAST(@title_pubs_count AS CHAR), ' titles');
	SELECT queryExecutionTimer AS title_pubs_count;

	SET strDebug = "";
IF @title_pubs_count > 0 THEN
	SET loop_ticker = 1;
	OPEN pubs_cursor;
	pubs_cursor_loop: WHILE end_recordset = 0 DO

		FETCH pubs_cursor INTO this_pub_id;

		IF end_recordset THEN
			SELECT 'End of recordset' AS endRecsMsg;
			CLOSE pubs_cursor;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
		ELSE

			CALL build_uniform_title( this_pub_id, @uniform_title );

			SET strDebug = CONCAT(CAST(loop_ticker AS CHAR), ') ', this_pub_id, ' = ', @uniform_title, '; ');
			/* SELECT strDebug AS pubs_cursor_strDebug; */

			/* create a view to look up ISSUES values */
			SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW issues_view AS ( ');
			SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', this_pub_id ,'\' ');
			SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' ');
			SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY issue_date, format_id );');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('CREATE VIEW: issues_view: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			/* fill the values to be inserted in the output table */

				/* what are the first and last dates held for this title?
                    - null dates are handled in get_issue_MINMAX_for_pub */
			CALL get_issue_MINMAX_for_pub(this_pub_id, @MINissue_date, @MAXissue_date);
			SELECT CONCAT(strDebug, '@ MIN date: ', CAST(@MINissue_date AS CHAR), ', @ MAX date: ', CAST(@MAXissue_date AS CHAR)) AS GOTminmax;

				/* how many distinct ISSUE DATES for this title? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date ) INTO @issue_count_distinct FROM issues_view;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

				/* how many distinct FORMATS for this title? */
			SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM issues_view;');
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */


			/* get the number of issues in each format for this year */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
			CALL get_format_count_for_pub( this_pub_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);

			/*
			END FORMATS
			TOTAL NUMBER OF ISSUES? is the same as the total of all the formats, so:  */
			SET issue_count_total = @format_count_1 + @format_count_2 + @format_count_3 + @format_count_4 + @format_count_5 + @format_count_6 + @format_count_7 + @format_count_8 + @format_count_9 + @format_count_10 + @format_count_11 + @format_count_12 + @format_count_13 + @format_count_14 + @format_count_15;
			/* perform the INSERT */
			SET @thisSQL = CONCAT(insertClause, ' ("', input_title_data, '", "', this_pub_id, '", "', @uniform_title, '", ');
			SET @thisSQL = CONCAT(@thisSQL, '\'', @MINissue_date, '\', \'', @MAXissue_date, '\', ');
            SET @thisSQL = CONCAT(@thisSQL, issue_count_total, ', ', @issue_count_distinct, ', ');
			SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
									@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
									@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
									@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
									@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
									@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
			SET @thisSQL = CONCAT(@thisSQL, ');');
			/* SELECT CAST(@thisSQL AS CHAR) AS D2publications_suspected_dupes_INSERT; */
			SET queryExecutionBegin = CURRENT_TIME();
			PREPARE thisStatement FROM @thisSQL;
			EXECUTE thisStatement;
			DEALLOCATE PREPARE thisStatement;
			SET queryExecutionEnd = CURRENT_TIME();
			SET queryExecutionTimer = CONCAT('INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
			/* SELECT queryExecutionTimer; */

			DROP VIEW issues_view;
			SET loop_ticker = loop_ticker + 1;
			/* end ELSE: there were publications in this country */
		END IF; /* end_of_recordset*/
	END WHILE pubs_cursor_loop;
ELSE
	SET strDebug = CONCAT('NOT getting pub details for ', CAST(@title_pubs_count AS CHAR), ' publications ; NO INSERT to ', output_table, '.');
END IF;/* there are publications in this country */
SELECT strDebug AS exit_loop_with;

	SET strDebug = CONCAT('exited LOOP ; all insertions should be complete'); /* SELECT strDebug;  */

	/* release resources and exit
	SET @thisSQL = CONCAT('DROP VIEW ', pub_titles_view, ';');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
    */
    SELECT 'NOT DROPPING D2 DURING DEV' AS UNDROPPED_WARNING;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `D3_copy_pubs_fields_CONSOLIDATE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `D3_copy_pubs_fields_CONSOLIDATE`(
	IN	condemned_pub_id TEXT,
    IN  survivor_pub_id TEXT
)
BEGIN
		DECLARE thisSQL 		TEXT;
		DECLARE survivorSQL 	TEXT;
        DECLARE survivor_field_data TEXT;
        DECLARE condemnedSQL 	TEXT;
        DECLARE condemned_field_data TEXT;
        DECLARE survivor_NEW_field 	TEXT;
        DECLARE pub_idClause TEXT;
		DECLARE whereClause TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
		DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
		DECLARE strDebug	TEXT;   /* holds debugging info */
	/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('D3_copy_pubs_fields_CONSOLIDATE: ', condemned_pub_id, ' --> ', survivor_pub_id, ' ; from ', CAST(totalExecutionBegin AS CHAR), '-');

/*********************************************************************
   SAVE condemned.pub_id
*********************************************************************/
/*
  DOES condemned_pub_id START WITH 'oc' ? then look in survivor.OCLC for it
  - this is the only field where we have to make this check, elsewhere we just grab the matching fields
*/
IF condemned_pub_id LIKE 'oc%' THEN
	SET @survivorSQL = CONCAT('SELECT OCLC INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
ELSE
	SET @survivorSQL = CONCAT('SELECT marc001 INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
END IF;

SET @condemnedSQL = CONCAT('SELECT pub_id INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* is condemned_pub_id in survivor_pub_id.marc_001 (or OCLC) ? */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor p_id target:', @survivor_field_data, ' ; condemned pub_id:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS pub_id_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
	/* SELECT CONCAT(@condemned_field_data, ' NOT in ', @survivor_field_data, ': UPDATE is next') AS performUpdate; */
  IF condemned_pub_id LIKE 'oc%' THEN
    SET @thisSQL = CONCAT('UPDATE publications SET OCLC = "', survivor_NEW_field, '" WHERE pub_id = \'', survivor_pub_id, '\';');
  ELSE
  	SET @thisSQL = CONCAT('UPDATE publications SET marc001 = "', survivor_NEW_field, '" WHERE pub_id = \'', survivor_pub_id, '\';');
  END IF;

	SELECT @thisSQL AS newValue;
	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;



/*********************************************************************
   SAVE condemned.ISSN
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT ISSN INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT ISSN INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');
	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor ISSN:', @survivor_field_data, ' ; condemned ISSN:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS ISSN_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET ISSN = "', survivor_NEW_field, '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;


/*********************************************************************
   SAVE condemned.OCLC
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT OCLC INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT OCLC INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor OCLC:', @survivor_field_data, ' ; condemned OCLC:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS OCLC_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET OCLC = "', survivor_NEW_field, '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;


/*********************************************************************
   SAVE condemned.marc001
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT marc001 INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT marc001 INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor marc001:', @survivor_field_data, ' ; condemned marc001:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS  marc001_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET marc001 = "', survivor_NEW_field, '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;


/*********************************************************************
   SAVE condemned.numberingNote515
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT numberingNote515 INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT numberingNote515 INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor n515:', @survivor_field_data, ' ; condemned n515:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS  numberingNote515_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET numberingNote515 = "', REPLACE(survivor_NEW_field, '"', "'"), '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
  PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;






/*********************************************************************
   SAVE condemned.summary520
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT summary520 INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT summary520 INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor s520:', @survivor_field_data, ' ; condemned s520:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS  summary520_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET summary520 = "', REPLACE(survivor_NEW_field, '"', "'"), '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
  PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;




/*********************************************************************
   SAVE condemned.descriptionNote588
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT descriptionNote588 INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT descriptionNote588 INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor d588:', @survivor_field_data, ' ; condemned d588:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS  descriptionNote588_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET descriptionNote588 = "', REPLACE(survivor_NEW_field, '"', "'"), '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
  PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;


/*********************************************************************
   SAVE condemned.bib_relationships
*********************************************************************/
SET @survivorSQL = CONCAT('SELECT bib_relationships INTO @survivor_field_data FROM publications WHERE pub_id = \'', survivor_pub_id ,'\';');
SET @condemnedSQL = CONCAT('SELECT bib_relationships INTO @condemned_field_data FROM publications WHERE pub_id = \'', condemned_pub_id ,'\';');

	/* get survivor data */
	SET @thisSQL = @survivorSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	/* now get condemned field for compare */
	SET @thisSQL = @condemnedSQL;	PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionTimer = CONCAT('survivor bib_rel:', @survivor_field_data, ' ; condemned bib_rel:', @condemned_field_data, '.');
	SELECT queryExecutionTimer AS  bib_relationships_compare;

IF @survivor_field_data <> '' AND @survivor_field_data IS NOT NULL THEN /* append if survivor_field_data is valid */
  SET survivor_NEW_field = CONCAT(@survivor_field_data, ' ; ', @condemned_field_data);
ELSE
  SET survivor_NEW_field = @condemned_field_data;
END IF;

/* look for the condemned data in the survivor data */
IF NOT INSTR(@survivor_field_data, @condemned_field_data) THEN
  SET @thisSQL = CONCAT('UPDATE publications SET bib_relationships = "', REPLACE(survivor_NEW_field, '"', "'"), '" WHERE pub_id = \'', survivor_pub_id, '\';');
	SELECT @thisSQL AS newValue;
  PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement;
ELSE
	SELECT CONCAT(@condemned_field_data, ' ALREADY in ', @survivor_field_data, ': no need to change it to ', survivor_NEW_field) AS noUpdate;
END IF;


/*
  MARK THE CONDEMNED RECORD SO IT WILL BE CONSOLIDATED IN THE NEXT STEP
    CONSOLIDATEdupeTitles( survivor_pub_id )
      looks for pub_ids LIKE 'RMV%'
      moves all their issues and relationships to survivor_pub_id
      DELETES all the RMV titles
*/
SET @thisSQL = CONCAT('UPDATE publications SET pub_id = "RMV', condemned_pub_id, '" WHERE pub_id = \'', condemned_pub_id, '\';');
SELECT @thisSQL AS mark_condemned_for_death;
PREPARE thisStatement FROM @thisSQL;	EXECUTE thisStatement;	DEALLOCATE PREPARE thisStatement; 
CALL CONSOLIDATEdupeTitles(survivor_pub_id); /* THIS OTHER PROCEDURE MOVES ISSUES AND DELETES PUBLICATIONS */
/* SELECT concat('NOT CALLING CONSOLIDATEdupeTitles(', survivor_pub_id, ');') AS UNDONE_DEV_WARNING; */

  SET totalExecutionEnd = CURRENT_TIME();
  SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.'); 
  /* SELECT totalExecutionTimer; */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `expandMonthName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `expandMonthName`(
INOUT   monthname   TINYTEXT, 
INOUT	monthnumber INT
)
BEGIN
	SET monthname = SUBSTR(monthname, 1, 3); 
	CASE monthname
		WHEN "Jan" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(1, '%m'));
			SET monthnumber = 1;
		WHEN "Feb" THEN   
			SET monthname 	=	MONTHNAME(STR_TO_DATE(2, '%m'));
			SET monthnumber = 2;
		WHEN "Mar" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(3, '%m'));
			SET monthnumber = 3;
		WHEN "Apr" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(4, '%m'));
			SET monthnumber = 4;
		WHEN "May" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(5, '%m'));
			SET monthnumber = 5;
		WHEN "Jun" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(6, '%m'));
			SET monthnumber = 6;
		WHEN "Jul" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(7, '%m'));
			SET monthnumber = 7;
		WHEN "Aug" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(8, '%m'));
			SET monthnumber = 8;
		WHEN "Sep" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(9, '%m'));
			SET monthnumber = 9;
		WHEN "Oct" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(10, '%m'));
			SET monthnumber = 10;
		WHEN "Nov" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(11, '%m'));
			SET monthnumber = 11;
		WHEN "Dec" THEN   
			SET monthname 	= MONTHNAME(STR_TO_DATE(12, '%m'));
			SET monthnumber = 12;
		ELSE            
			SET monthname = CONCAT("'", monthname, "' is bad input to expandMonthName");
			SET monthnumber = -1;
	END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `extractFreqDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `extractFreqDate`(
IN 		freqType	TINYTEXT,
IN   	strData		TEXT,
INOUT 	freqDate 	DATE
)
BEGIN
		DECLARE strYear TINYTEXT;
		DECLARE monthname TINYTEXT;
		DECLARE monthnumber INT;
		DECLARE daynumber TINYTEXT;
		DECLARE strDebugExFqD TEXT;
		SET strDebugExFqD = CONCAT("extractFreqDate rcvd: '", freqType, "'='", strData, "'; \n");

			
		IF INSTR(strData, ", ") THEN 
			SET strData = SUBSTRING(strData, INSTR(strData, ", ")+2);
		END IF;
		IF INSTR(strData, "; ") THEN 
			SET strData = SUBSTRING(strData, 1, INSTR(strData, "; ")-1);
		END IF;
		SET strData = REPLACE( strData, "<", "" ); 
		SET strData = REPLACE( strData, ">", "" ); 
		SET strData = TRIM( strData );  

		SET strDebugExFqD = CONCAT(strDebugExFqD, "before dash cases strData now: '", strData, "'; \n");

		CASE INSTR(strData, "-")
			WHEN 1 THEN 
				SET strData = SUBSTRING(strData, 2,  LENGTH(strData)-1);
			WHEN LENGTH(strData) THEN 
				SET strData = SUBSTRING(strData, 1,  LENGTH(strData)-1);
			ELSE SET strData = strData;
		END CASE;
		IF INSTR(strData, "-") THEN 
			IF (freqType = "former") THEN 
				SET strData = SUBSTRING(strData, INSTR(strData, "-")+1);
			ELSE 
				SET strData = SUBSTRING(strData, 1, INSTR(strData, "-")-1);
			END IF;
		END IF;

		CASE INSTR(strData, "/")
			WHEN 5 THEN  SET strData = SUBSTR( strData, 6);
			ELSE SET strData = strData;
		END CASE;

		SET strDebugExFqD = CONCAT( strDebugExFqD, "before REGEXP checks: ", strData, "; \n");

			
		IF NOT (SELECT strData REGEXP '[0-9]') THEN 
			SET strDebugExFqD = CONCAT( strDebugExFqD, "NO NUMBER FOUND - will return '0000-00-00'; \n");
			SET strData = '0000-00-00';
		ELSE 
  		IF ((SELECT strData REGEXP '[A-Z][a-z][a-z] [0-9]*, [0-9][0-9][0-9][0-9]')
  		OR
  			(SELECT strData REGEXP '[A-Z][a-z][a-z]\. [0-9]*, [0-9][0-9][0-9][0-9]')
  		) THEN 
  			SET strDebugExFqD 	= CONCAT( strDebugExFqD, "strData REGEXP IF: Mmm. dd, yyyy; ");
  			SET strYear 	= SUBSTR(strData, LENGTH(strData)-3, 4 );
  			SET monthname 	= SUBSTR(strData, 1, 3);
  			CALL expandMonthName(monthname, monthnumber); 
  			SET daynumber 	= TRIM(SUBSTR(strData, INSTR(strData, ", ")-2, 2 ));
  			SET strData 	= CONCAT( strYear, "-", monthnumber, "-", daynumber);
  			SET strDebugExFqD 	= CONCAT( strDebugExFqD, "strYear='", strYear, "'; ", "got expandMonthName('", monthName, ",", monthnumber, "'); daynumber='", daynumber, "'; strData prepared:'", strData, "'; \n");
  		ELSEIF (SELECT strData REGEXP '[A-Z][a-z][a-z]\. [0-9][0-9][0-9][0-9]') THEN 
  			SET strDebugExFqD 	= CONCAT( strDebugExFqD, "strData REGEXP ELSEIF: Mmm. yyyy; ");
  			SET strYear 	= SUBSTR(strData, LENGTH(strData)-3, 4 );
  			SET monthname 	= SUBSTR(strData, 1, 4);
  			CALL expandMonthName(monthname, monthnumber); 
  			IF (freqType = "former") THEN
  				SET daynumber 	= LAST_DAY( CONCAT( strYear, "-", monthnumber, "-01" )); 
  			ELSE
  				SET daynumber 	= "-01"; 
  			END IF;
  			SET strData 	= CONCAT( strYear, "-", monthnumber, "-", daynumber);
  			SET strDebugExFqD 	= CONCAT( strDebugExFqD, "strYear='", strYear, "'; ", "got expandMonthName('", monthName, ",", monthnumber, "'); daynumber='", daynumber, "'; strData prepared:'", strData, "'; \n");
  		ELSEIF (SELECT strData REGEXP '[0-9][0-9][0-9][0-9]') THEN 
  			SET strDebugExFqD = CONCAT( strDebugExFqD, "; strData REGEXP ELSEIF: yyyy; ");
  			IF (freqType = "former") THEN
  				SET strData = CONCAT(strData, "-12-31"); 
  			ELSE
  				SET strData = CONCAT(strData, "-01-01"); 
  			END IF;
  		END IF;
		END IF; 

		IF (SELECT strData REGEXP '[0-9][0-9][0-9][0-9]') THEN 
			
			SET strData = REPLACE(strData, '--', '-');
		END IF;

		SET strDebugExFqD = CONCAT( strDebugExFqD, " end extractFreqDate reformatting with :'", strData, "'; next is STR_TO_DATE; ");
		SET freqDate = STR_TO_DATE(strData, '%Y-%m-%d');	
		SELECT strDebugExFqD;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `failed_date_check` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `failed_date_check`(
	IN date_checked DATE, 
    IN date_min_boundary DATE, 
    IN date_max_boundary DATE, 
    IN specific_message TEXT 
)
BEGIN 
	DECLARE b_write_to_logfile INT;
    DECLARE filename TEXT;
    DECLARE start_pos INT; DECLARE string_length INT; /* indexes for stripping a string */
	DECLARE output_message TEXT;
/* must do all declarations before can set any value  */

	SET b_write_to_logfile = -1;
    SET filename = '';
    SET start_pos = -1;
    SET string_length = -1;
	IF specific_message LIKE 'LOGFILE: %' THEN
		SET start_pos 		= LOCATE('#', specific_message)+1;
		SET string_length 	= LOCATE('#', specific_message, start_pos) - start_pos;
		/* SELECT start_pos; SELECT string_length; */
		SET filename = SUBSTR( specific_message, start_pos, string_length );
		/* SELECT filename AS failed_date_check_filename; */

		SET specific_message = REPLACE(specific_message, 'LOGFILE: ', '');
        SET specific_message = REPLACE(specific_message, '#', '');
		SET b_write_to_logfile = 1;
    END IF;

	SET output_message = CONCAT('FAILURE: ', specific_message, ' ; ', CAST(date_checked AS CHAR), ': is NOT between ', CAST(date_min_boundary AS CHAR), ' and ', CAST(date_max_boundary AS CHAR), ' ');

	/* SELECT output_message AS failed_date_check_result;  */
	
    IF b_write_to_logfile > 0 THEN 
		/* SELECT output_message AS failed_date_check_output_message; */
		CALL send_to_outfile( 'failure_', filename, 'sql', output_message );
	END IF;
        
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fillFrequencies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `fillFrequencies`(
		IN mySOURCEtableName TEXT,
        IN input_issue_id INT UNSIGNED, 
        INOUT myFormerFreqFULL TINYTEXT,
        INOUT myFormerFreqID TINYTEXT, 
		INOUT myFormerFreq321data TEXT, 
        INOUT myFreqFULL TINYTEXT,
        INOUT myFreqID TINYTEXT, 
		INOUT myFreq310data TINYTEXT 
)
BEGIN 
		DECLARE whereClause TEXT;
		DECLARE strSql TEXT;
        DECLARE thisStatement TEXT;
        DECLARE strDebugFillFQ TEXT;
		
		SET whereClause = CONCAT('WHERE pub_id IN ( SELECT pub_id FROM ', mySOURCEtableName, ' WHERE issue_id = ', input_issue_id, ' );');
        SET strDebugFillFQ = CONCAT('fillFrequencies...mySOURCEtableName=', mySOURCEtableName, ', input_issue_id=', input_issue_id, '; whereClause=', whereClause);
		

		
		SET @strSql = CONCAT('SELECT former_freq_id_code INTO @myFormerFreqFULL FROM publications ', whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		
		IF @myFormerFreqFULL IS NULL OR @myFormerFreqFULL = '-1' THEN 
			SET @myFormerFreqFULL = '-1';	
			SET @myFormerFreqID = '-1';
			
		ELSE 
			SET @myFormerFreqID = LEFT(@myFormerFreqFULL, 1);
			
		END IF;

		SET @strSql = CONCAT('SELECT freq_id_code INTO @myFreqFULL FROM publications ', whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		
		IF @myFreqFULL IS NULL THEN 
			SET @myFreqFULL = '-1';
			SET @myFreqID = '-1';
			
		ELSE 
			SET @myFreqID = LEFT(@myFreqFULL, 1);
			
		END IF;
		
		
		SET @strSql = CONCAT('SELECT formerFrequency321 INTO @myFormerFreq321data FROM publications ', whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		
		IF @myFormerFreq321data IS NULL THEN 
			SET @myFormerFreq321data = "";
			
		END IF;

		SET @strSql = CONCAT('SELECT frequency310 INTO @myFreq310data FROM publications ', whereClause);
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		
		IF @myFreq310data IS NULL THEN 
			SET @myFreq310data = "";
			
		END IF;

    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fixFreqStopStartDates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `fixFreqStopStartDates`(
INOUT dateFormerFreqStop DATE,
INOUT	dateCurrentFreqStart DATE,
IN firstIssueDate DATE,
IN lastIssueDate DATE
)
BEGIN
		DECLARE strDebugFFSSD TEXT;

		SET strDebugFFSSD = CONCAT('fixFreqStopStartDates: dateFormerFreqStop: ', dateFormerFreqStop, '; dateCurrentFreqStart: ', dateCurrentFreqStart, '; \n');
		IF dateFormerFreqStop = '0000-00-00' AND  dateCurrentFreqStart <> '0000-00-00' THEN 
			SET strDebugFFSSD = CONCAT( strDebugFFSSD, '...IF: dateFormerFreqStop IS BAD. SET IT TO ', dateCurrentFreqStart,' minus one day\n');
			SET dateFormerFreqStop = DATE_ADD( dateCurrentFreqStart, INTERVAL -1 DAY );
		ELSEIF dateFormerFreqStop <> '0000-00-00' AND  dateCurrentFreqStart = '0000-00-00' THEN 
			SET strDebugFFSSD = CONCAT( strDebugFFSSD, '...ELSEIF: dateCurrentFreqStart IS BAD. SET IT TO ', dateFormerFreqStop,' plus 1 \n');
			SET dateCurrentFreqStart = DATE_ADD( dateFormerFreqStop, INTERVAL 1 DAY );
		ELSEIF dateFormerFreqStop = '0000-00-00' AND  dateCurrentFreqStart = '0000-00-00' THEN 
			SET strDebugFFSSD = CONCAT( strDebugFFSSD, '...ELSE: BOTH ARE BAD. SET TO ', firstIssueDate,' minus one day, and ', firstIssueDate,' \n');
			SET dateFormerFreqStop = DATE_ADD( firstIssueDate, INTERVAL -1 DAY );
			SET dateCurrentFreqStart = firstIssueDate;
		END IF;

		

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMaxIssueID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getMaxIssueID`(
    IN  myTARGETtableName TEXT,       
	INOUT max_issue_id INT UNSIGNED
)
BEGIN
		DECLARE strSQL TEXT;
		DECLARE thisStatement TEXT; 
		DECLARE strDebug	TEXT;   
	

		
		SET @strSQL = CONCAT('SELECT MAX(issue_id) INTO @max_issue_id FROM ', myTARGETtableName, ';');
		
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNumRecs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getNumRecs`(
    IN  myTARGETtableName TEXT, 
	INOUT numRecs INT UNSIGNED 	
)
BEGIN
		DECLARE strSQL TEXT;
		DECLARE thisStatement TEXT; 
		DECLARE strDebug	TEXT;   
	

		
		SET @strSQL = CONCAT('SELECT COUNT(*) INTO @numRecs FROM ', myTARGETtableName, ';');
		
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTableSuffix` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getTableSuffix`(
	INOUT intTblNum INT UNSIGNED, 
	INOUT strTblSuffix TEXT
)
BEGIN
		DECLARE strDebug	TEXT;   
	

	SET strDebug = CONCAT('intTblNum=', intTblNum, '; strTblSuffix=', strTblSuffix, ';');

	SET intTblNum := intTblNum + 1;

	CASE intTblNum 
	
		
		WHEN 1 THEN SET strTblSuffix = 'xaa';
		WHEN 2 THEN SET strTblSuffix = 'xab';
		WHEN 3 THEN SET strTblSuffix = 'xac';
		WHEN 4 THEN SET strTblSuffix = 'xad';
		WHEN 5 THEN SET strTblSuffix = 'xae'; 
	
		ELSE SET strTblSuffix = 'catholic'; 	
		
	END CASE;
	
	

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_bgnDate_endDate_for_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_bgnDate_endDate_for_pub`(
  IN  pub_id	TEXT,
  OUT pub_begin_date DATE,
  OUT pub_end_date DATE
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_pub_id 		INT;

		SET queryExecutionTimer = CONCAT('get_bgnDate_endDate_for_pub rcvd pub_id: ', pub_id, ', will fill \'pub_begin_date, pub_end_date\';');
		/* SELECT queryExecutionTimer AS Entered_get_bgnDate_endDate_for_pub; */

	SET @thisSQL = CONCAT('SELECT pub_bgnDate INTO @pub_begin_date FROM publications WHERE pub_id = "', pub_id, '";');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; SET queryExecutionEnd = CURRENT_TIME();
	SET pub_begin_date = @pub_begin_date; /* fails to pass it home without this */
	SET queryExecutionTimer = CONCAT('MINMAX.pub_begin_date = ', CAST(@pub_begin_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
	/* SELECT queryExecutionTimer AS MINMAXpub_begin_date;   */

	SET @thisSQL = CONCAT('SELECT pub_endDate INTO @pub_end_date FROM publications WHERE pub_id = "', pub_id, '";');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; SET queryExecutionEnd = CURRENT_TIME();
	SET pub_end_date = @pub_end_date; /* fails to pass it home without this */
	SET queryExecutionTimer = CONCAT('MINMAX.pub_end_date = ', CAST(@pub_end_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
	/* SELECT queryExecutionTimer AS MINMAXpub_end_date;   */

	IF @pub_begin_date IS NOT NULL AND @pub_begin_date <> '' THEN 
		IF @pub_begin_date LIKE '%?%' THEN 
			SET @pub_begin_date = REPLACE(@pub_begin_date, '?', '0');
        END IF;
		IF @pub_begin_date LIKE '%u%' THEN 
			SET @pub_begin_date = REPLACE(@pub_begin_date, 'u', '0');
        END IF;
        IF LENGTH( @pub_begin_date ) = 4 THEN 
			SET @pub_begin_date = CONCAT(@pub_begin_date, '-01-01');
		END IF;        
		SET queryExecutionTimer = CONCAT('MIN(issue_date) = ', CAST(@pub_begin_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS step1_get_bgnDate_endDate_for_pub; */
	ELSE /* no valid begin date */
		SET @pub_begin_date = '0000-00-00';
	END IF;

	IF @pub_end_date IS NOT NULL AND @pub_end_date <> '' THEN 
/*
# need a better solution
		IF @pub_end_date = 'unknown' THEN 
			SET @pub_end_date = @pub_bgn_date;
        END IF;
*/        
		IF @pub_end_date = 'current' OR @pub_end_date = '9999' THEN 
			SET @pub_end_date = CURRENT_DATE();
        END IF;
		IF @pub_end_date LIKE '%?%' THEN 
			SET @pub_end_date = REPLACE(@pub_end_date, '?', '9');
        END IF;
		IF @pub_end_date LIKE '%u%' THEN 
			SET @pub_end_date = REPLACE(@pub_end_date, 'u', '9');
        END IF;
        IF LENGTH( @pub_end_date ) = 4 THEN 
			SET @pub_end_date = CONCAT(@pub_end_date, '-12-31');
		END IF;
		SET queryExecutionTimer = CONCAT('MAX(issue_date) = ', CAST(@pub_end_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS step2_get_bgnDate_endDate_for_pub; */
	ELSE /* no valid end date */
        SET @pub_end_date = '0000-00-00';
	END IF;
	

  SELECT CONCAT( 'get_bgnDate_endDate_for_pub_result: ', CAST(@pub_begin_date AS CHAR), ' ; ', CAST(@pub_end_date AS CHAR)) AS get_issue_MINMAX_result;

    SET pub_begin_date = @pub_begin_date; /* fails to pass it home without this */
    SET pub_end_date = @pub_end_date; /* fails to pass it home without this */
    
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_format_count_all_pubs_this_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_format_count_all_pubs_this_org`(
IN  org_id	TEXT,
IN 	begin_date	DATE,
IN  end_date	DATE,
IN  format_id	INT,
OUT this_format_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_format_id 		INT;

		SET queryExecutionTimer = CONCAT('get_format_count_all_pubs_this_org rcvd org_id: ', CAST(org_id AS CHAR), ', ');
        SET queryExecutionTimer = CONCAT(queryExecutionTimer, 'begin_date = ', CAST(begin_date AS CHAR), ', ');
		SET queryExecutionTimer = CONCAT(queryExecutionTimer, 'end_date = ', CAST(end_date AS CHAR), ', ');
        SET queryExecutionTimer = CONCAT(queryExecutionTimer, ' format_id: ', CAST(format_id AS CHAR), '.');
        SELECT queryExecutionTimer AS Entered_get_format_count_all_pubs_this_org;

		SET max_format_id = 15; /* change when we add a new format */

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW C3format_view AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE org_id = \'', org_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        SET @thisSQL = CONCAT(@thisSQL, /* 'AND format_id = ', format_id, */ ' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('C3formats: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; /* # this part is quick */


		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM C3format_view WHERE format_id = ', format_id, ';');
        /* SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM C3format_view;'); */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET this_format_count = @this_format_count; /* fails to pass it home without this */
        SET queryExecutionTimer = CONCAT('COUNT(*) = ', CAST(@this_format_count AS CHAR), ' WHERE format_id = ', format_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS GOT_format_count_all_pubs_this_org; */

		IF format_id = 2 OR format_id = 4 OR format_id = 5 OR format_id = 6 THEN
			SELECT queryExecutionTimer AS Exiting_get_format_count_all_pubs_this_org;
		END IF;

		/* SELECT CONCAT('format_id = ', CAST(format_id AS CHAR), ' AND max_format_id = ', CAST(max_format_id AS CHAR)) AS fmIDcheck; */

IF format_id = max_format_id THEN /* release resources and exit */
SELECT CONCAT('next is drop view') AS ViewToAkill;
	SET @thisSQL = CONCAT('DROP VIEW C3format_view;');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
END IF;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_format_count_for_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_format_count_for_country`(
IN  country_id	TEXT,
IN 	begin_date	DATE,
IN  end_date	DATE,
IN  format_id	INT,
OUT this_format_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_format_id 		INT;

    DECLARE format_view_name TEXT;

		SET queryExecutionTimer = CONCAT('get_format_count_for_country rcvd: format_id:', CAST(format_id AS CHAR), ', will fill \'this_format_count\';');
        /* SELECT queryExecutionTimer AS Entered_get_format_count_for_country; */

		SET max_format_id = 15; /* change when we add a new format */

		SET format_view_name = CONCAT('format_view_', pub_id);

IF format_id = 1 THEN
/* 	1st versions: each time routine was called, create view and fill only with format we want.
	Now, create view with ALL formats, only once, and see if this speeds things up. Had a small effect. */
		/* SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( SELECT * FROM ', issues_view ,' WHERE format_id = \'', format_id ,'\' );'); */
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', format_view_name ,' AS ( ');
/* can't create VIEW off of another view without redoing permissions,
	and it may not improve things anyway
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM ', issues_view, ' WHERE pub_id IN ( ');
*/
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id IN ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT pub_id FROM publications WHERE country_id = \'', country_id ,'\' ) ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        SET @thisSQL = CONCAT(@thisSQL, /* 'AND format_id = ', format_id, */ ' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('formats: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; # this part is quick */
END IF;
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM ', format_view_name ,' WHERE format_id = ', format_id, ';');
        /* SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM format_view;'); */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET this_format_count = @this_format_count; /* fails to pass it home without this */
        SET queryExecutionTimer = CONCAT('COUNT(*) = ', CAST(@this_format_count AS CHAR), ' WHERE format_id = ', format_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
IF format_id = 2 OR format_id = 4 OR format_id = 5 OR format_id = 6 THEN
			SELECT queryExecutionTimer AS Exiting_get_format_count_for_country;
END IF;
IF format_id = max_format_id THEN
  SET @thisSQL = CONCAT('DROP VIEW ', format_view_name, ';');
  PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
  /* we don't need it now */
END IF;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_format_count_for_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_format_count_for_org`(
IN  pub_id	TEXT,
IN  org_id	TEXT,
IN 	begin_date	DATE,
IN  end_date	DATE,
IN  format_id	INT,
OUT this_format_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_format_id 		INT;

		SET queryExecutionTimer = CONCAT('get_format_count_for_org rcvd format_id: ', CAST(format_id AS CHAR), ', will fill \'this_format_count\';');
		/* SELECT queryExecutionTimer AS Entered_get_format_count_for_org; */

		SET max_format_id = 15; /* change when we add a new format */

IF format_id = 1 THEN
/* 	1st versions: each time routine was called, create view and fill only with format we want.
	Now, create view with ALL formats, only once, and see if this speeds things up. Had a small effect. */
		/* SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( SELECT * FROM ', table_name ,' WHERE format_id = \'', format_id ,'\' );'); */
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( ');
/* can't create VIEW off of another view without redoing permissions,
	and it may not improve things anyway
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM ', table_name, ' WHERE pub_id IN ( ');
*/
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' ');
        SET @thisSQL = CONCAT(@thisSQL, 'AND repos_id = \'', org_id ,'\' ');
		/* SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' '); */
        SET @thisSQL = CONCAT(@thisSQL, /* 'AND format_id = ', format_id, */ ' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('formats: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; # this part is quick */
END IF;
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM format_view WHERE format_id = ', format_id, ';');
        /* SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM format_view;'); */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET this_format_count = @this_format_count; /* fails to pass it home without this */
        SET queryExecutionTimer = CONCAT('COUNT(*) = ', CAST(@this_format_count AS CHAR), ' WHERE format_id = ', format_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
/*
IF format_id = 2 OR format_id = 4 OR format_id = 5 OR format_id = 6 THEN
			SELECT queryExecutionTimer AS Exiting_get_format_count_for_org; 
END IF;
*/
IF format_id = max_format_id THEN
        DROP VIEW format_view; /* we don't need it now */
END IF;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_format_count_for_org_all_pubs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_format_count_for_org_all_pubs`(
IN  org_id	TEXT,
IN 	begin_date	DATE,
IN  end_date	DATE,
IN  format_id	INT,
OUT this_format_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_format_id 		INT;

		SET queryExecutionTimer = CONCAT('get_format_count_for_org_all_pubs rcvd format_id: ', CAST(format_id AS CHAR), ', will fill \'this_format_count\';');
		/* SELECT queryExecutionTimer AS Entered_get_format_count_for_org_all_pubs; */

		SET max_format_id = 15; /* change when we add a new format */

IF format_id = 1 THEN
/* 	1st versions: each time routine was called, create view and fill only with format we want.
	Now, create view with ALL formats, only once, and see if this speeds things up. Had a small effect. */
		/* SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( SELECT * FROM ', table_name ,' WHERE format_id = \'', format_id ,'\' );'); */
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( ');
/* can't create VIEW off of another view without redoing permissions,
	and it may not improve things anyway
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM ', table_name, ' WHERE pub_id IN ( ');
*/
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE repos_id = \'', org_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        SET @thisSQL = CONCAT(@thisSQL, /* 'AND format_id = ', format_id, */ ' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('formats: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; # this part is quick */
END IF;
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM format_view WHERE format_id = ', format_id, ';');
        /* SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM format_view;'); */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET this_format_count = @this_format_count; /* fails to pass it home without this */
        SET queryExecutionTimer = CONCAT('COUNT(*) = ', CAST(@this_format_count AS CHAR), ' WHERE format_id = ', format_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
IF format_id = 2 OR format_id = 4 OR format_id = 5 OR format_id = 6 THEN
			SELECT queryExecutionTimer AS Exiting_get_format_count_for_org_all_pubs;
END IF;
IF format_id = max_format_id THEN
        DROP VIEW format_view; /* we don't need it now */
END IF;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_format_count_for_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_format_count_for_pub`(
IN  pub_id	TEXT,
IN 	begin_date	DATE,
IN  end_date	DATE,
IN  format_id	INT,
OUT this_format_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_format_id 		INT;

    DECLARE format_view_name TEXT;

		SET queryExecutionTimer = CONCAT('get_format_count_for_pub rcvd: ', CAST(format_id AS CHAR), ', will fill \'this_format_count\' for pub_id=', pub_id, ' ', CAST(begin_date AS CHAR), ' to ', CAST(end_date AS CHAR), '.');
        /* SELECT queryExecutionTimer AS Entered_get_format_count_for_pub;  */

		SET max_format_id = 15; /* change when we add a new format */

		SET format_view_name = CONCAT('format_view_', pub_id);


IF format_id = 1 THEN
/* 	1st versions: each time routine was called, create view and fill only with format we want.
	Now, create view with ALL formats, only once, and see if this speeds things up. Had a small effect. */
		/* SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( SELECT * FROM ', issues_view ,' WHERE format_id = \'', format_id ,'\' );'); */
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', format_view_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' ');
        SET @thisSQL = CONCAT(@thisSQL, /* 'AND format_id = ', format_id, */ ' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('get_format_count_for_pub: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer; /* # this part is quick */
END IF;


		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM ', format_view_name, ' WHERE format_id = ', format_id, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET this_format_count = @this_format_count; /* fails to pass it home without this */
        SET queryExecutionTimer = CONCAT('COUNT(*) = ', CAST(@this_format_count AS CHAR), ' WHERE format_id = ', format_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		SELECT queryExecutionTimer AS gOt_format_count_for_pub;
/*
        IF format_id = 2 OR format_id = 4 OR format_id = 5 OR format_id = 6 THEN
			SELECT queryExecutionTimer AS Exiting_get_format_count_for_pub;
		END IF;
*/
IF format_id = max_format_id THEN
  SET @thisSQL = CONCAT('DROP VIEW ', format_view_name, ';');
  PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
        /* we don't need it now */
END IF;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_format_count_this_pub_this_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_format_count_this_pub_this_org`(
IN  pub_id	TEXT,
IN  org_id	TEXT,
IN 	begin_date	DATE,
IN  end_date	DATE,
IN  format_id	INT,
OUT this_format_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_format_id 		INT;

    DECLARE format_view_name TEXT;

		SET queryExecutionTimer = CONCAT('get_format_count_this_pub_this_org rcvd format_id: ', CAST(format_id AS CHAR), ', will fill \'this_format_count\';');
		/* SELECT queryExecutionTimer AS Entered_get_format_count_this_pub_this_org; */

		SET max_format_id = 15; /* change when we add a new format */

		SET format_view_name = CONCAT('format_view_', pub_id, '_', org_id);

IF format_id = 1 THEN
/* 	1st versions: each time routine was called, create view and fill only with format we want.
	Now, create view with ALL formats, only once, and see if this speeds things up. Had a small effect. */
		/* SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW format_view AS ( SELECT * FROM ', table_name ,' WHERE format_id = \'', format_id ,'\' );'); */
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', format_view_name, ' AS ( ');
/* can't create VIEW off of another view without redoing permissions,
	and it may not improve things anyway
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM ', table_name, ' WHERE pub_id IN ( ');
*/
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' ');
        SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = \'', org_id ,'\' ');
		/* SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date BETWEEN \'', begin_date, '\' AND \'', end_date, '\' '); */
        SET @thisSQL = CONCAT(@thisSQL, /* 'AND format_id = ', format_id, */ ' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('formats: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; # this part is quick */
END IF;
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM ', format_view_name, ' WHERE format_id = ', format_id, ';');
        /* SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @this_format_count FROM format_view;'); */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
		SET this_format_count = @this_format_count; /* fails to pass it home without this */
        SET queryExecutionTimer = CONCAT('COUNT(*) = ', CAST(@this_format_count AS CHAR), ' WHERE format_id = ', format_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
/*
IF format_id = 2 OR format_id = 4 OR format_id = 5 OR format_id = 6 THEN
			SELECT queryExecutionTimer AS Exiting_get_format_count_this_pub_this_org;
END IF;
*/

IF format_id = max_format_id THEN
  SET @thisSQL = CONCAT('DROP VIEW ', format_view_name, ';');
  PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
  /* we don't need it now */
END IF;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_holding_org_count_for_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_holding_org_count_for_pub`(
  IN  pub_id	TEXT,
  OUT pub_holders_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_pub_id 		INT;

    DECLARE this_view_name TEXT;

		SET queryExecutionTimer = CONCAT('get_holding_org_count_for_pub rcvd pub_id: ', pub_id, ', will fill \'pub_holders_count\';');
		/* SELECT queryExecutionTimer AS Entered_get_holding_org_count_for_pub; */

    SET this_view_name = CONCAT('holding_org_count_for_', pub_id);

    SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ( ');
    SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' ');
    SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('MINMAX: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');

		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT repos_id) INTO @pub_holders_count FROM issueORGS;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
    DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
		SET pub_holders_count = @pub_holders_count; /* fails to pass it home without this */
    SET queryExecutionTimer = CONCAT('pub_holders_count = ', CAST(@pub_holders_count AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
    /* SELECT queryExecutionTimer AS Exiting_get_holding_org_count_for_pub; */

    SET @thisSQL = CONCAT('DROP VIEW ', this_view_name, ';');
    PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
    /* we don't need it now */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_issue_id_from_iconDate_issue_note` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_issue_id_from_iconDate_issue_note`(
	IN issue_note TEXT, 
    OUT issue_id TEXT /* just treat the same, text */
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('get_issue_id_from_iconDate_issue_note(', issue_note, '); from ', CAST(totalExecutionBegin AS CHAR), '\n');
    
    SET issue_id = REPLACE(REPLACE(issue_note, 'via CRL db procedure (issues.', ''), ')', '');
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, 'issue_id is now ', issue_id);
    
	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_issue_MINMAX_for_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_issue_MINMAX_for_org`(
  IN  pub_id	TEXT,
  IN  org_id TEXT,
  OUT MINissue_date DATE,
  OUT MAXissue_date DATE,
  OUT org_rawIssueData TEXT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_pub_id 		INT;

    DECLARE this_view_name TEXT;


		SET queryExecutionTimer = CONCAT('get_issue_MINMAX_for_org rcvd pub_id: ', pub_id, ', will fill \'MINissue_date, MAXissue_date\';');
		/* SELECT queryExecutionTimer AS Entered_get_issue_MINMAX_for_org; */

    SET this_view_name = CONCAT('issueMINMAX_', pub_id, '_', REPLACE(org_id, '@', 'ATsign'));
    SET this_view_name = REPLACE(this_view_name, '#', 'sharpsign');
    /* SELECT this_view_name AS get_issue_MINMAX_for_org_this_view_name;   */

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = \'', org_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('MINMAX: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');

	/* are there actually any valid issues for this title ? */
		SET @thisSQL = CONCAT('SELECT COUNT(issue_date) INTO @num_valid_issues FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET MINissue_date = @MINissue_date; /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('MINMAX.num_valid_issues = ', CAST(@num_valid_issues AS CHAR), ' WHERE pub_id = ', pub_id, ' AND org_id = ', org_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS MINMAXnum_valid_issues; */

	IF @num_valid_issues > 0 THEN
		SET @thisSQL = CONCAT('SELECT MIN(issue_date) INTO @MINissue_date FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET MINissue_date = @MINissue_date; /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('MIN(issue_date) = ', CAST(@MINissue_date AS CHAR), ' WHERE pub_id = ', pub_id, ' AND org_id = ', org_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS step1_get_issue_MINMAX_for_org; */

		SET @thisSQL = CONCAT('SELECT MAX(issue_date) INTO @MAXissue_date FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET MAXissue_date = @MAXissue_date; /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('MAX(issue_date) = ', CAST(@MAXissue_date AS CHAR), ' WHERE pub_id = ', pub_id, ' AND org_id = ', org_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS step2_get_issue_MINMAX_for_org; */

		SET org_rawIssueData = '';

	ELSE /* no valid issues: set MIN/MAX to zero dates and fill @org_rawIssueData */
		SET MINissue_date = '0000-00-00';
		SET MAXissue_date = '0000-00-00';
/* SELECT CONCAT('MIN: ', CAST(MINissue_date AS CHAR), '; MAX: ', CAST(MAXissue_date AS CHAR), ': there were no valid issues')  AS get_issue_MINMAX_for_org_noValidDates; */


		 /* get the rawIssueData : needs a new VIEW */
		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' AND org_id = \'', org_id ,'\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('invalid MINMAX: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');


		/* SET @thisSQL = CONCAT('SELECT rawIssueData INTO @org_rawIssueData FROM issueMINMAX;');
			# first version ran fine when only 1 issue per pub per org ;
            # testing with 'COW', 'sn90051565', results in:
				Error Code: 1172 Result consisted of more than one row
			# 2 issues held by that org for that pub ; DISTINCT doesn't resolve it, so use LIMIT
        */
		SET @thisSQL = CONCAT('SELECT rawIssueData INTO @org_rawIssueData FROM ', this_view_name, ' LIMIT 1;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET org_rawIssueData = CAST(@org_rawIssueData AS CHAR); /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('org_rawIssueData = ', CAST(@org_rawIssueData AS CHAR), ' WHERE pub_id = ', pub_id, ' AND org_id = ', org_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS get_issue_MINMAX_for_org_rawIssueData; */

	END IF;

  SET @thisSQL = CONCAT('DROP VIEW ', this_view_name, ';');
  /* SELECT @thisSQL AS get_issue_MINMAX_for_org_droppy; */
  PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
  /* we don't need it now */


	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_issue_MINMAX_for_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_issue_MINMAX_for_pub`(
  IN  this_pub_id	TEXT,
  OUT MINissue_date DATE,
  OUT MAXissue_date DATE
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_pub_id 		INT;

    DECLARE this_view_name TEXT;

		SET queryExecutionTimer = CONCAT('get_issue_MINMAX_for_pub rcvd this_pub_id: ', this_pub_id, ', will fill \'MINissue_date, MAXissue_date\';');
		/* SELECT queryExecutionTimer AS Entered_get_issue_MINMAX_for_pub; */

    SET this_view_name = CONCAT('issueMINMAX_', this_pub_id, '_helper');

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = \'', this_pub_id ,'\' ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' );');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('MINMAX: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');

	/* are there actually any valid issues for this title ? */
		SET @thisSQL = CONCAT('SELECT COUNT(issue_date) INTO @num_valid_issues FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET MINissue_date = @MINissue_date; /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('MINMAX.num_valid_issues = ', CAST(@num_valid_issues AS CHAR), ' WHERE pub_id = ', this_pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS MINMAXnum_valid_issues;   */

	IF @num_valid_issues > 0 THEN
		SET @thisSQL = CONCAT('SELECT MIN(issue_date) INTO @MINissue_date FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET MINissue_date = @MINissue_date; /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('MIN(issue_date) = ', CAST(@MINissue_date AS CHAR), ' WHERE pub_id = ', this_pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS step1_get_issue_MINMAX_for_pub; */

		SET @thisSQL = CONCAT('SELECT MAX(issue_date) INTO @MAXissue_date FROM ', this_view_name, ' ;');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET MAXissue_date = @MAXissue_date; /* fails to pass it home without this */
		SET queryExecutionTimer = CONCAT('MAX(issue_date) = ', CAST(@MAXissue_date AS CHAR), ' WHERE pub_id = ', this_pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS step2_get_issue_MINMAX_for_pub; */
	ELSE /* no valid issues */
		SET MINissue_date = '0000-00-00';
        SET MAXissue_date = '0000-00-00';
	END IF;

	/* SELECT CONCAT( 'get_issue_MINMAX_for_pub_result: ', CAST(MINissue_date AS CHAR), ' ; ', CAST(MAXissue_date AS CHAR)) AS get_issue_MINMAX_result; */

  SET @thisSQL = CONCAT('DROP VIEW ', this_view_name, ';');
  PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
  /* we don't need it now */


	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_org_issues_count_for_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_org_issues_count_for_pub`(
  IN  pub_id	TEXT,
  IN  org_id	TEXT,
  OUT org_issues_count INT
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_pub_id 		INT;

    DECLARE this_view_name TEXT;


		SET queryExecutionTimer = CONCAT('get_org_issues_count_for_pub rcvd pub_id: ', pub_id, ', will fill \'org_issues_count\';');
		/* SELECT queryExecutionTimer AS Entered_get_org_issues_count_for_pub; */

    SET this_view_name = CONCAT('issueORGS_', pub_id, '_', REPLACE(org_id, '@', 'ATsign'));
    SET this_view_name = REPLACE(this_view_name, '#', 'sharpsign');
    /* SELECT this_view_name AS get_org_issues_count_for_pub_var_this_view_name;  */

		SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', this_view_name, ' AS ( ');
		SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues WHERE pub_id = "', pub_id ,'" ');
		SET @thisSQL = CONCAT(@thisSQL, 'AND org_id = "', org_id ,'" ');
		/* SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date <> \'0000-00-00\' );'); */
		SET @thisSQL = CONCAT(@thisSQL, ');');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT('MINMAX: CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer AS get_org_issues_count_for_pub_debug1; */

		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @org_issues_count FROM ', this_view_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET org_issues_count = @org_issues_count; /* fails to pass it home without this */
    SET queryExecutionTimer = CONCAT('org_issues_count = ', CAST(@org_issues_count AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		/* SELECT queryExecutionTimer AS Exiting_get_org_issues_count_for_pub; */


	  SET @thisSQL = CONCAT('DROP VIEW ', this_view_name, ';');
      /* SELECT @thisSQL AS get_org_issues_count_for_pub_droppy; */
	  PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			/* we don't need it now */

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_pub_frequencies_for_pub` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `get_pub_frequencies_for_pub`(
  IN  pub_id	TEXT,
  OUT pub_begin_date DATE,
  OUT pub_end_date DATE
)
BEGIN
		DECLARE thisSQL 	TEXT;
		DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
		DECLARE queryExecutionBegin	TIME;
		DECLARE queryExecutionEnd	TIME;
		DECLARE queryExecutionTimer TEXT;
        DECLARE max_pub_id 		INT;

		SET queryExecutionTimer = CONCAT('get_pub_frequencies_for_pub rcvd pub_id: ', pub_id, ', will fill \'pub_begin_date, pub_end_date\';');
		/* SELECT queryExecutionTimer AS Entered_get_pub_frequencies_for_pub; */

	SET @thisSQL = CONCAT('SELECT pub_bgnDate INTO @pub_begin_date FROM publications WHERE pub_id = "', pub_id, '";');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; SET queryExecutionEnd = CURRENT_TIME();
	SET pub_begin_date = @pub_begin_date; /* fails to pass it home without this */
	SET queryExecutionTimer = CONCAT('MINMAX.pub_begin_date = ', CAST(@pub_begin_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
	/* SELECT queryExecutionTimer AS MINMAXpub_begin_date;   */

	SET @thisSQL = CONCAT('SELECT pub_endDate INTO @pub_end_date FROM publications WHERE pub_id = "', pub_id, '";');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement; SET queryExecutionEnd = CURRENT_TIME();
	SET pub_end_date = @pub_end_date; /* fails to pass it home without this */
	SET queryExecutionTimer = CONCAT('MINMAX.pub_end_date = ', CAST(@pub_end_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
	/* SELECT queryExecutionTimer AS MINMAXpub_end_date;   */

	IF @pub_begin_date IS NOT NULL AND @pub_begin_date <> '' THEN 
		IF @pub_begin_date LIKE '%?%' THEN 
			SET @pub_begin_date = REPLACE(@pub_begin_date, '?', '0');
        END IF;
		IF @pub_begin_date LIKE '%u%' THEN 
			SET @pub_begin_date = REPLACE(@pub_begin_date, 'u', '0');
        END IF;
        IF LENGTH( @pub_begin_date ) = 4 THEN 
			SET @pub_begin_date = CONCAT(@pub_begin_date, '-01-01');
		END IF;        
        /*
        SET @pub_begin_date = CONCAT(@pub_begin_date, '-01-01');
		SET queryExecutionTimer = CONCAT('MIN(issue_date) = ', CAST(@pub_begin_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		SELECT queryExecutionTimer AS step1_get_pub_frequencies_for_pub; 
        */
	ELSE /* no valid begin date */
		SET @pub_begin_date = '0000-00-00';
	END IF;

	IF @pub_end_date IS NOT NULL AND @pub_end_date <> '' THEN 
		IF @pub_end_date LIKE '%?%' THEN 
			SET @pub_end_date = REPLACE(@pub_end_date, '?', '9');
        END IF;
		IF @pub_end_date LIKE '%u%' THEN 
			SET @pub_end_date = REPLACE(@pub_end_date, 'u', '9');
        END IF;
        IF LENGTH( @pub_end_date ) = 4 THEN 
			SET @pub_end_date = CONCAT(@pub_end_date, '-12-31');
		END IF;        
        /* 
        SET @pub_end_date = CONCAT(@pub_end_date, '-12-31');
		SET queryExecutionTimer = CONCAT('MAX(issue_date) = ', CAST(@pub_end_date AS CHAR), ' WHERE pub_id = ', pub_id, '; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed. ');
		SELECT queryExecutionTimer AS step2_get_pub_frequencies_for_pub; 
        */
	ELSE /* no valid end date */
        SET @pub_end_date = '0000-00-00';
	END IF;
	
  SELECT CONCAT( 'get_pub_frequencies_for_pub_result: ', CAST(@pub_begin_date AS CHAR), ' ; ', CAST(@pub_end_date AS CHAR)) AS get_pub_frequencies_for_pub_result;
    SET pub_begin_date = @pub_begin_date; /* fails to pass it home without this */
    SET pub_end_date = @pub_end_date; /* fails to pass it home without this */
    
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `iconDate_DayOfWeek_lookup_zerodate_seeds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `iconDate_DayOfWeek_lookup_zerodate_seeds`(
	IN this_pub_id TEXT,
    IN boolSendToOutfile TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
	DECLARE outfileName	TEXT;	

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('iconDate_DayOfWeek_lookup_zerodate_seeds("', this_pub_id, '" \'); from ', CAST(totalExecutionBegin AS CHAR), '\n');
    SET outfileName = CONCAT('/home/mysql/tmp/iconDate_DayOfWeek_lookup_zerodate_seeds_', this_pub_id, '.csv');
    
/* build SQL */
SET @thisSQL = 'SELECT DISTINCT DAYNAME(I.issue_date) as dayname, ';
SET @thisSQL = CONCAT(@thisSQL, 'MIN(I.issue_date) AS org_first_issue, MAX(I.issue_date) AS org_last_issue, COUNT(*) AS issues_this_org_this_date_range, ');
SET @thisSQL = CONCAT(@thisSQL, 'I.org_id, O.org_name, ');
SET @thisSQL = CONCAT(@thisSQL, 'P.pub_id, P.pub_title, P.freq_id_code, P.frequency310, P.former_freq_id_code, P.formerFrequency321, ');
SET @thisSQL = CONCAT(@thisSQL, 'Z.rawIssueData AS issue_seed_raw, ');
SET @thisSQL = CONCAT(@thisSQL, 'REPLACE(REPLACE(I.issue_note, "via CRL db procedure (issues.", ""), ")", "") AS issue_seed_id, ');
SET @thisSQL = CONCAT(@thisSQL, 'Z.pub_id, Z.org_id ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM `icondata`.`issues` I ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`publications` P ON P.pub_id = I.pub_id ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`organizations` O ON O.org_id = I.org_id ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`zerodate_issues` Z ON Z.zerodate_issue_id = REPLACE(REPLACE(I.issue_note, \'via CRL db procedure (issues.\', \'\'), \')\', \'\')  ');
SET @thisSQL = CONCAT(@thisSQL, 'WHERE I.pub_id = "', this_pub_id, '" ');
SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY I.pub_id, I.org_id, DAYOFWEEK(I.issue_date) ');
SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY org_first_issue ');
/* SELECT @thisSQL AS iconDate_DayOfWeek_lookup_zerodate_seedsSQL; */

/* sometimes results to outfile */
IF boolSendToOutfile = 'outfile' THEN
	SET @thisSQL = CONCAT(@thisSQL, 'INTO OUTFILE \'', outfileName, '\' CHARACTER SET utf8 FIELDS TERMINATED BY \'|\' LINES TERMINATED BY \'\\n\'');
    SELECT @thisSQL AS next_is_outfile;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('OUTFILE : ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
	SELECT CONCAT('outfile: ', outfileName, ' completed; exiting.\n');
ELSE	
	/* sometimes results to screen */
    /* SELECT @thisSQL AS next_is_results_to_screen; */
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT (show on screen): ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */
END IF;
    
	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    /* SELECT totalExecutionTimer; */
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `iconDate_DayOfWeek_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `iconDate_DayOfWeek_report`(
	IN this_pub_id TEXT,
    IN boolSendToOutfile TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE callStatementClause TEXT;
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
	DECLARE outfileName	TEXT;	

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('iconDate_DayOfWeek_report("', this_pub_id, '" \'); from ', CAST(totalExecutionBegin AS CHAR), '\n');
    SET outfileName = CONCAT('/home/mysql/tmp/iconDate_DayOfWeek_report_', this_pub_id, '.csv');
    
/* build SQL */
SET @thisSQL = 'SELECT DISTINCT DAYNAME(I.issue_date) as dayname, ';
SET @thisSQL = CONCAT(@thisSQL, 'MIN(I.issue_date) AS org_first_issue, MAX(I.issue_date) AS org_last_issue, COUNT(*) AS issues_this_org_this_date_range_this_dayname, ');
SET @thisSQL = CONCAT(@thisSQL, 'I.org_id, O.org_name, ');
SET @thisSQL = CONCAT(@thisSQL, 'P.pub_id, P.pub_title, P.freq_id_code, P.frequency310, P.former_freq_id_code, P.formerFrequency321 ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM `icondata`.`issues` I ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`publications` P ON P.pub_id = I.pub_id ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`organizations` O ON O.org_id = I.org_id ');
SET @thisSQL = CONCAT(@thisSQL, 'WHERE I.pub_id = "', this_pub_id, '" ');
SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY I.pub_id, I.org_id, DAYOFWEEK(I.issue_date) ');
SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY org_first_issue ');
SELECT @thisSQL AS iconDate_DayOfWeek_reportSQL; 

/* SET @callStatementClause = CONCAT('SELECT DISTINCT CONCAT(  \'');  */
SET @callStatementClause = CONCAT("SELECT DISTINCT CONCAT( CALL B2move_issues_to_other_weekday('", this_pub_id, "', ', I.org_id, ',  ");
	/* SET @callStatementClause = CONCAT(@callStatementClause, 'CALL B2move_issues_to_other_weekday("', this_pub_id, '", ", I.org_id ,", ' ); 
	SET @callStatementClause = CONCAT(@callStatementClause, ' ", CAST(MIN(I.issue_date) AS CHAR), ", ", CAST(MIN(I.issue_date) AS CHAR), "), '); */
    SET @callStatementClause = CONCAT(@callStatementClause, ' \'CAST(MIN(I.issue_date) AS CHAR)\', \'CAST(MIN(I.issue_date) AS CHAR), \', "num_days_to_move_INT", ');
	SET @callStatementClause = CONCAT(@callStatementClause, 'DAYNAME(I.issue_date) AS B2move_SP_call ');
    SET @callStatementClause = CONCAT(@callStatementClause, 'FROM `icondata`.`issues` I ');
    SET @callStatementClause = CONCAT(@callStatementClause, 'WHERE I.pub_id = "', this_pub_id, '" )');
    /* SET @callStatementClause = CONCAT(@callStatementClause, 'AND I.org_id = "', I.org_id, '" '); */
SELECT @callStatementClause AS callStatementClauseSQL; 


/* sometimes results to outfile */
IF boolSendToOutfile = 'outfile' THEN
	SET @thisSQL = CONCAT(@thisSQL, 'INTO OUTFILE \'', outfileName, '\' CHARACTER SET utf8 FIELDS TERMINATED BY \'|\' LINES TERMINATED BY \'\\n\'');
    SELECT @thisSQL AS next_is_outfile;
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('OUTFILE : ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;
	SELECT CONCAT('outfile: ', outfileName, ' completed; exiting.\n');
ELSE	
	/* sometimes results to screen */
    /* SELECT @thisSQL AS next_is_results_to_screen; */
    SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
    SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('SELECT (show on screen): ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */
END IF;
    
	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    /* SELECT totalExecutionTimer; */
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `iconDate_DOW_checkerboard_TW_org_issues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`192.168.1.80`*/ /*!50003 PROCEDURE `iconDate_DOW_checkerboard_TW_org_issues`(
    IN boolSendToOutfile TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE loop_ticker INT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
	DECLARE str_where_pub_and_org_clause TEXT; /* SQL WHERE */
    DECLARE str_call_statement_clause TEXT;
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */
	DECLARE outfileName	TEXT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
	DECLARE issue_id	TEXT;   /* extracted from issue_note */

	/* dates from the view, issues which exist */
	DECLARE first_issue_date DATE; 	DECLARE this_issue_date DATE; 	DECLARE next_issue_date DATE; DECLARE last_issue_date DATE;
	/* dates which, if present in the view, indicate likely checkerboard :
			- they are on a DAYNAME() that is not VALID_DATESTEP (3 for triweekly) after DAYNAME(first_issue_date)
		*/
	DECLARE checkerboard_candi_date DATE;
	DECLARE num_days_to_move INT; /* number of days, positive or negative, to move this issue to be on a correct day: parameter for B2move_issues_to_other_weekday */

	DECLARE int_checkerboard_flag INT; /* should we suspect this title of being a checkerboard ? */
	DECLARE int_insertion_flag INT; /* did we already add this pub_id to the list of suspects? */

	DECLARE this_pub_id TEXT; /* filled by cursor */
    DECLARE this_org_id TEXT; /* filled by cursor */
	DECLARE end_recordset INT UNSIGNED DEFAULT 0; /* used by handler below */
/* end declaring variables */

/* declare cursors only after variables */
	DECLARE pubs_cursor CURSOR FOR
	SELECT pub_id FROM triweeklyCheckerboardCandidatePUBS;

	DECLARE org_issues_cursor CURSOR FOR
	SELECT DISTINCT org_id FROM triweeklyCheckerboardCandidateISS WHERE pub_id = this_pub_id COLLATE utf8_unicode_ci;


/* end declaring cursors ; only now can declare handlers */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_recordset = 1;

/*********************  end all declarations  ***************************/

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('iconDate_DOW_checkerboard_TW_org_issues("', boolSendToOutfile, '" \'); from ', CAST(totalExecutionBegin AS CHAR), '\n');
/*  SET outfileName = CONCAT('/home/mysql/tmp/iconDate_DOW_checkerboard_TW_org_issues_', boolSendToOutfile, '.csv');
    SET outfileName = CONCAT('/home/mysql/tmp/iconDate_DOW_checkerboard_TW_org_issues_', this_pub_id, '.csv'); */
SET outfileName = CONCAT('iconDate_DOW_checkerboard_TW_org_issues_', boolSendToOutfile, '.csv');



    /* see file: create_triweeklyCheckerboardSuspects.sql
    	- SUSPECTS are publication-level
    	- ARRESTEES as issue-level
     */
	SET @thisSQL = 'DELETE FROM triweeklyCheckerboardSuspects WHERE 1 > 0';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('Clean triweeklyCheckerboardSuspects: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS triweeklyCheckerboardSuspects_Cleaned;
    /* empty junk table exists, loop will fill it with PUBLICATIONS records (copies) and save stuff in pub_note, numberingNote515 etc. */

    /* see file: triweeklyCheckerboardArrestees.sql
    	- ARRESTEES as issue-level
    	- SUSPECTS are publication-level
    */
	SET @thisSQL = 'DELETE FROM triweeklyCheckerboardArrestees WHERE 1 > 0';
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('Clean triweeklyCheckerboardArrestees: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS triweeklyCheckerboardArrestees_Cleaned;
    /* empty junk table exists, loop will fill it with ISSUES records (copies) and save stuff in issue_note, etc. */


/* create a view of TRIWEEKLY publications */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW triweeklyCheckerboardCandidatePUBS AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM publications ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE freq_id_code ="i" ');
	SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY pub_title, pub_bgnDate, pub_endDate );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS pubsview;
	/* now the view exists, main SELECT SQL will use it in JOIN  */

/* create a view of ISSUES from TRIWEEKLY publications */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW triweeklyCheckerboardCandidateISS AS ( ');
	SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM issues ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id IN (SELECT pub_id FROM triweeklyCheckerboardCandidatePUBS) ');
  SET @thisSQL = CONCAT(@thisSQL, 'AND org_id NOT IN ("AQM", "FLNEW", "MITGS", "PQHN") ');
  /* above: exclude issues from vendors 2016-06-13 */
	SET @thisSQL = CONCAT(@thisSQL, ' );');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT('CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer AS issview;
	/* now the view exists, main SELECT SQL will use it in JOIN  */

/* build main SELECT SQL */
SET @thisSQL = 'SELECT DISTINCT DAYNAME(I.issue_date) as dayname, ';
SET @thisSQL = CONCAT(@thisSQL, 'MIN(I.issue_date) AS org_first_issue, MAX(I.issue_date) AS org_last_issue, COUNT(*) AS issues_this_org_this_date_range_this_dayname, ');
SET @thisSQL = CONCAT(@thisSQL, 'I.org_id, O.org_name, ');
SET @thisSQL = CONCAT(@thisSQL, 'P.pub_id, P.pub_title, P.freq_id_code, P.frequency310, P.former_freq_id_code, P.formerFrequency321 ');
SET @thisSQL = CONCAT(@thisSQL, 'FROM `icondata`.`triweeklyCheckerboardCandidateISS` I ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`triweeklyCheckerboardCandidatePUBS` P ON P.pub_id = I.pub_id ');
SET @thisSQL = CONCAT(@thisSQL, 'JOIN `icondata`.`organizations` O ON O.org_id = I.org_id ');
/* SET @thisSQL = CONCAT(@thisSQL, 'WHERE 1=1 '); */
SET @thisSQL = CONCAT(@thisSQL, 'GROUP BY P.pub_id, DAYOFWEEK(I.issue_date), I.org_id ');  /* # good, retain */
SET @thisSQL = CONCAT(@thisSQL, 'ORDER BY org_first_issue, org_last_issue ');
SELECT @thisSQL AS iconDate_DOW_checkerboard_TW_org_issuesSQL;

SET loop_ticker = 1;
SET end_recordset = 0;

	/* SELECT CONCAT("CKB_TW: entered if org_pubs_count with ", @org_pubs_count, ", and loop_ticker = ", CAST(loop_ticker AS CHAR)) AS CKB_TWif_org_pubs_count;    */
OPEN pubs_cursor;
	/* SELECT CONCAT("CKB_TW: opened pubs_cursor") AS CKB_TWopened_pub_cursor; */
	pubs_cursor_loop: WHILE end_recordset = 0 DO
		/* SELECT CONCAT("CKB_TW: into pubs_cursor_loop") AS CKB_TWpubs_cursor_loop;  */
		FETCH pubs_cursor INTO this_pub_id;
		/* SELECT CONCAT("CKB_TW: this_pub_id = ", this_pub_id) AS CKB_TWfetched_pub_cursor;   */

		IF end_recordset THEN
			SELECT 'End of recordset' AS endRecsMsg;
			LEAVE pubs_cursor_loop; /* pub_id is null + skip rest of loop */
			/* CLOSE pubs_cursor; # outside loop end */
		END IF;

			SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @pub_issue_count FROM triweeklyCheckerboardCandidateISS WHERE pub_id = \'', this_pub_id, '\';');
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			/* SELECT CONCAT(' pub_issue_count: ', CAST(@pub_issue_count AS CHAR), ' issues') AS num_iss_for_pub; */


IF @pub_issue_count > 3 THEN /* 3 for triweekly, change to a var later... */
	CALL get_issue_MINMAX_for_pub(this_pub_id, @first_issue_date, @last_issue_date); /* fill some date variables */

	      /* @next_issue_date: MIN issue date that is greater than @first_issue_date */
	SET @thisSQL = 'SELECT MIN(issue_date) INTO @next_issue_date ';
	SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', this_pub_id, '\' AND issue_date > \'', @first_issue_date, '\' ');
	      /* SELECT @thisSQL AS next_issue_dateSQL; */
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

	/* if checkerboard_candi_date is present...
	starting from first_issue_date, when looking at the PUB level	*/
	SET @thisSQL = 'SELECT ADDDATE(MIN(issue_date), 8) INTO @checkerboard_candi_date ';
	/* 8 for triweekly, change to a var later... */
	SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ');
	SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', this_pub_id, '\' AND issue_date = \'', @first_issue_date, '\' ');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

	/* number of issues at date suspected of being wrong if present */
	SET @thisSQL = 'SELECT COUNT(*) INTO @int_checkerboard_flag ';
  SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ');
  SET @thisSQL = CONCAT(@thisSQL, 'WHERE pub_id = \'', this_pub_id, '\' AND issue_date = \'', @checkerboard_candi_date, '\' ');
  /* SELECT @thisSQL AS next_count_checkerboard_candi_date; */
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		IF @int_checkerboard_flag > 0 THEN /* insert this pub into SUSPECTS table, editing the pub_note field */
			/* works, retain
			SELECT this_pub_id, @first_issue_date AS first_issue_date, @next_issue_date AS next_issue_date_value,
				@checkerboard_candi_date AS checkerboard_candi_date, @last_issue_date AS last_issue_date,
				@int_checkerboard_flag AS int_checkerboard_flag;   */

			/* did we already flag this title ? */
			SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @int_insertion_flag ');
			SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardSuspects WHERE pub_id = \'', this_pub_id, '\' ');
			PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
			/* SELECT @int_insertion_flag AS suspect_already_logged;  */

			IF @int_insertion_flag = 0 THEN
				SET @thisSQL = CONCAT('INSERT INTO triweeklyCheckerboardSuspects ');
				SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM triweeklyCheckerboardCandidatePUBS WHERE pub_id = \'', this_pub_id, '\' ');
				PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

				SET strDebug = CONCAT('first_issue_date \'', @first_issue_date, '\' next_issue_date_value = \'', @next_issue_date, '\' checkerboard_candi_date = \'', @checkerboard_candi_date, '\' last_issue_date \'', @last_issue_date, ' ; ');
				SET strDebug = CONCAT(strDebug, 'on ', CAST(NOW() AS CHAR), ' ; int_checkerboard_flag = ', CAST(@int_checkerboard_flag AS CHAR), '.');
				/* SELECT strDebug AS new_pub_note_for_suspect; */

				SET @thisSQL = CONCAT('UPDATE triweeklyCheckerboardSuspects ');
				SET @thisSQL = CONCAT(@thisSQL, 'SET pub_note = "', strDebug, '" WHERE pub_id = \'', this_pub_id, '\' ');
				/* SELECT @thisSQL AS UPDATE_pub_note_for_suspect; */
				PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

			/* finished with PUBS level here, the title is in the table of suspected checkerboards
				- now issues of that title
				- B2move_issues_to_other_weekday wants an org_id, so LOOP THROUGH ISSUES VIEW TO GET ORG_IDS */
				OPEN org_issues_cursor;
					org_issues_cursor_loop: WHILE end_recordset = 0 DO

						FETCH org_issues_cursor INTO this_org_id;

						IF end_recordset THEN
							SELECT 'End of ISS recordset' AS endRecsMsg;
							LEAVE org_issues_cursor_loop;
							/* CLOSE org_issues_cursor; # outside of loop end */
						END IF; /* org_issues_cursor */

						/* SELECT this_org_id AS just_plain_this_org_id;	*/

					/*
						first time through the issues, this_issue_date will be same as first_issue_date
						- from now on after get_issue_MINMAX_for_org:
							first_issue_date, this_issue_date, next_issue_date, checkerboard_candi_date, last_issue_date
							refer only to the set held by this ORG
					*/
					CALL get_issue_MINMAX_for_org(this_pub_id, this_org_id, @first_issue_date, @last_issue_date, @strDebug);

					SET @thisSQL = CONCAT('SELECT \'', @first_issue_date, '\' INTO @this_issue_date ');
					SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS LIMIT 1 ');
SELECT @thisSQL AS this_issue_dateSQL_a;
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

					SET @str_where_pub_and_org_clause = CONCAT('WHERE pub_id = \'', this_pub_id, '\' AND org_id = \'', this_org_id, '\' ');

					SET @thisSQL = CONCAT('SELECT COUNT(*)  FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
				    SET @thisSQL = CONCAT(@thisSQL, 'INTO @num_iss_for_pub_and_org ');
					PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
					/* SELECT @num_iss_for_pub_and_org; */

				/* 2016-06-10 08:25:41 */

					IF @num_iss_for_pub_and_org > 3 THEN /* 3 for triweekly, DEVNOTE make var */

						      /* @next_issue_date MIN issue date that is greater than @this_issue_date */
						SET @thisSQL = 'SELECT MIN(issue_date) INTO @next_issue_date ';
						SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
						SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date > \'', @this_issue_date, '\' ');
						/* SELECT @thisSQL AS next_issue_dateSQL; */
						PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

						/* if checkerboard_candi_date is present...
						starting from first_issue_date
						*/
						SET @thisSQL = 'SELECT ADDDATE(MIN(issue_date), 8)  INTO @checkerboard_candi_date ';
						/* 8 for triweekly, change to a var later... */
						SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
						SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @first_issue_date, '\' ');
						PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

						/* number of issues at date suspected of being checkerboard_candi_date if present */
						SET @thisSQL = 'SELECT COUNT(*) INTO @int_checkerboard_flag ';
						SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
						SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
						/* SELECT @thisSQL AS next_count_checkerboard_candi_date; */
						PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
						/* SELECT @int_checkerboard_flag AS int_checkerboard_flag_ISS_level; */

						IF @int_checkerboard_flag > 0 THEN /* insert this pub into SUSPECTS table, editing the pub_note field */
							/* works, retain */
							SELECT this_pub_id, @first_issue_date AS first_issue_date, @next_issue_date AS next_issue_date_value,
								@checkerboard_candi_date AS checkerboard_candi_date, @last_issue_date AS last_issue_date,
								@int_checkerboard_flag AS int_checkerboard_flag, this_org_id;

						/* ISSUES: flag, insert, update */

							/* did we already flag this PUB_ORG_DATE ? */
							SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @int_insertion_flag ');
							SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees ', @str_where_pub_and_org_clause);
							SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
							PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
							/* SELECT @int_insertion_flag AS arrestee_already_logged;  */

							IF @int_insertion_flag = 0 THEN /* save this issue */

/* get BAD_DAYNAME from checkerboard_candi_date : only insert to triweeklyCheckerboardArrestees the issues that match that BAD_DAYNAME */
								SET @thisSQL = CONCAT('SELECT DAYNAME(issue_date) INTO @bad_dayname ');
								SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
								SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' LIMIT 1 '); /* LIMIT because the DAYNAME is always the same */
								PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
								SELECT @bad_dayname AS only_insert_this_weekday_to_arrestees;

								SET @thisSQL = CONCAT('INSERT INTO triweeklyCheckerboardArrestees ');
								SET @thisSQL = CONCAT(@thisSQL, 'SELECT * FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
								SET @thisSQL = CONCAT(@thisSQL, 'AND DAYNAME(issue_date) = \'', @bad_dayname, '\' ');
								SET @thisSQL = CONCAT(@thisSQL, 'AND format_id NOT IN (8,12) ');
								PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

								org_issues_arrestees_insertion_loop:
								WHILE @checkerboard_candi_date < @last_issue_date
								/* AND @int_insertion_flag < 10000 only for test prevent infinite loop */
								DO

									SET strDebug = CONCAT('this_issue_date \'', @this_issue_date, '\' next_issue_date_value = \'', @next_issue_date, '\' checkerboard_candi_date = \'', @checkerboard_candi_date, '\' last_issue_date \'', @last_issue_date, '; on ', CAST(NOW() AS CHAR), ' ; ');
									SET strDebug = CONCAT(strDebug, 'int_checkerboard_flag = ', CAST(@int_checkerboard_flag AS CHAR), '.');
									/* SELECT strDebug AS new_issue_note_for_arrestee; */

									SET @thisSQL = CONCAT('UPDATE triweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SET issue_note = CONCAT(issue_note, " ; ', strDebug, '") ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
								/*	SELECT @thisSQL AS UPDATE_issue_note_for_arrestee; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

						/* COMPOSE THE FIX FOR BAD DATES:
									want CALL B2move_issues_to_other_weekday */

/*SET @thisSQL = CONCAT('SELECT CAST(DATEDIFF(\'', @checkerboard_candi_date, '\', \'', @next_issue_date, '\') AS SIGNED ) ');  */
/*2016-06-13 07:05:13*/
/* SET @thisSQL = CONCAT('SELECT CAST(DATEDIFF(\'', @next_issue_date, '\', \'', @checkerboard_candi_date, '\') AS SIGNED ) '); */
/* DATEDIFF: subtracts first date from second DEVNOTE TRY: */
SET @thisSQL = CONCAT('SELECT CAST(DATEDIFF(\'', @this_issue_date, '\', \'', @next_issue_date, '\') AS SIGNED ) ');
									SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees LIMIT 1 '); 	/* or any table, just needs a FROM clause */
									SET @thisSQL = CONCAT(@thisSQL, 'INTO @num_days_to_move ');
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @num_days_to_move;

									SET @thisSQL = CONCAT('SELECT CONCAT( "CALL B2move_issues_to_other_weekday(\'', this_pub_id, '\', \'', this_org_id, '\',  ');
									SET @thisSQL = CONCAT(@thisSQL, '\'', CAST(@checkerboard_candi_date AS CHAR), '\', \'', CAST(@checkerboard_candi_date AS CHAR), '\', ');
									SET @thisSQL = CONCAT(@thisSQL, '\'num_days_to_move=', CAST(@num_days_to_move AS CHAR), '\', ' );
									SET @thisSQL = CONCAT(@thisSQL, '\'', @bad_dayname, '\'); ');  /* end CALL statement here */
									SET @thisSQL = CONCAT(@thisSQL, '") '); /* End CONCAT here */
									SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
									/* next is for cases like ocn809384055 with > issue / day / org */
									/* SET @thisSQL = CONCAT(@thisSQL, 'AND format_id NOT IN (8,12) '); 	*/
									SET @thisSQL = CONCAT(@thisSQL, 'LIMIT 1 ');
									SET @thisSQL = CONCAT(@thisSQL, 'INTO @B2move_str_call_statement_clause ');
									/* SELECT @thisSQL AS compose_B2_call; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
									SELECT @B2move_str_call_statement_clause;

									/* save B2 call in some random field of the arrestees table: issue_note */
									SET @thisSQL = CONCAT('UPDATE triweeklyCheckerboardArrestees ');
									SET @thisSQL = CONCAT(@thisSQL, 'SET rawIssueData = "', @B2move_str_call_statement_clause, '" ', @str_where_pub_and_org_clause);
									SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @checkerboard_candi_date, '\' ');
									/* SELECT @thisSQL AS prep_for_B2_insert; */
									PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

		/* END COMPOSE THE FIX FOR BAD DATES */

	/* save next_issue_date into this_issue_date, then get a new next_issue_date 	*/
	SET @thisSQL = CONCAT('SELECT CAST(\'', @next_issue_date, '\' AS DATE) INTO @this_issue_date ');
	SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardArrestees LIMIT 1 '); 	/* or any table, just needs a FROM clause */
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @this_issue_date AS this_issue_date_bottom;

	      /* MIN issue date that is greater than @this_issue_date */
	SET @thisSQL = 'SELECT MIN(issue_date) INTO @next_issue_date ';
	SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
	SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date > \'', @this_issue_date, '\' LIMIT 1 ');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @next_issue_date AS next_issue_date_bottom;

	SET @thisSQL = 'SELECT ADDDATE(issue_date, 8) INTO @checkerboard_candi_date ';
	/* 8 for triweekly, change to a var later... */
	SET @thisSQL = CONCAT(@thisSQL, 'FROM triweeklyCheckerboardCandidateISS ', @str_where_pub_and_org_clause);
	SET @thisSQL = CONCAT(@thisSQL, 'AND issue_date = \'', @this_issue_date, '\' LIMIT 1 ');
	PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
	SELECT @checkerboard_candi_date AS checkerboard_candi_date_bottom;



									SET @int_insertion_flag	= @int_insertion_flag + 1; /* loop control: org_issues_arrestees_insertion_loop */

								END WHILE org_issues_arrestees_insertion_loop;
							END IF; /* int_insertion_flag at ISS level */
					END IF; /* int_checkerboard_flag at ISS level */
				END IF; /* num_iss_for_pub_and_org meets criteria */
				/* end new 2016-06-10 08:25:58 */





				END WHILE org_issues_cursor_loop;
				CLOSE org_issues_cursor;
				SET end_recordset = 0; /* will have been tripped by org_issues_cursor */

			END IF; /* int_insertion_flag at PUBS level */
		END IF; /* int_checkerboard_flag at PUBS level */
		END IF; /* pub has at least the right amount of issues */

  SET loop_ticker = loop_ticker + 1;
END WHILE pubs_cursor_loop;
CLOSE pubs_cursor;

SET @thisSQL = 'SELECT pub_id, pub_title, pub_note FROM triweeklyCheckerboardSuspects LIMIT 5';
SELECT @thisSQL AS just_sample_possible_checkerboard_PUBS;
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

SET @thisSQL = 'SELECT DISTINCT pub_id, issue_date, rawIssueData, org_id, issue_note FROM triweeklyCheckerboardArrestees LIMIT 50';
SELECT @thisSQL AS just_sample_possible_checkerboard_ISS;
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;


SELECT 'Dropping PUBS and ISS views' AS will_cleanup_2;
SET @thisSQL = 'DROP VIEW triweeklyCheckerboardCandidatePUBS';
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
SET @thisSQL = 'DROP VIEW triweeklyCheckerboardCandidateISS';
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;

SET totalExecutionEnd = CURRENT_TIME();
 SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
  /* SELECT totalExecutionTimer; */
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `initializeIssueRecordValues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `initializeIssueRecordValues`(
IN mySOURCEtableName TEXT,
IN input_issue_id INT UNSIGNED,
INOUT myPubID TINYTEXT,
INOUT myOrgID TINYTEXT,
INOUT myConditionID TINYTEXT,
INOUT myFormat TINYTEXT,
INOUT myFormatID TINYTEXT,
INOUT myArchiveID TINYTEXT,
INOUT myProvenanceID TINYTEXT,
INOUT myIssueNote TINYTEXT
)
BEGIN
        DECLARE sql_myPubID TEXT;
        DECLARE sql_myOrgID TEXT;
        DECLARE sql_myConditionID TEXT;
        DECLARE sql_myFormat TEXT;
        DECLARE sql_myFormatID TEXT;
        DECLARE sql_myArchiveID TEXT;
		DECLARE sql_myProvenanceID TEXT;
        DECLARE sql_myIssueNote TEXT;
		DECLARE issueNoteDefault TEXT;
        DECLARE thisStatement TEXT;
        DECLARE whereClause TEXT;
        DECLARE strDebug TEXT;

      /* finish DECLARE all before SET */

        SET whereClause = CONCAT(' WHERE issue_id = ', input_issue_id, '; ');

        SET strDebug = CONCAT('initializeIssueRecordValues(); mySOURCEtableName=', mySOURCEtableName, '; whereClause=', whereClause);
		/* SELECT strDebug; */

        SET @sql_myPubID = CONCAT('SELECT pub_id INTO @myPubID FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myPubID; */
        PREPARE thisStatement FROM @sql_myPubID;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
		/* SELECT @myPubID; */

        SET @sql_myOrgID = CONCAT('SELECT org_id INTO @myOrgID FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myOrgID; */
        PREPARE thisStatement FROM @sql_myOrgID;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
		/* SELECT @myOrgID; */

        SET @sql_myConditionID = CONCAT('SELECT condition_id INTO @myConditionID FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myConditionID; */
        PREPARE thisStatement FROM @sql_myConditionID;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
		/* SELECT @myConditionID; */

        SET @sql_myFormat = CONCAT('SELECT format INTO @myFormat FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myFormat; */
        PREPARE thisStatement FROM @sql_myFormat;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
		/* SELECT @myFormat; */

        SET @sql_myFormatID = CONCAT('SELECT format_id INTO @myFormatID FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myFormatID; */
        PREPARE thisStatement FROM @sql_myFormatID;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
		/* SELECT @myFormatID; */

        SET @sql_myArchiveID = CONCAT('SELECT archive_status_id INTO @myArchiveID FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myArchiveID; */
        PREPARE thisStatement FROM @sql_myArchiveID;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
		/* SELECT @myArchiveID; */

SET @sql_myProvenanceID = CONCAT('SELECT provenance_id INTO @myProvenanceID FROM ', mySOURCEtableName, whereClause);
SELECT @sql_myProvenanceID;
PREPARE thisStatement FROM @sql_myProvenanceID;
EXECUTE thisStatement;
DEALLOCATE PREPARE thisStatement;
SELECT @myProvenanceID;

		SET issueNoteDefault = CONCAT('via CRL db procedure (', mySOURCEtableName,  '.', input_issue_id, ')');
        SET @sql_myIssueNote = CONCAT('SELECT issue_note INTO @myIssueNote FROM ', mySOURCEtableName, whereClause);
		/* SELECT @sql_myIssueNote; */
        PREPARE thisStatement FROM @sql_myIssueNote;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;

            /* myIssueNote in 2 steps, IF is just to add separator if there was data */
        IF @myIssueNote = "" OR @myIssueNote IS NULL THEN /* was empty */
			/* SELECT CONCAT(@myIssueNote, " IF block"); */
            SET @myIssueNote = issueNoteDefault;
        ELSE /* add separator */
			/* SELECT CONCAT(@myIssueNote, " ELSE block"); */
            SET @myIssueNote = CAST(CONCAT(@myIssueNote, '; ', issueNoteDefault) AS CHAR);
        END IF;

SELECT @myIssueNote;

	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertThisIssue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `insertThisIssue`(
        IN myTARGETtableName TEXT,
        IN myPubID TINYTEXT, IN myIssueDate DATE,
        /* IN myRawIssueData TEXT, */
        IN myOrgID TINYTEXT,
        IN myConditionID TINYTEXT, IN myFormat TINYTEXT, IN myFormatID TINYTEXT, IN myArchiveID TINYTEXT, IN myProvenanceID TINYTEXT, IN myIssueNote TEXT
)
BEGIN
        DECLARE insertionSQL TEXT;
		DECLARE thisStatement TEXT;
        DECLARE output TEXT;


        SET output = "this is insertThisIssue()";

        /* old : INSERT INTO issuesNEWcrln
        # new : INSERT INTO myTARGETtableName
            SET
            pub_id      = myPubID,      issue_date  = myIssueDate,
            rawIssueData = '', repos_id    = myOrgID,    condition_id = myConditionID,
            format = myFormat, format_id = myFormatID,
            archive_status_id = myArchiveID, provenance = '',     update_date = CURRENT_DATE(),
            issue_note  = myIssueNote, specificIssuesCreated = 1, specificIssuesCreatedDate = CURRENT_DATE();
        */

        SET @insertionSQL = CONCAT('INSERT INTO ', myTARGETtableName, ' ');
        SET @insertionSQL = CONCAT(@insertionSQL, 'SET pub_id = "', myPubID, '", issue_date = \'', myIssueDate, '\', ');
        SET @insertionSQL = CONCAT(@insertionSQL, 'rawIssueData = "", org_id = "', myOrgID, '", condition_id = "', myConditionID, '", ');
        SET @insertionSQL = CONCAT(@insertionSQL, 'format = "', myFormat, '", format_id = ', myFormatID, ', ');
        SET @insertionSQL = CONCAT(@insertionSQL, 'archive_status_id = ', myArchiveID, ', provenance_id = ', myProvenanceID,', ');
        SET @insertionSQL = CONCAT(@insertionSQL, 'update_date = \'', CURRENT_DATE(), '\', issue_note  = "', myIssueNote, '", ');
        SET @insertionSQL = CONCAT(@insertionSQL, 'specificIssuesCreated = 1, specificIssuesCreatedDate = \'', CURRENT_DATE(), '\';');
		/* SET output = CONCAT(output, "; ", @insertionSQL);
			SELECT output; */

        PREPARE thisStatement FROM @insertionSQL;
        EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;

		SET output = "exiting insertThisIssue()";
		/* SELECT output; */
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `passed_date_check` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `passed_date_check`(
	IN date_checked DATE, 
    IN date_min_boundary DATE, 
    IN date_max_boundary DATE, 
    IN specific_message TEXT 
)
BEGIN 
/* must do all declarations before can set any value  */
	SELECT CONCAT('SUCCESS: ', specific_message, ' ; @date_checked: ', CAST(date_checked AS CHAR), ': IS between ', CAST(date_min_boundary AS CHAR), ' and ', CAST(date_max_boundary AS CHAR), '.') 
		AS passed_date_check_result; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reposMINMAXcompare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `reposMINMAXcompare`(
	
	IN REPOS_ID_1 TEXT, 
	IN REPOS_ID_2 TEXT 
)
BEGIN
	DECLARE selectClause TEXT;
	DECLARE strSQL LONGTEXT;
	DECLARE whereClause TEXT;
	DECLARE outfilePath TEXT; 
	DECLARE outfileName TEXT; 
	DECLARE outfileClause TEXT; 
	DECLARE thisStatement TEXT; 

	DECLARE loopCounter INT UNSIGNED DEFAULT 0; 
	DECLARE strDebug	TEXT;   

	DECLARE thisPUB_ID TEXT; 
	DECLARE endRecordset INT UNSIGNED DEFAULT 0; 


	
	DECLARE cursorPUBSheldByTheseRepos CURSOR FOR 
	  
	  SELECT DISTINCT(pub_id) FROM issues
		WHERE repos_id = REPOS_ID_1 
		AND pub_id IN (
		  SELECT DISTINCT(pub_id) FROM issues WHERE repos_id = REPOS_ID_2
		) ORDER BY pub_id;

	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET endRecordset = 1;








	SET @selectClause = CONCAT('SELECT p.pub_id, p.pub_title, p.pub_city, p.country_id, r.repos_name, i.repos_id, ');
		SET @selectClause = CONCAT( @selectClause, 'MIN(i.issue_date) AS issue_dateMIN, MAX(i.issue_date) AS issue_dateMAX, ');
		SET @selectClause = CONCAT( @selectClause, 'f.format_name, COUNT(1) AS issue_count ');
		SET @selectClause = CONCAT( @selectClause, 'FROM publications p ');
		SET @selectClause = CONCAT( @selectClause, 'JOIN issues i ON p.pub_id = i.pub_id ');
		SET @selectClause = CONCAT( @selectClause, 'JOIN formats f ON i.format_id = f.format_id ');
		SET @selectClause = CONCAT( @selectClause, 'JOIN repositories r ON i.repos_id = r.repos_id ');


	SET loopCounter = 0;
	OPEN cursorPUBSheldByTheseRepos;
	cursorLoop: WHILE endRecordset = 0 DO
		FETCH cursorPUBSheldByTheseRepos INTO thisPUB_ID;

		IF endRecordset THEN 
			SELECT 'End of recordset' AS endRecsMsg;
			CLOSE cursorPUBSheldByTheseRepos;
			LEAVE cursorLoop; 
		END IF;

		SET loopCounter = loopCounter + 1;
SELECT CONCAT( CAST(loopCounter AS CHAR), ') ', thisPUB_ID  ) AS whileCursor;

	
		SET @whereClause = CONCAT(' WHERE i.issue_date <> \'0000-00-00\' ');
			SET @whereClause = CONCAT( @whereClause, 'AND i.pub_id = "', thisPUB_ID, '" '); 
			SET @whereClause = CONCAT( @whereClause, 'AND i.repos_id = "FAKE_REPOS_ID" ');

	
		SET @outfilePath = '/tmp/mysql/';
		SET @outfileName = CONCAT('reposMINMAXcompare_', thisPUB_ID, '_', REPOS_ID_1, '_', REPOS_ID_2,  '.csv');
		SET @outfileClause = CONCAT(' INTO OUTFILE \'', @outfilePath, @outfileName, '\' CHARACTER SET utf8 ');
		SET @outfileClause = CONCAT(@outfileClause, 'FIELDS TERMINATED BY "|" LINES TERMINATED BY "{NEWLINE}"');
		

		
		
		SET @strSQL = CONCAT( 
			@selectClause, 
			REPLACE(@whereClause, 'FAKE_REPOS_ID', REPOS_ID_1)
		);
		
		SET @strSQL = CONCAT( @strSQL, 
			' UNION ', 
			@selectClause, 
			REPLACE(@whereClause, 'FAKE_REPOS_ID', REPOS_ID_2)
		);
		

		SET @strSQL = CONCAT( @strSQL, @outfileClause); 
		
		PREPARE thisStatement FROM @strSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
	END WHILE cursorLoop; 


SELECT "tried OUTFILE...END reposMINMAXcompare" AS exitMsg; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_to_outfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `send_to_outfile`(
    IN outfile_prefix TEXT, 
    IN outfile_suffix TEXT, 
    IN outfile_extension TEXT, 
    IN outfile_contents TEXT
)
BEGIN 
DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;
DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */


DECLARE outfile_name	TEXT;	DECLARE output_table_name TEXT;


/* must do all declarations before can set any value  */

SET outfile_name = CONCAT('/home/mysql/tmp/', outfile_prefix, outfile_suffix, '.', outfile_extension);
/* SELECT outfile_prefix; SELECT outfile_suffix; SELECT outfile_extension; SELECT outfile_name; */

SET @thisSQL = CONCAT('SELECT "', outfile_contents ,'" INTO OUTFILE \'', outfile_name, '\' CHARACTER SET utf8 FIELDS TERMINATED BY \'|\' LINES TERMINATED BY \'\\n\'');
/* SELECT @thisSQL AS next_is_outfile; */
PREPARE thisStatement FROM @thisSQL; EXECUTE thisStatement; DEALLOCATE PREPARE thisStatement;
SELECT CONCAT('outfile: ', outfile_name, ' completed; exiting.\n') AS exit_send_to_outfile;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setDateSpread` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `setDateSpread`(
    IN      myFreqID    TINYTEXT,
    INOUT   dateSpread   INT
)
BEGIN
      CASE myFreqID
        WHEN "d" THEN   SET dateSpread = 1; 	
        WHEN "i" THEN   SET dateSpread = 2; 	
        WHEN "c" THEN   SET dateSpread = 3; 	
        WHEN "w" THEN   SET dateSpread = 7; 	
        WHEN "j" THEN   SET dateSpread = 10;	
        WHEN "e" THEN   SET dateSpread = 14;	
        WHEN "s" THEN   SET dateSpread = 14;	
        WHEN "m" THEN   SET dateSpread = 30;	
        WHEN "b" THEN   SET dateSpread = 60;	
        WHEN "q" THEN   SET dateSpread = 90;	
        WHEN "t" THEN   SET dateSpread = 120;	
        WHEN "f" THEN   SET dateSpread = 180;	
        WHEN "a" THEN   SET dateSpread = 365;	
        WHEN "g" THEN   SET dateSpread = 730;	
        WHEN "h" THEN   SET dateSpread = 2190;	
        
        WHEN "u" THEN   SET dateSpread = -9999;	
        WHEN "0" THEN 	SET dateSpread = -9999; 
        WHEN "-1" THEN	SET dateSpread = -9999;	
        WHEN "z" THEN   SET dateSpread = -9999;	
      ELSE
        SET dateSpread = -9999;	
      END CASE;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setMyIssueDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `setMyIssueDate`(
    IN myFreqID TINYTEXT,
    IN issueDateSeed DATE,
    INOUT myIssueDate DATE
)
BEGIN
	CASE myFreqID
		WHEN "d" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 1 DAY ) INTO myIssueDate;
		WHEN "i" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 2 DAY ) INTO myIssueDate;
		WHEN "c" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 3 DAY ) INTO myIssueDate;
		WHEN "w" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 7 DAY ) INTO myIssueDate;
		WHEN "j" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 10 DAY ) INTO myIssueDate;
		WHEN "e" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 2 WEEK ) INTO myIssueDate;
		WHEN "s" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 2 WEEK ) INTO myIssueDate;
		WHEN "m" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 1 MONTH ) INTO myIssueDate;
		WHEN "b" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 2 MONTH ) INTO myIssueDate;
		WHEN "q" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 3 MONTH ) INTO myIssueDate;
		WHEN "t" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 4 MONTH ) INTO myIssueDate;
		WHEN "f" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 6 MONTH ) INTO myIssueDate;
		WHEN "a" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 1 YEAR )  INTO myIssueDate;
		WHEN "g" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 2 YEAR )  INTO myIssueDate;
		WHEN "h" THEN SELECT DATE_ADD( issueDateSeed, INTERVAL 3 YEAR )  INTO myIssueDate;
		ELSE SET myIssueDate = '0000-00-00';
	END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCompareTitles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `spCompareTitles`(IN Repos1 VARCHAR(20), IN Repos2 VARCHAR(20))
BEGIN
DROP TABLE IF EXISTS ReposFirst ;
DROP TABLE IF EXISTS ReposSecond ;
DROP TABLE IF EXISTS FirstResultSet ;
DROP TABLE IF EXISTS SecondResultSet ;

CREATE TEMPORARY TABLE  ReposFirst (INDEX(pub_id)) AS
 /* SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS Found1 */
 SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Repos1 AS Found1
 FROM publications
 INNER JOIN issues
 ON publications.pub_id = issues.pub_id
 WHERE repos_id = Repos1 /* COLLATE utf8_unicode_ci */ ;

CREATE TEMPORARY TABLE  ReposSecond (INDEX(pub_id)) AS
 /* SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS Found2 */
 SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Repos2 AS Found2
 FROM publications
 INNER JOIN issues
 ON publications.pub_id = issues.pub_id
 WHERE repos_id = Repos2 /* COLLATE utf8_unicode_ci */ ;

CREATE TEMPORARY TABLE FirstResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.pub_title, a.pub_bgnDate, a.pub_endDate, Found1, Found2
 FROM ReposFirst a
 LEFT JOIN ReposSecond b
 ON a.pub_id = b.pub_id;

CREATE TEMPORARY TABLE SecondResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.pub_title, a.pub_bgnDate, a.pub_endDate, Found1, Found2
 FROM ReposSecond a
 LEFT JOIN ReposFirst b
 ON a.pub_id = b.pub_id;

SELECT pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Found1, Found2
 FROM FirstResultSet
 UNION
 SELECT pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Found1, Found2
  FROM SecondResultSet
  ORDER BY pub_title;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCompareTitles_onlyCommon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `spCompareTitles_onlyCommon`(IN Repos1 VARCHAR(5), IN Repos2 VARCHAR(5))
BEGIN
DROP TABLE IF EXISTS ReposFirst ;
DROP TABLE IF EXISTS ReposSecond ;
/* not in this version
DROP TABLE IF EXISTS FirstResultSet ;
DROP TABLE IF EXISTS SecondResultSet ;
*/
DROP TABLE IF EXISTS CommonResultSet ;

CREATE TEMPORARY TABLE  ReposFirst (INDEX(pub_id)) AS
 SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS Found1
 FROM publications
 INNER JOIN issues
 ON publications.pub_id = issues.pub_id
 WHERE org_id = Repos1 /* COLLATE utf8_unicode_ci */ ;

CREATE TEMPORARY TABLE  ReposSecond (INDEX(pub_id)) AS
 SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS Found2
 FROM publications
 INNER JOIN issues
 ON publications.pub_id = issues.pub_id
 WHERE org_id = Repos2 /* COLLATE utf8_unicode_ci */ ;

CREATE TEMPORARY TABLE CommonResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.pub_title, a.pub_bgnDate, a.pub_endDate, Found1, Found2
 FROM ReposFirst a
 LEFT JOIN ReposSecond b
 ON a.pub_id = b.pub_id
 WHERE a.Found1 = 'X' AND b.Found2 = 'X';

/* add headings for outfile */
SELECT 'pub_id' AS pub_id, 'OCLC' AS OCLC, 'pub_title' AS pub_title, 'pub_bgnDate' AS pub_bgnDate,
	'pub_endDate' AS pub_endDate, CONCAT('Found for ', Repos1) AS Found1, CONCAT('Found for ', Repos2) AS Found2
UNION
	SELECT pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Found1, Found2
	 FROM CommonResultSet
	  ORDER BY pub_title
INTO OUTFILE '/tmp/mysql/spCompareTitles_results_onlyCommon.csv'
CHARACTER SET utf8 FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spCompareTitles_outfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `spCompareTitles_outfile`(IN Repos1 VARCHAR(5), IN Repos2 VARCHAR(5))
BEGIN
DROP TABLE IF EXISTS ReposFirst ;
DROP TABLE IF EXISTS ReposSecond ;
DROP TABLE IF EXISTS FirstResultSet ;
DROP TABLE IF EXISTS SecondResultSet ;

CREATE TEMPORARY TABLE  ReposFirst (INDEX(pub_id)) AS
 SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS Found1
 FROM publications
 INNER JOIN issues
 ON publications.pub_id = issues.pub_id
 WHERE org_id = Repos1 /* COLLATE utf8_unicode_ci */ ;

CREATE TEMPORARY TABLE  ReposSecond (INDEX(pub_id)) AS
 SELECT DISTINCT publications.pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, 'X' AS Found2
 FROM publications
 INNER JOIN issues
 ON publications.pub_id = issues.pub_id
 WHERE org_id = Repos2 /* COLLATE utf8_unicode_ci */ ;

CREATE TEMPORARY TABLE FirstResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.pub_title, a.pub_bgnDate, a.pub_endDate, Found1, Found2
 FROM ReposFirst a
 LEFT JOIN ReposSecond b
 ON a.pub_id = b.pub_id;

CREATE TEMPORARY TABLE SecondResultSet (INDEX(pub_id)) AS
SELECT a.pub_id, a.OCLC, a.pub_title, a.pub_bgnDate, a.pub_endDate, Found1, Found2
 FROM ReposSecond a
 LEFT JOIN ReposFirst b
 ON a.pub_id = b.pub_id;

/* add headings for outfile */
SELECT 'pub_id' AS pub_id, 'OCLC' AS OCLC, 'pub_title' AS pub_title, 'pub_bgnDate' AS pub_bgnDate,
	'pub_endDate' AS pub_endDate, CONCAT('Found for ', Repos1) AS Found1, CONCAT('Found for ', Repos2) AS Found2
UNION
		SELECT pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Found1, Found2
		 FROM FirstResultSet
		 UNION
		 SELECT pub_id, OCLC, pub_title, pub_bgnDate, pub_endDate, Found1, Found2
		  FROM SecondResultSet
		  ORDER BY pub_title
INTO OUTFILE '/tmp/mysql/spCompareTitles_results.csv'
CHARACTER SET utf8 FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_GALE_issues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `update_GALE_issues`(input_issue_id INT)
BEGIN
	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

  DECLARE strDebug	TEXT;   /* holds debugging info */
  DECLARE thisSQL 	TEXT;   /* various one-time roles */
  DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

    /* values to be assigned from query results */
  DECLARE issueTitle, alt_issueTitle, new_pub_id TEXT;
  DECLARE var_issue_date DATE; /* issue date of the issue whose id is input_issue_id */
  DECLARE firstIssueDate, lastIssueDate DATE; /* dates of exisitng ICON issues */
/* END declaration block, only now can we SET variable values */

    SET @thisSQL = CONCAT('SELECT MASTHEAD_TITLE INTO @issueTitle FROM GALE.issues WHERE issue_id = ', CAST(input_issue_id AS CHAR), ';');
		SELECT @thisSQL AS get_masthead_title_statement;
		/* SELECT CAST(@thisSQL AS CHAR) AS B1country_issues_per_year_INSERT; */
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT('@issueTitle: ', @issueTitle, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer AS step1;

    SET @alt_issueTitle = (CONCAT('%',@issueTitle));
    SELECT @alt_issueTitle;

    SET @thisSQL = CONCAT('SELECT issue_date INTO @var_issue_date FROM GALE.issues WHERE issue_id = ', CAST(input_issue_id AS CHAR), ';');
		SELECT @thisSQL AS input_issue_date_statement;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT('@var_issue_date: ', @var_issue_date, ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer AS step2;

    SET @thisSQL = CONCAT(
      'SELECT DISTINCT p.pub_id INTO @new_pub_id FROM icondata.publications p ',
      'JOIN icondata.issues i ON i.pub_id = p.pub_id ',
      /* 'WHERE (p.pub_title = "', @issueTitle, '" OR p.pub_title LIKE "', @alt_issueTitle, '"); ' */
      'WHERE (p.pub_title = "', CAST(@issueTitle AS CHAR), '" OR p.pub_title LIKE "', CAST(@alt_issueTitle AS CHAR), '"); '
      /*
      AND @var_issue_date BETWEEN pub_bgnDate AND pub_endDate);
      "AND issue_date BETWEEN CONCAT(pub_bgnDate, '01-01') AND CONCAT(pub_endDate, '12-31'));"
      "AND i.issue_date BETWEEN '1889-01-01' AND '1889-12-31';" */
    ); /* end CONCAT */
		SELECT @thisSQL AS get_pub_id_statement;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = CONCAT('@new_pub_id: ', CAST(@new_pub_id AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer AS step3;

	
    SET @thisSQL = CONCAT('CALL icondata.get_issue_MINMAX_for_pub( "', @new_pub_id, '", @firstIssueDate, @lastIssueDate)');
		SELECT @thisSQL AS ICON_existing_issue_date_statement;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
        DEALLOCATE PREPARE thisStatement;
        SET queryExecutionEnd = CURRENT_TIME();
        SET queryExecutionTimer = 
			CONCAT('@firstIssueDate: ', CAST(@firstIssueDate AS CHAR), ' ; ', 
            '@lastIssueDate: ', CAST(@lastIssueDate AS CHAR), ' ; ', 
            CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
        SELECT queryExecutionTimer AS ICON_issue_date_step;

  SET @thisSQL = CONCAT('UPDATE GALE.issues SET pub_id = ', @new_pub_id, ' WHERE ((issue_id = ', input_issue_id, ') AND (pub_id IS NULL OR pub_id=''));');
  SELECT @thisSQL AS finalUpdateStatement;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `V1_vendor_collection_issues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`andy`@`192.168.1.%`*/ /*!50003 PROCEDURE `V1_vendor_collection_issues`(
	IN pub_id TEXT,
	IN vendor_title_id TEXT
)
BEGIN

	DECLARE totalExecutionTimer TEXT;	DECLARE totalExecutionBegin	TIME;	DECLARE totalExecutionEnd	TIME;
	DECLARE queryExecutionBegin	TIME;	DECLARE queryExecutionEnd	TIME;	DECLARE queryExecutionTimer TEXT;

	DECLARE table_name	TEXT;	DECLARE outfileName	TEXT;	DECLARE outputTableName TEXT;

	DECLARE thisSQL 	TEXT; 	/* various one-time roles or, in main body = staticSQL + changing WHERE clause */
    DECLARE insertClause TEXT;	/* beginning of insert statement that gets finished in LOOP */
	DECLARE thisStatement TEXT; /* for PREPARE/EXECUTE/DEALLOCATE */

		/* values extracted from the VIEW and INSERTED into outputTableName */
	DECLARE uniform_title 		TEXT; /* generated as a uniform title by new procedure: build_uniform_title */
    DECLARE issue_count_total	INT;	DECLARE issue_count_distinct	INT;	DECLARE issue_count_valid	INT;

    DECLARE MINissue_date	DATE;	DECLARE MINVALIDissue_date	DATE;
    DECLARE MAXissue_date	DATE;	DECLARE MAXVALIDissue_date	DATE;

    /* count of the format with this ID */
    DECLARE format_count_1 	INT; 		DECLARE format_count_2 INT; 	DECLARE format_count_3 INT;
    DECLARE format_count_4 INT; 		DECLARE format_count_5 INT;		DECLARE format_count_6 INT;
    DECLARE format_count_7 INT; 		DECLARE format_count_8 INT; 	DECLARE format_count_9 INT;
	DECLARE format_count_10 INT; 		DECLARE format_count_11 INT; 	DECLARE format_count_12 INT;
    DECLARE format_count_13 INT;		DECLARE format_count_14 INT; 	DECLARE format_count_15 INT;
    DECLARE format_count_distinct	INT;

	DECLARE strDebug	TEXT;   /* holds debugging info */
    DECLARE messagePrefix TEXT; /* holds execution timing info, what we are timing */
/* end declarations */

	SET totalExecutionBegin = CURRENT_TIME();
	SET totalExecutionTimer = CONCAT('V1_vendor_collection_issues ', pub_id, '; from ', CAST(totalExecutionBegin AS CHAR), '-');

	SET outputTableName = 'V1_vendor_collection_issues';
	SET table_name 	= CONCAT('V1_vendor_collection_issues_', pub_id);

		/* uniform_title needs to be set just once:
			since B2 is interested in the title level, here we'll generate a uniform title with geographical and date information
		*/
	CALL build_uniform_title( pub_id, @uniform_title );

	SET insertClause = CONCAT('INSERT INTO ', outputTableName, '( pub_id, pub_title, ');
	SET insertClause = CONCAT(insertClause, 'issue_count_total, issue_count_valid, issue_count_distinct, ');
	SET insertClause = CONCAT(insertClause, 'MINissue_date, MINVALIDissue_date, ');
	SET insertClause = CONCAT(insertClause, 'MAXissue_date, MAXVALIDissue_date, ');
	SET insertClause = CONCAT(insertClause, 'format_count_distinct, 1_unspecified_unknown, 2_Paper, 3_Paper_original, 4_Microfilm, 5_Microfiche, ');
	SET insertClause = CONCAT(insertClause, '6_Microopaque, 7_Reprint, 8_Digital_pdf, 9_Facsimile, 10_Photocopy, ');
	SET insertClause = CONCAT(insertClause, '11_Textile, 12_Digital_direct_electronic, 13_Microform, 14_Digital_unspecified, ');
	SET insertClause = CONCAT(insertClause, '15_Digital_tiff) VALUES ');

	/* SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', table_name, ' AS ( SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' );'); */
	SET @thisSQL = CONCAT('CREATE OR REPLACE VIEW ', table_name, ' AS ( SELECT * FROM issues WHERE pub_id = \'', pub_id ,'\' );');




    SELECT @thisSQL AS createViewSQL;
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ': CREATE VIEW: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */
	/* now the view exists, its name is in the variable 'table_name' we use table_name as we used the temporary table name in the first version */


	/* fill the values to be inserted in the output table */

    		/* how many TOTAL ISSUES for this title? */
	SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @issue_count_total FROM ', table_name, ';');
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ': SELECT COUNT(*) INTO @issue_count_total = ', CAST(@issue_count_total AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	SELECT queryExecutionTimer;

	IF @issue_count_total > 0 THEN

			/* how many VALID ISSUE DATES for this title?
            NON-ZERO dates */
		SET @thisSQL = CONCAT('SELECT COUNT(*) INTO @issue_count_valid FROM ', table_name, ' ');
        SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date <> \'0000-00-00\';');
		SELECT @thisSQL AS valid_dateSQL;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': SELECT COUNT(*) INTO @issue_count_valid = ', CAST(@issue_count_valid AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

			/* how many DISTINCT ISSUE DATES for this title?
            includes Zero dates */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct FROM ', table_name, ';');
		SELECT @thisSQL AS distdateSQL;
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': SELECT COUNT(DISTINCT issue_date) INTO @issue_count_distinct = ', CAST(@issue_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		/* SELECT queryExecutionTimer; */


			/* MIN-MAX issue_date fields: for each one, first get the very MIN/MAX,
				then the NON-ZERO, VALID DATE MIN/MAX */
		SET @thisSQL = CONCAT('SELECT MIN(issue_date) INTO @MINissue_date FROM ', table_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': MIN ', CAST(@MINissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

			/* trouble arises when only ZERO dates for a title
				SO 2 IF clauses below to set the MIN/MAX in those cases: */
		SET @thisSQL = CONCAT('SELECT MIN(issue_date) INTO @MINVALIDissue_date FROM ', table_name, ' ');
		SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date <> \'0000-00-00\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': MINVALID ', CAST(@MINVALIDissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		IF @MINVALIDissue_date IS NULL THEN
			SELECT 'NO VALID MIN DATE' AS MINS_INVALIDSonly;
			SET @MINVALIDissue_date = '0000-00-00';
		END IF;

		SET @thisSQL = CONCAT('SELECT MAX(issue_date) INTO @MAXissue_date FROM ', table_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': MAX ', CAST(@MAXissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		SET @thisSQL = CONCAT('SELECT MAX(issue_date) INTO @MAXVALIDissue_date FROM ', table_name, ' ');
		SET @thisSQL = CONCAT(@thisSQL, 'WHERE issue_date <> \'0000-00-00\';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': MAXVALID ', CAST(@MAXVALIDissue_date AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		IF @MAXVALIDissue_date IS NULL THEN
			SELECT 'NO VALID MAX DATE' AS MINS_INVALIDSonly;
			SET @MAXVALIDissue_date = '0000-00-00';
		END IF;


		/* done with issue_date fields */

			/* how many distinct FORMATS for this pub_id? */
		SET @thisSQL = CONCAT('SELECT COUNT(DISTINCT format_id ) INTO @format_count_distinct FROM ', table_name, ';');
		SET queryExecutionBegin = CURRENT_TIME();
		PREPARE thisStatement FROM @thisSQL;
		EXECUTE thisStatement;
		DEALLOCATE PREPARE thisStatement;
		SET queryExecutionEnd = CURRENT_TIME();
		SET queryExecutionTimer = CONCAT(pub_id, ': SELECT COUNT(DISTINCT format_id) INTO @format_count_distinct = ', CAST(@format_count_distinct AS CHAR), ' ; ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
		SELECT queryExecutionTimer;

		/* get the number of issues in each format for this pub_id */
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 1, @format_count_1);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 2, @format_count_2);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 3, @format_count_3);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 4, @format_count_4); /* SELECT CONCAT('format_count_4 = ', CAST(@format_count_4 AS CHAR)) AS have_fmt_4; */
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 5, @format_count_5);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 6, @format_count_6);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 7, @format_count_7);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 8, @format_count_8); /* SELECT CONCAT('format_count_8 = ', CAST(@format_count_8 AS CHAR)) AS have_fmt_8; */
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 9, @format_count_9);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 10, @format_count_10);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 11, @format_count_11);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 12, @format_count_12);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 13, @format_count_13);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 14, @format_count_14);
		CALL get_format_count_for_pub( pub_id, @MINissue_date, @MAXissue_date, 15, @format_count_15);
		/* END FORMATS */
	ELSE /* no issues */
		SET @issue_count_distinct = 0;
        SET @MINissue_date = '0000-00-00';	SET @MINVALIDissue_date = '0000-00-00';
        SET @MAXissue_date = '0000-00-00';	SET @MAXVALIDissue_date = '0000-00-00';
        SET @format_count_distinct = 0;
		SET @format_count_1 = 0;		SET @format_count_2 = 0;		SET @format_count_3 = 0;
		SET @format_count_4 = 0;		SET @format_count_5 = 0;		SET @format_count_6 = 0;
		SET @format_count_7 = 0;		SET @format_count_8 = 0;		SET @format_count_9 = 0;
		SET @format_count_10 = 0;		SET @format_count_11 = 0;		SET @format_count_12 = 0;
		SET @format_count_13 = 0;		SET @format_count_14 = 0;		SET @format_count_15 = 0;
    END IF;


	/* perform the INSERT */
	SET @thisSQL = CONCAT(insertClause, ' (\'', pub_id, '\', "', @uniform_title, '", ');
	SET @thisSQL = CONCAT(@thisSQL, @issue_count_total,  ', ', @issue_count_valid, ', ', @issue_count_distinct, ', ');
	SET @thisSQL = CONCAT(@thisSQL, "'", CAST(@MINissue_date AS CHAR), "', '", CAST(@MINVALIDissue_date AS CHAR), "', ");
	SET @thisSQL = CONCAT(@thisSQL, "'", CAST(@MAXissue_date AS CHAR), "', '", CAST(@MAXVALIDissue_date AS CHAR), "', ");
	SET @thisSQL = CONCAT(@thisSQL, @format_count_distinct, ', ',
							@format_count_1, ', ', @format_count_2, ', ', @format_count_3, ', ',
							@format_count_4, ', ', @format_count_5, ', ', @format_count_6, ', ',
							@format_count_7, ', ', @format_count_8, ', ', @format_count_9, ', ',
							@format_count_10, ', ', @format_count_11, ', ', @format_count_12, ', ',
							@format_count_13, ', ', @format_count_14, ', ', @format_count_15);
	SET @thisSQL = CONCAT(@thisSQL, ');');
	SELECT CAST(@thisSQL AS CHAR) AS V1_vendor_collection_issues_INSERT;
	SELECT "devnote: disabled actual INSERT during V1_vendor_collection_issues development " AS V1_vendor_collection_issues_DEVNOTE;
	/*
	SET queryExecutionBegin = CURRENT_TIME();
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;
	SET queryExecutionEnd = CURRENT_TIME();
	SET queryExecutionTimer = CONCAT(pub_id, ': INSERT: ', CAST(TIMEDIFF(queryExecutionEnd, queryExecutionBegin) AS CHAR), ' elapsed.');
	/* SELECT queryExecutionTimer; */

	/* release resources and exit */
    /* SELECT 'NOT DROPPING JUNK VIEW DURING DEV' AS warning; */
	SET @thisSQL = CONCAT('DROP VIEW ', table_name, ';');
	PREPARE thisStatement FROM @thisSQL;
	EXECUTE thisStatement;
	DEALLOCATE PREPARE thisStatement;

	SET totalExecutionEnd = CURRENT_TIME();
    SET totalExecutionTimer = CONCAT(totalExecutionTimer, '-', 	CAST(totalExecutionEnd AS CHAR), ' ; elapsed: ', CAST(TIMEDIFF(totalExecutionEnd, totalExecutionBegin) AS CHAR), '. EXIT.');
    SELECT totalExecutionTimer;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `A1issues_per_publication_NO`
--

/*!50001 DROP TABLE IF EXISTS `A1issues_per_publication_NO`*/;
/*!50001 DROP VIEW IF EXISTS `A1issues_per_publication_NO`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `A1issues_per_publication_NO` AS (select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where (`issues`.`pub_id` = 'NO')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AQMneedsMWAnum`
--

/*!50001 DROP TABLE IF EXISTS `AQMneedsMWAnum`*/;
/*!50001 DROP VIEW IF EXISTS `AQMneedsMWAnum`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `AQMneedsMWAnum` AS (select `p`.`pub_id` AS `pub_id`,`p`.`OCLC` AS `OCLC`,`p`.`marc001` AS `marc001`,`p`.`pub_title` AS `pub_title`,`p`.`pub_city` AS `pub_city`,`p`.`country_id` AS `country_id`,`p`.`pub_bgnDate` AS `pub_bgnDate`,`p`.`pub_endDate` AS `pub_endDate`,`p`.`date362` AS `date362`,`p`.`freq_id_code` AS `freq_id_code` from `publications` `p` where (`p`.`pub_id` in (select distinct `issues`.`pub_id` from `issues` where (`issues`.`org_id` = 'AQM')) and (not((`p`.`marc001` like '%(MWA)%')))) order by `p`.`pub_title`,`p`.`pub_city`,`p`.`pub_bgnDate`,`p`.`freq_id_code`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `C3issues_view_sn82014768_DLC`
--

/*!50001 DROP TABLE IF EXISTS `C3issues_view_sn82014768_DLC`*/;
/*!50001 DROP VIEW IF EXISTS `C3issues_view_sn82014768_DLC`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `C3issues_view_sn82014768_DLC` AS (select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where (`issues`.`pub_id` = 'sn82014768') order by `issues`.`issue_date`,`issues`.`format_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `C3publications_per_org_fill_single_publication_2012225114`
--

/*!50001 DROP TABLE IF EXISTS `C3publications_per_org_fill_single_publication_2012225114`*/;
/*!50001 DROP VIEW IF EXISTS `C3publications_per_org_fill_single_publication_2012225114`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `C3publications_per_org_fill_single_publication_2012225114` AS (select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where ((`issues`.`pub_id` = '2012225114') and (`issues`.`org_id` = 'CRL')) order by `issues`.`issue_date`,`issues`.`format_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `C3publications_per_org_fill_single_publication_sn94022381`
--

/*!50001 DROP TABLE IF EXISTS `C3publications_per_org_fill_single_publication_sn94022381`*/;
/*!50001 DROP VIEW IF EXISTS `C3publications_per_org_fill_single_publication_sn94022381`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `C3publications_per_org_fill_single_publication_sn94022381` AS (select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where ((`issues`.`pub_id` = 'sn94022381') and (`issues`.`org_id` = 'CRL')) order by `issues`.`issue_date`,`issues`.`format_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `C3publications_per_org_temp_view`
--

/*!50001 DROP TABLE IF EXISTS `C3publications_per_org_temp_view`*/;
/*!50001 DROP VIEW IF EXISTS `C3publications_per_org_temp_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `C3publications_per_org_temp_view` AS select distinct `issues`.`pub_id` AS `pub_id` from `issues` where (`issues`.`org_id` = 'DLC') order by `issues`.`pub_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OrgFirst`
--

/*!50001 DROP TABLE IF EXISTS `OrgFirst`*/;
/*!50001 DROP VIEW IF EXISTS `OrgFirst`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `OrgFirst` AS (select distinct `p`.`pub_id` AS `pub_id`,`p`.`OCLC` AS `OCLC`,concat(`p`.`pub_title`,' (',`p`.`pub_city`,', ',`c`.`country_name`,' : ',coalesce(`p`.`pub_bgnDate`,''),'-',coalesce(`p`.`pub_endDate`,''),')') AS `uniform_title`,'DLC' AS `held_by_org_1` from ((`publications` `p` join `issues` `i` on((`p`.`pub_id` = `i`.`pub_id`))) join `countries` `c` on((`c`.`country_id` = `p`.`country_id`))) where (`i`.`org_id` = 'DLC')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `OrgSecond`
--

/*!50001 DROP TABLE IF EXISTS `OrgSecond`*/;
/*!50001 DROP VIEW IF EXISTS `OrgSecond`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `OrgSecond` AS (select distinct `p`.`pub_id` AS `pub_id`,`p`.`OCLC` AS `OCLC`,concat(`p`.`pub_title`,' (',`p`.`pub_city`,', ',`c`.`country_name`,' : ',coalesce(`p`.`pub_bgnDate`,''),'-',coalesce(`p`.`pub_endDate`,''),')') AS `uniform_title`,'PQHN' AS `held_by_org_2` from ((`publications` `p` join `issues` `i` on((`p`.`pub_id` = `i`.`pub_id`))) join `countries` `c` on((`c`.`country_id` = `p`.`country_id`))) where (`i`.`org_id` = 'PQHN')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `collection_issues`
--

/*!50001 DROP TABLE IF EXISTS `collection_issues`*/;
/*!50001 DROP VIEW IF EXISTS `collection_issues`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `collection_issues` AS (select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where `issues`.`pub_id` in (select distinct `collection_publications`.`pub_id` from `collection_publications` order by `collection_publications`.`pub_title`) order by `issues`.`issue_date`,`issues`.`org_id`,`issues`.`format_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `collection_publications`
--

/*!50001 DROP TABLE IF EXISTS `collection_publications`*/;
/*!50001 DROP VIEW IF EXISTS `collection_publications`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `collection_publications` AS (select distinct `p`.`pub_id` AS `pub_id`,`p`.`pub_title` AS `pub_title`,`p`.`pub_city` AS `pub_city`,`Y`.`country_name` AS `country_name`,`p`.`pub_bgnDate` AS `pub_bgnDate`,`p`.`pub_endDate` AS `pub_endDate` from (`publications` `p` join `countries` `Y` on((`Y`.`country_id` = `p`.`country_id`))) where `p`.`pub_id` in (select distinct `pub_collections`.`pub_id` from `pub_collections` where (`pub_collections`.`collection_id` = 9)) order by `p`.`pub_title`,`p`.`pub_city`,`p`.`pub_bgnDate`,`p`.`pub_endDate`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `flnewCollections`
--

/*!50001 DROP TABLE IF EXISTS `flnewCollections`*/;
/*!50001 DROP VIEW IF EXISTS `flnewCollections`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flnewCollections` AS select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where ((`issues`.`org_id` = 'FLNEW') and (`issues`.`collection_id` = 1)) order by `issues`.`pub_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `format_view_sn82014768_DLC`
--

/*!50001 DROP TABLE IF EXISTS `format_view_sn82014768_DLC`*/;
/*!50001 DROP VIEW IF EXISTS `format_view_sn82014768_DLC`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`andy`@`192.168.1.%` SQL SECURITY DEFINER */
/*!50001 VIEW `format_view_sn82014768_DLC` AS (select `issues`.`issue_id` AS `issue_id`,`issues`.`pub_id` AS `pub_id`,`issues`.`issue_date` AS `issue_date`,`issues`.`rawIssueData` AS `rawIssueData`,`issues`.`org_id` AS `org_id`,`issues`.`condition_id` AS `condition_id`,`issues`.`format` AS `format`,`issues`.`format_id` AS `format_id`,`issues`.`archive_status_id` AS `archive_status_id`,`issues`.`provenance_id` AS `provenance_id`,`issues`.`collection_id` AS `collection_id`,`issues`.`update_date` AS `update_date`,`issues`.`issue_note` AS `issue_note`,`issues`.`specificIssuesCreated` AS `specificIssuesCreated`,`issues`.`specificIssuesCreatedDate` AS `specificIssuesCreatedDate` from `issues` where ((`issues`.`pub_id` = 'sn82014768') and (`issues`.`org_id` = 'DLC'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-09 13:59:21
