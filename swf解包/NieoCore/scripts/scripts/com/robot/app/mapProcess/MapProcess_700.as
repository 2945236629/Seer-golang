package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_700 extends BaseMapProcess
   {
      
      public function MapProcess_700()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task849.initForMap700(this);
      }
      
      override public function destroy() : void
      {
         Task849.destroy();
         super.destroy();
      }
   }
}

