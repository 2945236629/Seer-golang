package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_476 extends BaseMapProcess
   {
      
      public function MapProcess_476()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["lightAct"].visible = false;
         Task1129.initFor476(this);
         MysteryMon.init(this);
      }
      
      override public function destroy() : void
      {
         Task1129.destroy();
         MysteryMon.destroy();
      }
      
      public function gotoLastMap() : void
      {
         MapManager.changeMap(497);
      }
   }
}

