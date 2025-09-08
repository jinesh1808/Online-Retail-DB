-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (x86_64)
--
-- Host: localhost    Database: retail_db
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `billsummary`
--

DROP TABLE IF EXISTS `billsummary`;
/*!50001 DROP VIEW IF EXISTS `billsummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `billsummary` AS SELECT 
 1 AS `order_id`,
 1 AS `product`,
 1 AS `quantity`,
 1 AS `price`,
 1 AS `gst`,
 1 AS `base_amount`,
 1 AS `gst_amount`,
 1 AS `total_with_gst`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ordertotals`
--

DROP TABLE IF EXISTS `ordertotals`;
/*!50001 DROP VIEW IF EXISTS `ordertotals`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordertotals` AS SELECT 
 1 AS `order_id`,
 1 AS `customer`,
 1 AS `sum(od.quantity* od.price)`,
 1 AS `gst_amount`,
 1 AS `total_with_gst`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `paymentstatus`
--

DROP TABLE IF EXISTS `paymentstatus`;
/*!50001 DROP VIEW IF EXISTS `paymentstatus`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `paymentstatus` AS SELECT 
 1 AS `order_id`,
 1 AS `customer`,
 1 AS `bill_amount`,
 1 AS `paid_amount`,
 1 AS `payment_method`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `billsummry`
--

DROP TABLE IF EXISTS `billsummry`;
/*!50001 DROP VIEW IF EXISTS `billsummry`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `billsummry` AS SELECT 
 1 AS `order_id`,
 1 AS `product`,
 1 AS `quantity`,
 1 AS `price`,
 1 AS `gst`,
 1 AS `base_amount`,
 1 AS `gst_amount`,
 1 AS `total_with_gst`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `billsummary`
--

/*!50001 DROP VIEW IF EXISTS `billsummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `billsummary` AS select `od`.`order_id` AS `order_id`,`p`.`name` AS `product`,`od`.`quantity` AS `quantity`,`od`.`price` AS `price`,`od`.`gst` AS `gst`,(`od`.`quantity` * `od`.`price`) AS `base_amount`,(((`od`.`quantity` * `od`.`price`) * `od`.`gst`) / 100) AS `gst_amount`,((`od`.`quantity` * `od`.`price`) * (1 + (`od`.`gst` / 100))) AS `total_with_gst` from (((`orderdetails` `od` join `orders` `o` on((`od`.`order_id` = `o`.`order_id`))) join `customers` `c` on((`o`.`customer_id` = `c`.`customer_id`))) join `product` `p` on((`od`.`product_id` = `p`.`product_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ordertotals`
--

/*!50001 DROP VIEW IF EXISTS `ordertotals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ordertotals` AS select `od`.`order_id` AS `order_id`,`c`.`first_name` AS `customer`,sum((`od`.`quantity` * `od`.`price`)) AS `sum(od.quantity* od.price)`,sum((((`od`.`quantity` * `od`.`price`) * `od`.`gst`) / 100)) AS `gst_amount`,sum(((`od`.`quantity` * `od`.`price`) * (1 + (`od`.`gst` / 100)))) AS `total_with_gst` from ((`orderdetails` `od` join `orders` `o` on((`od`.`order_id` = `o`.`order_id`))) join `customers` `c` on((`o`.`customer_id` = `c`.`customer_id`))) group by `od`.`order_id`,`c`.`first_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `paymentstatus`
--

/*!50001 DROP VIEW IF EXISTS `paymentstatus`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `paymentstatus` AS select `ot`.`order_id` AS `order_id`,`ot`.`customer` AS `customer`,`ot`.`total_with_gst` AS `bill_amount`,`p`.`amount` AS `paid_amount`,`p`.`method` AS `payment_method`,(case when (round(`p`.`amount`,2) = round(`ot`.`total_with_gst`,2)) then 'Paid' when (`p`.`amount` is null) then 'No Payment' else 'Mismatch' end) AS `status` from (`ordertotals` `ot` left join `payments` `p` on((`ot`.`order_id` = `p`.`order_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `billsummry`
--

/*!50001 DROP VIEW IF EXISTS `billsummry`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `billsummry` AS select `od`.`order_id` AS `order_id`,`p`.`name` AS `product`,`od`.`quantity` AS `quantity`,`od`.`price` AS `price`,`od`.`gst` AS `gst`,(`od`.`quantity` * `od`.`price`) AS `base_amount`,(((`od`.`quantity` * `od`.`price`) * `od`.`gst`) / 100) AS `gst_amount`,((`od`.`quantity` * `od`.`price`) * (1 + (`od`.`gst` / 100))) AS `total_with_gst` from (((`orderdetails` `od` join `orders` `o` on((`od`.`order_id` = `o`.`order_id`))) join `customers` `c` on((`o`.`customer_id` = `c`.`customer_id`))) join `product` `p` on((`od`.`product_id` = `p`.`product_id`))) */;
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

-- Dump completed on 2025-09-08 20:46:30
