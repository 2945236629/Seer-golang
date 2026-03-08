package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1221 extends BaseMapProcess
   {
      
      public function MapProcess_1221()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("1225年费预约大礼包","进入1144号场景",StatManager.RUN_ACT_2015);
         conLevel["npc"].buttonMode = true;
         conLevel["npc"].addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("Yearvip2017MainPanel");
      }
      
      override public function destroy() : void
      {
         conLevel["npc"].removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

