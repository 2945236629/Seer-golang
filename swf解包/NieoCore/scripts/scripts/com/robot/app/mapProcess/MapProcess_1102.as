package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1102 extends BaseMapProcess
   {
      
      public function MapProcess_1102()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.control.PonyNothingnessSanctuaryController").initMap1102(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").initPonySubMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.PonyNothingnessSanctuaryController").destroyMap1102();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").destroyPonySubMap();
         super.destroy();
      }
   }
}

