package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1111;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_742 extends BaseMapProcess
   {
      
      public function MapProcess_742()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1111.initTaskForMap742(this);
      }
      
      override public function destroy() : void
      {
         Task1111.destroy();
      }
   }
}

