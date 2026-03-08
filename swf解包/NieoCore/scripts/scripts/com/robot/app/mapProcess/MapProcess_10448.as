package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1944;
   
   public class MapProcess_10448 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10448()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1944.start();
      }
   }
}

