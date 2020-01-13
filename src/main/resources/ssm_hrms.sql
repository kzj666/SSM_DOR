
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `tbl_dor`;
CREATE TABLE `tbl_dor` (
  `dor_id` varchar(10) NOT NULL,
  `dor_name` varchar(20) NOT NULL,
  `dor_master` varchar(20) NOT NULL,
  PRIMARY KEY (`dor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tbl_lb`;
CREATE TABLE `tbl_lb` (
  `lb_num` int(11) NOT NULL AUTO_INCREMENT,
  `lb_id` varchar(11) NOT NULL,
  `lb_name` varchar(20) NOT NULL,
  `lb_time` varchar(50) NOT NULL,
  PRIMARY KEY (`lb_num`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tbl_stu`;
CREATE TABLE `tbl_stu` (
  `stu_id` int(11) NOT NULL,
  `stu_name` varchar(20) NOT NULL,
  `stu_tel` varchar(11) NOT NULL,
  `gender` char(2) NOT NULL,
  `sdor_id` varchar(10) NOT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tbl_vtr`;
CREATE TABLE `tbl_vtr` (
  `vtr_id` varchar(30) NOT NULL,
  `vtr_name` varchar(30) NOT NULL,
  `vtr_time` varchar(50) NOT NULL,
  `vtr_reason` varchar(30) NOT NULL,
  PRIMARY KEY (`vtr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

