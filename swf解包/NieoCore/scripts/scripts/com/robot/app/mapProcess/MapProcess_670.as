package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_670 extends BaseMapProcess
   {
      
      public function MapProcess_670()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         TigerKingTrainingController.tigerKing(this);
         GhostTigerKingTrainingController.setup(this);
         Task1751.initTaskForMap670(this);
      }
      
      override public function destroy() : void
      {
         TigerKingTrainingController.destroy();
         GhostTigerKingTrainingController.destroy();
      }
   }
}

