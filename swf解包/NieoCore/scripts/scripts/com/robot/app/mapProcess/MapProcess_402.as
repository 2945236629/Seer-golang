package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_402 extends BaseMapProcess
   {
      
      public function MapProcess_402()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053253);
         SocketConnection.send(1022,86053255);
      }
      
      override public function destroy() : void
      {
      }
   }
}

