package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1916;
   
   public class MapProcess_10435 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10435()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TaskController_1916.start();
      }
   }
}

