package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_664 extends BaseMapProcess
   {
      
      public function MapProcess_664()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task795.initTaskForMap664(this);
      }
      
      override public function destroy() : void
      {
         Task795.destroy();
      }
   }
}

