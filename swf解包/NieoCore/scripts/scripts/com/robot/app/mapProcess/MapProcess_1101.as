package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1101 extends BaseMapProcess
   {
      
      public function MapProcess_1101()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").initMap1101(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.PonySpecialTrainningController").destroyMap1101();
         super.destroy();
      }
   }
}

