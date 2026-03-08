package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1883;
   import com.robot.core.manager.LevelManager;
   
   public class MapProcess_10414 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10414()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         LevelManager.iconLevel.visible = false;
         TaskController_1883.scene4();
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         super.destroy();
      }
   }
}

