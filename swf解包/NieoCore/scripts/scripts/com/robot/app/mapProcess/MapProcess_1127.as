package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1127 extends BaseMapProcess
   {
      
      public function MapProcess_1127()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyLastWakeUpController").initMap1127(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyLastWakeUpController").destroyMap1127();
         super.destroy();
      }
   }
}

