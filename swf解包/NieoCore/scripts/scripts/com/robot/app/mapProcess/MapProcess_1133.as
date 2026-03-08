package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1133 extends BaseMapProcess
   {
      
      public function MapProcess_1133()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.WindWhispersForestGuardianController").enterMap();
         getDefinitionByName("com.robot.app2.mapProcess.control.SaveWindWisperTribeController").initMap1133(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.WindWhispersForestGuardianController").destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.SaveWindWisperTribeController").destroyMap1133();
         super.destroy();
      }
   }
}

