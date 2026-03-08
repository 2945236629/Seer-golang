package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1114 extends BaseMapProcess
   {
      
      public function MapProcess_1114()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyForeverSanctuaryController").initMap1114(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").initPonySubMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyForeverSanctuaryController").destroyMap1114();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").destroyPonySubMap();
         super.destroy();
      }
   }
}

