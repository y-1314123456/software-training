-- 创建数据库
CREATE DATABASE IF NOT EXISTS campus_secondhand DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campus_secondhand;

-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
  username VARCHAR(50) NOT NULL COMMENT '账号',
  password VARCHAR(100) NOT NULL COMMENT '密码',
  nickname VARCHAR(50) COMMENT '昵称',
  role VARCHAR(20) NOT NULL COMMENT '角色：buyer买家,seller卖家,admin管理员',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 商品表
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '商品id',
  user_id INT NOT NULL COMMENT '发布者用户id',
  title VARCHAR(200) COMMENT '商品标题',
  description TEXT COMMENT '商品描述',
  suggest_price DECIMAL(10,2) COMMENT 'AI建议定价',
  category VARCHAR(50) COMMENT '商品分类：教材/数码/宿舍好物',
  quality VARCHAR(30) COMMENT '成色',
  image_url VARCHAR(500) COMMENT '图片地址',
  status TINYINT DEFAULT 1 COMMENT '0下架 1上架',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 历史成交记录表(RAG比价知识库)
DROP TABLE IF EXISTS `trade_history`;
CREATE TABLE `trade_history` (
  id INT PRIMARY KEY AUTO_INCREMENT,
  category VARCHAR(50) COMMENT '物品分类',
  quality VARCHAR(30) COMMENT '成色',
  trade_price DECIMAL(10,2) COMMENT '成交价格',
  trade_time DATETIME COMMENT '成交时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 聊天消息表
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message` (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT COMMENT '关联商品id',
  sender_id INT COMMENT '发送人id',
  receiver_id INT COMMENT '接收人id',
  message TEXT COMMENT '消息内容',
  is_agent_reply TINYINT DEFAULT 0 COMMENT '0用户消息 1Agent自动回复',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------测试初始化数据----------------
INSERT INTO `user`(username,password,nickname,role) VALUES
('stu01','123456','学生甲','seller'),
('stu02','123456','学生乙','buyer'),
('admin','admin123','管理员','admin');

INSERT INTO trade_history(category,quality,trade_price,trade_time) VALUES
('教材','九成新',25.00,'2026-03-10 10:20:00'),
('数码','八成新',320.00,'2026-03-15 14:10:00'),
('宿舍好物','全新',45.00,'2026-04-02 09:30:00');
