package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_982 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_982()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("勇闯魔窟之门——耐力的试炼","进入场景魔窟之门的",StatManager.RUN_ACT);
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.BreakdownCaveDoorForKaxiusiController");
         getDefinitionByName("com.robot.app2.control.OpenDoorController20140418").initMap(this,this.cls.initForMap);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
         getDefinitionByName("com.robot.app2.control.OpenDoorController20140418").destroy();
      }
   }
}

