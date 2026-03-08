package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_749 extends BaseMapProcess
   {
      
      public function MapProcess_749()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053218);
         SocketConnection.send(1022,86053222);
      }
      
      override public function destroy() : void
      {
      }
   }
}

