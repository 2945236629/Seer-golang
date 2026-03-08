package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1152 extends BaseMapProcess
   {
      
      public function MapProcess_1152()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.YingXuePartyAddBossController").initForMap(this);
         conLevel["btn"].addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NewYearPetFestivalPanel");
      }
      
      override public function destroy() : void
      {
         conLevel["btn"].removeEventListener(MouseEvent.CLICK,this.clickHandle);
         getDefinitionByName("com.robot.app2.mapProcess.control.YingXuePartyAddBossController").destroy();
         super.destroy();
      }
   }
}

