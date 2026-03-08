package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10979 extends BaseMapProcess
   {
      
      public function MapProcess_10979()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.DangerousInterstellarDoorController").initMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.DangerousInterstellarDoorController").destroy();
         super.destroy();
      }
   }
}

