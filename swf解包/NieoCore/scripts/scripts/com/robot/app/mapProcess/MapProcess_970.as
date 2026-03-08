package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_970 extends BaseMapProcess
   {
      
      public function MapProcess_970()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.LongZunController").initMap970(this);
         SocketConnection.send(1022,86068432);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

