package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1094 extends BaseMapProcess
   {
      
      public function MapProcess_1094()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         getDefinitionByName("com.robot.app2.mapProcess.control.MysteriousAncientBladeMasterController").initMap1094(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.MysteriousAncientPaladinController").initMap1094(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.MysteriousAncientBladeMasterController").destroyMap1094();
         getDefinitionByName("com.robot.app2.mapProcess.control.MysteriousAncientPaladinController").destroyMap1094();
         super.destroy();
      }
   }
}

