package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1004 extends BaseMapProcess
   {
      
      public function MapProcess_1004()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.DragonModoController").initForMap1004(this);
         MapListenerManager.add(depthLevel["mcModo"],function(param1:MouseEvent):void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("ModoBackMainPanel"));
         },"龙王摩多");
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.LeiyiEvolveController").destroy();
      }
   }
}

