-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: nailology
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
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL,
  `category_label` varchar(100) DEFAULT NULL,
  `description` varchar(800) DEFAULT NULL,
  `display_order` int DEFAULT NULL,
  `duration_label` varchar(50) DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `homepage_featured` bit(1) DEFAULT NULL,
  `is_builder_gel` bit(1) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `starting_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'BASIC','Nail Cơ Bản','Làm sạch da thừa, nhặt da tay/chân kỹ lưỡng và tạo form móng gọn gàng.',1,'20-30 phút',30,_binary '\0',_binary '','Cắt Da & Vệ Sinh Móng',30000.00),(2,'BASIC','Nail Cơ Bản','Tháo lớp sơn gel cũ an toàn, không làm mỏng móng thật, bao gồm dưỡng móng.',2,'15 phút',15,_binary '\0',_binary '','Phá Sơn Gel',30000.00),(3,'BASIC','Nail Cơ Bản','Tháo gỡ móng úp hoặc móng đắp bột/gel kỹ thuật cao, ủ dưỡng phục hồi.',3,'30 phút',30,_binary '\0',_binary '','Phá Móng Giả / Úp',50000.00),(4,'GEL','Sơn móng','Sơn gel màu trơn hoặc màu thạch trong trẻo. Bền màu 3-4 tuần.',2,'45 phút',45,_binary '',_binary '','Sơn Thạch',120000.00),(5,'GEL','Sơn móng','Lớp phủ gia cố giúp móng thật cứng cáp, chống gãy xước (Khuyên dùng cho móng yếu).',2,'15 phút',15,_binary '\0',_binary '','Phủ Cứng Móng (Overlay)',50000.00),(6,'ART','Design','Kỹ thuật úp móng Soft Gel sử dụng Base chuyên dụng, nhẹ như móng thật, form chuẩn. (Giá gốc menu: 60k)',6,'60 phút',60,_binary '',_binary '','Úp Móng Gia Bằng Base',150000.00),(7,'ART','Design','Hiệu ứng tráng gương kim loại, mắt mèo lấp lánh hoặc loang màu Ombre. Giá tính theo bộ hoặc ngón.',7,'20 phút',20,_binary '\0',_binary '','Tráng Gương / Mắt Mèo / Ombre',50000.00),(8,'ART','Design','Vẽ cọ nét hoặc vẽ nổi 3D (hoa, hoạt hình, họa tiết). Giá tùy độ khó.',8,'30 phút',30,_binary '',_binary '','Vẽ Hình / Vẽ Nổi',40000.00),(9,'ART','Design','Đính đá sáng, charm nơ, đá khối sang chảnh. Giá tham khảo từ 10k-30k/viên.',9,'15 phút',15,_binary '\0',_binary '','Đính Đá / Charm / Khối',20000.00),(10,'COMBO','Combo Tiết Kiệm','Gói combo cơ bản cho đôi tay xinh. Tiết kiệm hơn so với làm lẻ.',10,'60 phút',60,_binary '',_binary '','Combo: Cắt Da + Sơn Gel',140000.00),(11,'COMBO','Combo Tiết Kiệm','Gói Full set thay đổi hoàn toàn diện mạo bộ móng. Bao gồm nối dài và sơn màu.',11,'90-120 phút',100,_binary '',_binary '','Combo: Cắt Da + Úp Móng + Sơn Gel',250000.00),(12,'OTHER','Dịch Vụ Khác','Uốn mi cong tự nhiên, phủ dưỡng Collagen giúp mi đen bóng. Giữ cong 1-2 tháng.',12,'45-60 phút',60,_binary '\0',_binary '','Uốn Mi Collagen',150000.00),(13,'OTHER','Dịch Vụ Khác','Làm sạch lông mặt giúp da sáng mịn, dễ ăn phấn trang điểm.',13,'15 phút',15,_binary '\0',_binary '','Cạo Lông Mặt / Tỉa Lông Mày',30000.00),(15,'GEL','Sơn móng','Sơn gel bền màu, bóng đẹp từ 2–3 tuần. 9K/ngón',2,'45 phút',45,_binary '',_binary '','Sơn Gel',85000.00),(17,'ART','Design','Kéo dài móng, giữ form chắc chắn',4,'60 phút',60,_binary '',_binary '','Úp móng gel',80000.00),(18,'ART','Design','Họa tiết đơn giản, tinh tế',10,'10 phút / ngón',10,_binary '\0',_binary '','Vẽ nail đơn giản',10000.00),(19,'ART','Design','Thiết kế nhiều chi tiết theo mẫu',11,'15 phút / ngón',15,_binary '\0',_binary '','Vẽ nail chi tiết',20000.00),(20,'ART','Design','Hiệu ứng ánh sáng hoặc chuyển màu',20,'5 phút / ngón',5,_binary '\0',_binary '','Mắt mèo / Ombre',5000.00),(21,'ART','Design','Đá trang trí nhỏ',21,NULL,NULL,_binary '\0',_binary '','Đá nhỏ',2000.00),(23,'FEET','Chăm sóc chân','Làm sạch da chết, tạo form móng chân gọn gàng',40,'25 phút',25,_binary '',_binary '','Cắt da & vệ sinh móng chân',30000.00),(25,'FEET','Chăm sóc chân','Gia cố móng chân yếu, hạn chế gãy',42,'15 phút',15,_binary '\0',_binary '','Phủ cứng móng chân',15000.00),(26,'FEET','Chăm sóc chân','Làm sạch da chết, gót chân mềm mịn',43,'30 phút',30,_binary '',_binary '','Chăm sóc gót chân',50000.00),(27,'FEET','Chăm sóc chân','Thư giãn, kích thích tuần hoàn máu',44,'20 phút',20,_binary '\0',_binary '','Massage chân thư giãn',30000.00),(28,'GEL','Sơn móng','Tạo độ lấp lánh cho móng',2,'30-45 phút',45,_binary '\0',_binary '','Sơn nhũ',120000.00),(29,'ART','Design','Đá trang trí khối nhỏ',9,NULL,NULL,_binary '\0',_binary '','Đá khối nhỏ',5000.00),(30,'ART','Design','Đá trang trí khối lớn',9,NULL,NULL,_binary '\0',_binary '','Đá khối lớn',15000.00),(31,'ART','Design','Charm trang trí nhỏ',9,NULL,NULL,_binary '\0',_binary '','Charm nhỏ',7000.00),(32,'ART','Design','Charm trang trí lớn',9,NULL,NULL,_binary '\0',_binary '','Charm lớn',20000.00),(33,'GEL','Sơn móng','Tạo độ lấp lánh cho móng',2,'30-45 phút',45,_binary '\0',_binary '','Sơn nhũ',120000.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-19 21:43:27
