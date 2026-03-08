package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1872;
   
   public class MapProcess_10407 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10407()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1872.start();
      }
   }
}

