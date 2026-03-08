package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_754 extends BaseMapProcess
   {
      
      public function MapProcess_754()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053228);
      }
      
      override public function destroy() : void
      {
      }
   }
}

