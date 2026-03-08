package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_11052 extends BaseMapProcess
   {
      
      public function MapProcess_11052()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["union"].addEventListener(MouseEvent.CLICK,this.clickHanle);
      }
      
      public function showMapObjectVisible(param1:Boolean) : void
      {
         conLevel["union"].visible = param1;
      }
      
      private function clickHanle(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NewseerGodofwarAlliancePanel");
      }
      
      override public function destroy() : void
      {
         conLevel["union"].removeEventListener(MouseEvent.CLICK,this.clickHanle);
      }
   }
}

