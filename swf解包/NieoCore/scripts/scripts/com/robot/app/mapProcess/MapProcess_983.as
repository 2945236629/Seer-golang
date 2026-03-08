package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_983 extends BaseMapProcess
   {
      
      public function MapProcess_983()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86072886);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.SpeedKingActivityController").initMap983(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.EternalKingReviveController").initMap983(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.SpeedKingActivityController").destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.EternalKingReviveController").destroy();
      }
   }
}

