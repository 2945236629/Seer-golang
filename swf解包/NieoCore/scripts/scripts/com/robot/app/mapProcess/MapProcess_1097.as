package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1097 extends BaseMapProcess
   {
      
      public function MapProcess_1097()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         getDefinitionByName("com.robot.app2.mapProcess.control.HelkStarRealAppearanceController").initMap1097(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.HelkStarRealAppearanceController").destroyMap1097();
         super.destroy();
      }
   }
}

