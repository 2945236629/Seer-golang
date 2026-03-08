package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task86;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10011 extends BaseMapProcess
   {
      
      public function MapProcess_10011()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.y = 660;
         Task86.init(this);
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.y = 0;
         Task86.destory();
      }
   }
}

