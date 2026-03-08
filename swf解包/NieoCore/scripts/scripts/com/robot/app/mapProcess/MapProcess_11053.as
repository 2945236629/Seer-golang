package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11053 extends BaseMapProcess
   {
      
      public function MapProcess_11053()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.LoongBadgesResonanceController").initMap11053();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.LoongBadgesResonanceController").destroy();
         super.destroy();
      }
   }
}

