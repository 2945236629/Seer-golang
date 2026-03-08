package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task3010;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10529 extends BaseMapProcess
   {
      
      public function MapProcess_10529()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("向龙族宣战","进入场景",StatManager.RUN_ACT);
         Task3010.initTaskForMap348(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

