package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1111 extends BaseMapProcess
   {
      
      public function MapProcess_1111()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySamsaraSanctuaryController").initMap1111(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").initPonySubMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySamsaraSanctuaryController").destroyMap1111();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").destroyPonySubMap();
         super.destroy();
      }
   }
}

