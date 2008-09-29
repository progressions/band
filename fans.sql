-- MySQL dump 10.11
--
-- Host: localhost    Database: jcoleman_band_dev
-- ------------------------------------------------------
-- Server version	5.0.45-community-nt

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
-- Table structure for table `fans`
--

DROP TABLE IF EXISTS `fans`;
CREATE TABLE `fans` (
  `id` int(11) NOT NULL auto_increment,
  `firstname` varchar(255) default NULL,
  `lastname` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `zipcode` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fans`
--

LOCK TABLES `fans` WRITE;
/*!40000 ALTER TABLE `fans` DISABLE KEYS */;
INSERT INTO `fans` VALUES (82,'Jeff','Coleman','progressions@gmail.com',78745,'2008-01-22 04:50:45','2008-01-22 04:50:46'),(83,'Reed','Oliver','reedoliver@gmail.com',78704,'2008-01-22 04:50:46','2008-01-22 04:50:46'),(84,'Dan','Carroll','dan.carroll1@gmail.com',60613,'2008-01-22 04:50:46','2008-01-22 04:50:46'),(85,'Bernadette','Donahue','bernadettedonahue@gmail.com',78723,'2008-01-22 04:50:46','2008-01-22 04:50:46'),(86,'Mark','Cooper','interpcoord@gmail.com',21204,'2008-01-22 04:50:46','2008-01-22 04:50:46'),(87,'Anneke','Stagg','astagginla@yahoo.com',78704,'2008-01-22 04:50:46','2008-01-22 04:50:46'),(88,'Carolyn','Coleman','caroltex@aol.com',78749,'2008-01-22 04:50:46','2008-01-22 04:50:46'),(89,'John','Jordan','john@texamericana.org',78704,'2008-01-22 04:50:46','2008-01-22 04:50:48'),(90,'Meisha','Campbell','meishaca@gmail.com',78704,'2008-01-22 04:50:48','2008-01-22 04:50:48'),(91,'Jennifer','Smith','jennsmithpants@gmail.com',78704,'2008-01-22 04:50:48','2008-01-22 04:50:48'),(92,'Michael','Nandin','myfault_04@yahoo.com',78704,'2008-01-22 04:50:48','2008-01-22 04:50:48'),(94,'Rafer','Roberts','rafer@plasticfarm.com',21755,'2008-01-22 04:50:48','2008-01-22 04:50:51'),(95,'Eric','Bramblett','EBramblett@mail.utexas.edu',78751,'2008-01-22 04:50:51','2008-01-22 04:50:51'),(96,'Jimmy','Mack','jimmy_then@yahoo.com',78722,'2008-01-22 04:50:51','2008-01-22 04:50:51'),(97,'Steve','Brooks','steve@stevebrooks.net',78704,'2008-01-22 04:50:51','2008-01-22 04:50:52'),(98,'Scott','Melcer','scott.melcer@gmail.com',78723,'2008-01-22 04:50:52','2008-01-22 04:50:52'),(99,'cathie','h.','cahcat@gmail.com',91754,'2008-01-22 04:50:52','2008-01-22 04:50:52'),(100,'Jeff','Chon','jeffchon@sbcglobal.net',90744,'2008-01-22 04:50:52','2008-01-22 04:50:52'),(101,'Chris','Myers','Chris.Myers2@med.navy.mil',92130,'2008-01-22 04:50:52','2008-01-22 04:50:53'),(102,'Gary','Graves','veryveryfree2003@yahoo.com',78751,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(103,'Gary','Oliver','betholiver@earthlink.net',78759,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(104,'Megan','Allen','megana1360@gmail.com',78704,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(105,'R','B','rron_rron@yahoo.com',78723,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(106,'DumbDumb','-','drbrost@hotmail.com',68382,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(107,'-','Dash','bdbrost@yahoo.com',69965,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(108,'Sarah','Bentley','joyflosone@gmail.com',78704,'2008-01-22 04:54:01','2008-01-22 04:54:02'),(109,'Laura','Farb','farbulous@gmail.com',78704,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(110,'Cobi','Bentley','cobione@hotmail.com',78704,'2008-01-22 04:50:53','2008-01-22 04:50:53'),(112,'Eva','Barnett','eva.barnett@sbcglobal.net',78704,'2008-01-22 04:50:53','2008-01-22 04:50:54'),(113,'Jonny','Dub','dub.jonny@gmail.com',78723,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(114,'Katy','Klapuch','kpendley08@gmail.com',78741,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(115,'Diego','de la Llata','southsidechiller@hotmail.com',78745,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(116,'Erika','West','akire_drladymomma@yahoo.com',78230,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(117,'Sunny','Fairly','jaster_bf@hotmail.com',78751,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(118,'Anita','Wilson','shutupisanita@yahoo.com',78704,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(119,'Spencer','Davenport','cesarthedeal@yahoo.com',78750,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(120,'Ivan','Miller','ivanpoet@aol.com',78759,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(121,'Kurt','O\'Reilly','throwinthunder34@yahoo.com',78741,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(122,'Christian','Piette','chinpiette@gmail.com',78704,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(123,'Daniel','Davies','thewaydh@yahoo.com',78757,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(124,'Jody','-','jodyacomas@yahoo.com',78704,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(125,'The Good Jim','Jones','thegoodjimjones5@yahoo.com',78744,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(126,'Beav','Er','thebeav777@yahoo.com',78748,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(127,'Caresa','Huddleston','unimportantfact@yahoo.com',78725,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(128,'Barbara','Carlton','hotmustangrl1@yahoo.com',78748,'2008-01-22 04:50:54','2008-01-22 04:50:54'),(129,'Frank','Eisenberg','5125767156@tmomail.net',78704,'2008-01-22 04:50:54','2008-01-22 04:50:55'),(130,'Tom','O\'Hara','tomasohara@gmail.com',78747,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(131,'Dominique','Del Santo','dominiquedelsanto@gmail.com',78745,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(132,'Lady','Bell','ladybbluez@yahoo.com',78701,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(133,'Mary','Kate','chef.skinny@gmail.com',78701,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(134,'Darby','Griffiths','darbygriffiths@gmail.com',78744,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(135,'Mat','Keputa','mlkeputa@yahoo.com',78704,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(136,'Solana','Weaver','solanaweaver555@yahoo.com',78745,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(137,'Jawn','D-Funk','kaosmunkey@yahoo.com',78745,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(138,'Mark','Turk','turkmark@gmail.com',78731,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(139,'Billy','Leger','billy333@gmail.com',78704,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(140,'P Kellach','Waddle','gusmahler2@aol.com',78741,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(141,'Shantel','Vosburg','shantelv1@sbcglobal.net',78704,'2008-01-22 04:50:55','2008-01-22 04:50:55'),(142,'Kevin','Ketterlin','kevket07@gmail.com',78704,'2008-01-22 04:50:56','2008-01-22 04:50:56'),(143,'Clint','Night','clinton.hofmeister@ci.austin.tx.us',78704,'2008-01-22 04:50:56','2008-01-22 04:50:56'),(144,'Forence','Wong','fwtwong@gmail.com',78705,'2008-01-22 04:50:56','2008-01-22 04:50:56');
/*!40000 ALTER TABLE `fans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-01-22 17:11:05
