package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1075 extends BaseMapProcess
   {
      
      public function MapProcess_1075()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      private function onClickBtn(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("DragonVeinPVEPanel"));
      }
      
      override public function setup() : void
      {
         super.setup();
      }
   }
}

