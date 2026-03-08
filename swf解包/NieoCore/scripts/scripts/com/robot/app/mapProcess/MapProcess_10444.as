package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1933;
   
   public class MapProcess_10444 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10444()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1933.start();
      }
   }
}

