package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_818 extends BaseMapProcess
   {
      
      public function MapProcess_818()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86058768);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         MapListenerManager.add(depthLevel["ruiersi"],function():void
         {
            SocketConnection.send(1022,86058200);
            ModuleManager.showModule(ClientConfig.getAppModule("TwelveRounds/RuiersiNewSkillPanel"),"正在努力打开面板...");
         },"瑞尔斯的领悟");
      }
      
      override public function destroy() : void
      {
      }
   }
}

