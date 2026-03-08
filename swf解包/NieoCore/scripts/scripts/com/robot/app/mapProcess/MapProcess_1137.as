package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1137 extends BaseMapProcess
   {
      
      public function MapProcess_1137()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("11202015淘米游戏节精彩抢鲜","进入1137号场景",StatManager.RUN_ACT_2015);
      }
   }
}

