Base --- 框架的核心库 （收集开发中常用的历经考验的优秀代码 实现多项目共享）

robotlegs --- 
 injector.mapValue 				实例映射  需要手动给该实例注入injector.injectInto(实例)
 injector.mapClass 				类映射 每次注入都是新实例 
 injector.mapSingleton 			类映射 提供唯一实例 饿汉式
 injector.mapSingletonOf 		接口映射 类似mapSingleton
 injector.instantiate(MyClass)  获取新实例
 
 MVCS  
 view 		层处理用户交互. 
 model 		层负责处理数据. 
 controller 负责各层之间交互.
 service 	层负责和外界（主要是服务端）交互.
 
 Context 提供一个通讯域  利用它可以实现模块化编程
 Command 是封装业务逻辑的绝佳场所（什么是业务逻辑）
 	Command 被 Mediators, Services, Models, 和其它 Command 广播的框架事件触发
 	映射 Mediator, Model, Service, 或者其它 Command
	广播可能被 Mediator 接收或者触发其它 Command 的事件
	被注入Model, Service 以直接进行工作.
 Mediator 处理特有的逻辑 （什么是特有的逻辑）
 	mediator 不要被其他层注入	建议注入需要的model和service来简化流程 高效开发  所以commond不是在出现各层交互的第一选择
 Model 封装数据 操作数据 发送事件
 Service 与外界交互 发送事件
 
 Robotlegs 不支持事件冒泡
 
 greensock --- 重点推荐loadermax