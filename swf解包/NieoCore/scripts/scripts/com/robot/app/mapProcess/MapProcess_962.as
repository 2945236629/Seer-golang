package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_962 extends BaseMapProcess
   {
      
      public function MapProcess_962()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86067178);
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_anheiKaxiusi").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_anheiKaxiusi").destroy();
      }
   }
}

