package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1415;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10265 extends BaseMapProcess
   {
      
      public function MapProcess_10265()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1415.initForMap10265(this);
      }
      
      override public function destroy() : void
      {
         Task1415.destroy();
      }
   }
}

