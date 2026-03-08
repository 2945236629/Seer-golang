package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_771 extends BaseMapProcess
   {
      
      public function MapProcess_771()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("布鲁卡卡A类复用","进入活动场景",StatManager.RUN_ACT);
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_bulukaka").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_bulukaka").destroy();
      }
   }
}

