package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10790 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10790()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86059548);
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         MapListenerManager.add(depthLevel["bulaike12"],function():void
         {
            SocketConnection.send(1022,86060680);
            ModuleManager.showModule(ClientConfig.getAppModule("SuperBrotherPKPanel"),"正在努力打开面板...");
         },"尼奥超进化");
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_NeoSuperEvo");
         this.cls.initForMap(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
         super.destroy();
      }
   }
}

