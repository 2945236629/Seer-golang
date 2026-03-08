package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1908;
   
   public class MapProcess_10430 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10430()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1908.start();
      }
   }
}

