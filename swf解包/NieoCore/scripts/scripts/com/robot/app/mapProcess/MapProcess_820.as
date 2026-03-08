package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_820 extends BaseMapProcess
   {
      
      public function MapProcess_820()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         SocketConnection.send(1022,86062138);
         SocketConnection.send(1022,86058608);
      }
      
      override public function destroy() : void
      {
      }
   }
}

