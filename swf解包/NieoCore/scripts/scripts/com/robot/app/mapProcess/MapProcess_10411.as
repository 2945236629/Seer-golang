package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1883;
   
   public class MapProcess_10411 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10411()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1883.start();
      }
   }
}

