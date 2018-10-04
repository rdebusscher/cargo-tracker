
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
-- Table structure for table `CARGO`
--

DROP TABLE IF EXISTS CARGO;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE CARGO (
  ID bigint(20) NOT NULL,
  calculated_at datetime(3) DEFAULT NULL,
  ETA date DEFAULT NULL,
  unloaded_at_dest tinyint(1) DEFAULT '0',
  MISDIRECTED tinyint(1) DEFAULT '0',
  routing_status varchar(255) DEFAULT NULL,
  transport_status varchar(255) DEFAULT NULL,
  next_expected_handling_event_type varchar(255) DEFAULT NULL,
  next_expected_location_id bigint(20) DEFAULT NULL,
  next_expected_voyage_id bigint(20) DEFAULT NULL,
  current_voyage_id bigint(20) DEFAULT NULL,
  last_event_id bigint(20) DEFAULT NULL,
  last_known_location_id bigint(20) DEFAULT NULL,
  spec_arrival_deadline date DEFAULT NULL,
  spec_destination_id bigint(20) DEFAULT NULL,
  spec_origin_id bigint(20) DEFAULT NULL,
  tracking_id varchar(255) DEFAULT NULL,
  origin_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (ID),
  UNIQUE KEY tracking_id (tracking_id),
  KEY FK_CARGO_next_expected_voyage_id (next_expected_voyage_id),
  KEY FK_CARGO_origin_id (origin_id),
  KEY FK_CARGO_next_expected_location_id (next_expected_location_id),
  KEY FK_CARGO_current_voyage_id (current_voyage_id),
  KEY FK_CARGO_spec_destination_id (spec_destination_id),
  KEY FK_CARGO_last_known_location_id (last_known_location_id),
  KEY FK_CARGO_last_event_id (last_event_id),
  KEY FK_CARGO_spec_origin_id (spec_origin_id),
  CONSTRAINT FK_CARGO_current_voyage_id FOREIGN KEY (current_voyage_id) REFERENCES VOYAGE (ID),
  CONSTRAINT FK_CARGO_last_event_id FOREIGN KEY (last_event_id) REFERENCES HANDLINGEVENT (ID),
  CONSTRAINT FK_CARGO_last_known_location_id FOREIGN KEY (last_known_location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_CARGO_next_expected_location_id FOREIGN KEY (next_expected_location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_CARGO_next_expected_voyage_id FOREIGN KEY (next_expected_voyage_id) REFERENCES VOYAGE (ID),
  CONSTRAINT FK_CARGO_origin_id FOREIGN KEY (origin_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_CARGO_spec_destination_id FOREIGN KEY (spec_destination_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_CARGO_spec_origin_id FOREIGN KEY (spec_origin_id) REFERENCES LOCATION (ID)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CARGO`
--

/*!40000 ALTER TABLE CARGO DISABLE KEYS */;
INSERT INTO CARGO VALUES (1932,'2018-10-01 11:51:02.265','2018-10-15',0,0,'ROUTED','IN_PORT','LOAD',1912,1919,NULL,1938,1912,'2018-10-16',1904,1901,'ABC123',1901);
INSERT INTO CARGO VALUES (1939,'2018-10-01 11:51:02.308',NULL,0,1,'ROUTED','ONBOARD_CARRIER',NULL,NULL,NULL,1914,1946,1912,'2018-10-19',1903,1911,'JKL567',1911);
INSERT INTO CARGO VALUES (1947,'2018-10-01 11:51:02.309',NULL,0,0,'NOT_ROUTED','NOT_RECEIVED',NULL,NULL,NULL,NULL,NULL,NULL,'2018-12-01',1902,1901,'DEF789',1901);
INSERT INTO CARGO VALUES (1948,'2018-10-01 11:51:02.344','2018-09-03',0,0,'ROUTED','CLAIMED',NULL,NULL,NULL,NULL,1954,1913,'2018-09-07',1913,1912,'MNO456',1912);
/*!40000 ALTER TABLE CARGO ENABLE KEYS */;

--
-- Table structure for table `HANDLINGEVENT`
--

DROP TABLE IF EXISTS HANDLINGEVENT;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE HANDLINGEVENT (
  ID bigint(20) NOT NULL,
  completionTime date DEFAULT NULL,
  registration date DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  cargo_id bigint(20) DEFAULT NULL,
  location_id bigint(20) DEFAULT NULL,
  voyage_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (ID),
  KEY FK_HANDLINGEVENT_cargo_id (cargo_id),
  KEY FK_HANDLINGEVENT_location_id (location_id),
  KEY FK_HANDLINGEVENT_voyage_id (voyage_id),
  CONSTRAINT FK_HANDLINGEVENT_cargo_id FOREIGN KEY (cargo_id) REFERENCES CARGO (ID),
  CONSTRAINT FK_HANDLINGEVENT_location_id FOREIGN KEY (location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_HANDLINGEVENT_voyage_id FOREIGN KEY (voyage_id) REFERENCES VOYAGE (ID)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HANDLINGEVENT`
--

/*!40000 ALTER TABLE HANDLINGEVENT DISABLE KEYS */;
INSERT INTO HANDLINGEVENT VALUES (1936,'2018-09-21','2018-10-01','RECEIVE',1932,1901,NULL);
INSERT INTO HANDLINGEVENT VALUES (1937,'2018-09-24','2018-10-01','LOAD',1932,1901,1914);
INSERT INTO HANDLINGEVENT VALUES (1938,'2018-09-30','2018-10-01','UNLOAD',1932,1912,1914);
INSERT INTO HANDLINGEVENT VALUES (1943,'2018-09-16','2018-10-01','RECEIVE',1939,1911,NULL);
INSERT INTO HANDLINGEVENT VALUES (1944,'2018-09-21','2018-10-01','LOAD',1939,1911,1914);
INSERT INTO HANDLINGEVENT VALUES (1945,'2018-09-28','2018-10-01','UNLOAD',1939,1912,1914);
INSERT INTO HANDLINGEVENT VALUES (1946,'2018-09-29','2018-10-01','LOAD',1939,1912,1914);
INSERT INTO HANDLINGEVENT VALUES (1950,'2018-08-25','2018-10-01','RECEIVE',1948,1912,NULL);
INSERT INTO HANDLINGEVENT VALUES (1951,'2018-08-28','2018-10-01','LOAD',1948,1912,1919);
INSERT INTO HANDLINGEVENT VALUES (1952,'2018-09-03','2018-10-01','UNLOAD',1948,1913,1919);
INSERT INTO HANDLINGEVENT VALUES (1953,'2018-09-04','2018-10-01','CUSTOMS',1948,1913,NULL);
INSERT INTO HANDLINGEVENT VALUES (1954,'2018-09-05','2018-10-01','CLAIM',1948,1913,NULL);
/*!40000 ALTER TABLE HANDLINGEVENT ENABLE KEYS */;

--
-- Table structure for table `LEG`
--

DROP TABLE IF EXISTS LEG;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE LEG (
  ID bigint(20) NOT NULL,
  load_time date DEFAULT NULL,
  unload_time date DEFAULT NULL,
  load_location_id bigint(20) DEFAULT NULL,
  unload_location_id bigint(20) DEFAULT NULL,
  voyage_id bigint(20) DEFAULT NULL,
  cargo_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (ID),
  KEY FK_LEG_unload_location_id (unload_location_id),
  KEY FK_LEG_load_location_id (load_location_id),
  KEY FK_LEG_cargo_id (cargo_id),
  KEY FK_LEG_voyage_id (voyage_id),
  CONSTRAINT FK_LEG_cargo_id FOREIGN KEY (cargo_id) REFERENCES CARGO (ID),
  CONSTRAINT FK_LEG_load_location_id FOREIGN KEY (load_location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_LEG_unload_location_id FOREIGN KEY (unload_location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_LEG_voyage_id FOREIGN KEY (voyage_id) REFERENCES VOYAGE (ID)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LEG`
--

/*!40000 ALTER TABLE LEG DISABLE KEYS */;
INSERT INTO LEG VALUES (1933,'2018-09-24','2018-09-30',1901,1912,1914,1932);
INSERT INTO LEG VALUES (1934,'2018-10-03','2018-10-07',1912,1913,1919,1932);
INSERT INTO LEG VALUES (1935,'2018-10-09','2018-10-15',1913,1904,1922,1932);
INSERT INTO LEG VALUES (1940,'2018-09-21','2018-09-28',1911,1912,1914,1939);
INSERT INTO LEG VALUES (1941,'2018-09-29','2018-10-03',1912,1913,1919,1939);
INSERT INTO LEG VALUES (1942,'2018-10-07','2018-10-16',1913,1903,1922,1939);
INSERT INTO LEG VALUES (1949,'2018-08-28','2018-09-03',1912,1913,1919,1948);
/*!40000 ALTER TABLE LEG ENABLE KEYS */;

--
-- Table structure for table `LOCATION`
--

DROP TABLE IF EXISTS LOCATION;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE LOCATION (
  ID bigint(20) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  UNLOCODE varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCATION`
--

/*!40000 ALTER TABLE LOCATION DISABLE KEYS */;
INSERT INTO LOCATION VALUES (1901,'Hong Kong','CNHKG');
INSERT INTO LOCATION VALUES (1902,'Melbourne','AUMEL');
INSERT INTO LOCATION VALUES (1903,'Stockholm','SESTO');
INSERT INTO LOCATION VALUES (1904,'Helsinki','FIHEL');
INSERT INTO LOCATION VALUES (1905,'Chicago','USCHI');
INSERT INTO LOCATION VALUES (1906,'Tokyo','JNTKO');
INSERT INTO LOCATION VALUES (1907,'Hamburg','DEHAM');
INSERT INTO LOCATION VALUES (1908,'Shanghai','CNSHA');
INSERT INTO LOCATION VALUES (1909,'Rotterdam','NLRTM');
INSERT INTO LOCATION VALUES (1910,'Guttenburg','SEGOT');
INSERT INTO LOCATION VALUES (1911,'Hangzhou','CNHGH');
INSERT INTO LOCATION VALUES (1912,'New York','USNYC');
INSERT INTO LOCATION VALUES (1913,'Dallas','USDAL');
/*!40000 ALTER TABLE LOCATION ENABLE KEYS */;

--
-- Table structure for table `MOVIE_CRITERIA`
--

DROP TABLE IF EXISTS MOVIE_CRITERIA;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE MOVIE_CRITERIA (
  id int(11) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  ACTORS varchar(200) NOT NULL,
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MOVIE_CRITERIA`
--

/*!40000 ALTER TABLE MOVIE_CRITERIA DISABLE KEYS */;
INSERT INTO MOVIE_CRITERIA VALUES (1,'The Matrix','Keanu Reeves, Laurence Fishburne, Carrie-Ann Moss');
INSERT INTO MOVIE_CRITERIA VALUES (2,'The Lord of The Rings','Elijah Wood, Ian Mckellen, Viggo Mortensen');
INSERT INTO MOVIE_CRITERIA VALUES (3,'Inception','Leonardo DiCaprio');
INSERT INTO MOVIE_CRITERIA VALUES (4,'The Shining','Jack Nicholson, Shelley Duvall');
/*!40000 ALTER TABLE MOVIE_CRITERIA ENABLE KEYS */;

--
-- Table structure for table `SEQUENCE`
--

DROP TABLE IF EXISTS SEQUENCE;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE SEQUENCE (
  SEQ_NAME varchar(50) NOT NULL,
  SEQ_COUNT decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (SEQ_NAME)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SEQUENCE`
--

/*!40000 ALTER TABLE SEQUENCE DISABLE KEYS */;
INSERT INTO SEQUENCE VALUES ('SEQ_GEN',2000);
/*!40000 ALTER TABLE SEQUENCE ENABLE KEYS */;

--
-- Table structure for table `VOYAGE`
--

DROP TABLE IF EXISTS VOYAGE;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE VOYAGE (
  ID bigint(20) NOT NULL,
  voyage_number varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VOYAGE`
--

/*!40000 ALTER TABLE VOYAGE DISABLE KEYS */;
INSERT INTO VOYAGE VALUES (1914,'0100S');
INSERT INTO VOYAGE VALUES (1919,'0200T');
INSERT INTO VOYAGE VALUES (1922,'0300A');
INSERT INTO VOYAGE VALUES (1926,'0400S');
INSERT INTO VOYAGE VALUES (1930,'0301S');
/*!40000 ALTER TABLE VOYAGE ENABLE KEYS */;

--
-- Table structure for table `carrier_movement`
--

DROP TABLE IF EXISTS carrier_movement;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE carrier_movement (
  ID bigint(20) NOT NULL,
  arrival_time datetime DEFAULT NULL,
  departure_time datetime DEFAULT NULL,
  arrival_location_id bigint(20) DEFAULT NULL,
  departure_location_id bigint(20) DEFAULT NULL,
  voyage_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (ID),
  KEY FK_carrier_movement_departure_location_id (departure_location_id),
  KEY FK_carrier_movement_voyage_id (voyage_id),
  KEY FK_carrier_movement_arrival_location_id (arrival_location_id),
  CONSTRAINT FK_carrier_movement_arrival_location_id FOREIGN KEY (arrival_location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_carrier_movement_departure_location_id FOREIGN KEY (departure_location_id) REFERENCES LOCATION (ID),
  CONSTRAINT FK_carrier_movement_voyage_id FOREIGN KEY (voyage_id) REFERENCES VOYAGE (ID)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrier_movement`
--

/*!40000 ALTER TABLE carrier_movement DISABLE KEYS */;
INSERT INTO carrier_movement VALUES (1915,'2013-10-03 14:30:00','2013-10-01 12:00:00',1911,1901,1914);
INSERT INTO carrier_movement VALUES (1916,'2013-10-06 06:15:00','2013-10-03 21:00:00',1906,1911,1914);
INSERT INTO carrier_movement VALUES (1917,'2013-10-12 11:30:00','2013-10-06 11:00:00',1902,1906,1914);
INSERT INTO carrier_movement VALUES (1918,'2013-10-23 23:10:00','2013-10-14 12:00:00',1912,1902,1914);
INSERT INTO carrier_movement VALUES (1920,'2013-10-24 17:45:00','2013-10-24 07:00:00',1905,1912,1919);
INSERT INTO carrier_movement VALUES (1921,'2013-10-25 19:30:00','2013-10-24 21:25:00',1913,1905,1919);
INSERT INTO carrier_movement VALUES (1923,'2013-10-31 14:00:00','2013-10-29 03:30:00',1907,1913,1922);
INSERT INTO carrier_movement VALUES (1924,'2013-11-01 18:40:00','2013-11-01 15:20:00',1903,1907,1922);
INSERT INTO carrier_movement VALUES (1925,'2013-11-02 11:15:00','2013-11-02 09:00:00',1904,1903,1922);
INSERT INTO carrier_movement VALUES (1927,'2013-11-06 14:10:00','2013-11-04 05:50:00',1909,1904,1926);
INSERT INTO carrier_movement VALUES (1928,'2013-11-22 16:40:00','2013-11-10 21:45:00',1908,1909,1926);
INSERT INTO carrier_movement VALUES (1929,'2013-11-28 13:37:00','2013-11-24 07:00:00',1901,1908,1926);
INSERT INTO carrier_movement VALUES (1931,'2013-11-05 15:45:00','2013-10-29 03:30:00',1904,1913,1930);
/*!40000 ALTER TABLE carrier_movement ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

