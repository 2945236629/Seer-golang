package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1420;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10267 extends BaseMapProcess
   {
      
      public function MapProcess_10267()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1420.initForMap10267(this);
      }
      
      override public function destroy() : void
      {
         Task1420.destroy();
      }
   }
}

