package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1095 extends BaseMapProcess
   {
      
      public function MapProcess_1095()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         StatManager.sendStat2014("巅峰圣战月度联赛","进入1095场景","巅峰圣战月度联赛");
         getDefinitionByName("com.robot.app2.control.PeakJihad2023Controller").initMap1095(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.control.PeakJihad2023Controller").destroy();
      }
   }
}

