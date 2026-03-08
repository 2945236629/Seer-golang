package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_449 extends BaseMapProcess
   {
      
      public function MapProcess_449()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task658.initTaskForMap449(this);
         Task698.initTaskForMap449(this);
      }
      
      override public function destroy() : void
      {
         Task658.destroy();
         Task698.destroy();
      }
      
      public function gotoNextMap() : void
      {
         if(Task698.checkTask698() == false)
         {
            MapManager.changeMap(450);
         }
      }
   }
}

