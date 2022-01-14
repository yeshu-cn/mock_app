# MockApp
通过分层和接口的架构设计，实现可以快速Mock,单元测试的APP实例。


<image src='./images/1.jpg' width=15%> <image src='./images/2.jpg' width=15%> <image src='./images/3.jpg' width=15%> 
  <image src='./images/mine.jpg' width=15%> <image src='./images/login.jpg' width=15%> 



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

 <image src='./images/4.jpg' width=50%>

domain层和data层中的代码，根据需求可能直接移动到服务端，就是常见到Server/Client模式。


<image src='./images/5.jpg' width=50%>

  
## 思考
和朋友讨论时，他问我这架构里面UI数据的缓存代码怎么写，怎么做网络请求的优化？

写这个Demo出来目的是根据代码职责，理清代码所在层次和所属角色。
  
  具体的缓存策略和网络请求的优化，这个属于业务的具体实现，它的实现方法有各种各样，不是架构关心的内容，架构关心的是你的UI缓存代码肯定不能放在Domain中，你的网络请求优化代码肯定不能在Repository中。
  
  
  
