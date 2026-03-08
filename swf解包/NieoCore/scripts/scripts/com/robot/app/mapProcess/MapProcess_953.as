package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_953 extends BaseMapProcess
   {
      
      public function MapProcess_953()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_heermosi").destroy();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_heermosi").initForMap(this);
      }
      
      override public function setup() : void
      {
         super.setup();
      }
   }
}

