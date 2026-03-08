package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1125 extends BaseMapProcess
   {
      
      public function MapProcess_1125()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyDeathDarkShadowController").initMap1125(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.PonyDeathDarkShadowController").destroyMap1125();
         super.destroy();
      }
   }
}

