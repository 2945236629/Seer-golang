package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1042 extends BaseMapProcess
   {
      
      public function MapProcess_1042()
      {
         super();
         StatManager.sendStat2014("虎啸风雷雷霆虎卫","进入1042场景",StatManager.RUN_ACT);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

