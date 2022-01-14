# MockApp
通过分层和接口的架构设计，实现可以快速Mock,单元测试的APP实例。

![](./images/login.jpg)![](./images/1.jpg)
![](./images/2.jpg)
![](./images/3.jpg)

## 功能
* 登录，注册。
* 发帖，帖子列表，评论。
* 帖子点赞和帖子收藏。
* 修改用户昵称和头像。

## 架构
* 三层结构：业务层，持久层，展示层。
* 本地实现业务逻辑。
* 使用内存来实现持久层。


ui:展示层，主要负责数据展示和用户交互。  

domain:业务层，利用抽象的Repository和Service接口实现业务逻辑UseCase，UseCase作为Api接口提供给三方使用。  

data:持久层具体实现。  

di: 通过ServiceLocator简单实现依赖注入，达到控制反转。  

![](./images/4.jpg)

domain层和data层中的代码，根据需求可能直接移动到服务端，就是常见到Server/Client模式。


![](./images/5.jpg)
