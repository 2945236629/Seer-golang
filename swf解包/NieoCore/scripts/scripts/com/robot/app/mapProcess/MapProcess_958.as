package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_958 extends BaseMapProcess
   {
      
      public function MapProcess_958()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.CallDoorController").initMap958(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

