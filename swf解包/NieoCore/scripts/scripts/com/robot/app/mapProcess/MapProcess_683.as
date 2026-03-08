package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_683 extends BaseMapProcess
   {
      
      public function MapProcess_683()
      {
         super();
      }
      
      override protected function init() : void
      {
      }
      
      private function showPanel(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("AmethystOfLife"),"","9月19日-9月25日 11:00-13:00");
      }
      
      override public function destroy() : void
      {
      }
   }
}

