package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1896;
   
   public class MapProcess_10426 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10426()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1896.start();
      }
   }
}

