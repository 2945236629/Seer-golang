package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1917;
   
   public class MapProcess_10439 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10439()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1917.start();
      }
   }
}

