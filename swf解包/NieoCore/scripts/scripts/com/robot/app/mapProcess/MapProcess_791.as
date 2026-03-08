package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1266;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_791 extends BaseMapProcess
   {
      
      public function MapProcess_791()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1266.initForMap791(this);
      }
      
      override public function destroy() : void
      {
         Task1266.destory();
      }
   }
}

