package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1105 extends BaseMapProcess
   {
      
      public function MapProcess_1105()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyElementSanctuaryController").initMap1105(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").initPonySubMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyElementSanctuaryController").destroyMap1105();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").destroyPonySubMap();
         super.destroy();
      }
   }
}

