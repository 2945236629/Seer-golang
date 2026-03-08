package com.robot.app.mapProcess
{
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10943 extends BaseMapProcess
   {
      
      public function MapProcess_10943()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         LevelManager.toolsLevel.visible = false;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         LevelManager.iconLevel.visible = true;
         LevelManager.toolsLevel.visible = true;
      }
   }
}

