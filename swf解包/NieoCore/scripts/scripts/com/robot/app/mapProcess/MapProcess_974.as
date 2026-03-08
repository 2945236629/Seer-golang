package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_974 extends BaseMapProcess
   {
      
      public function MapProcess_974()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_hell").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_hell").destroy();
         super.destroy();
      }
   }
}

