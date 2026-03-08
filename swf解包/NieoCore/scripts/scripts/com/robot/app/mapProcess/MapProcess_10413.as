package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1883;
   import com.robot.core.manager.LevelManager;
   
   public class MapProcess_10413 extends SceneAnimationMapProcess
   {
      
      public function MapProcess_10413()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         LevelManager.iconLevel.visible = false;
         TaskController_1883.scene3();
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         super.destroy();
      }
   }
}

