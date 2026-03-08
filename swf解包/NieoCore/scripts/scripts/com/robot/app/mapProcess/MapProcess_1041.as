package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.FightingSpiritOfAFamilyCrisisTaskController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1041 extends BaseMapProcess
   {
      
      public function MapProcess_1041()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         FightingSpiritOfAFamilyCrisisTaskController.initForMap1041(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         FightingSpiritOfAFamilyCrisisTaskController.destroy();
      }
   }
}

