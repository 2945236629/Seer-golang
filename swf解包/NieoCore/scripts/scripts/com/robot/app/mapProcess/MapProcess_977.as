package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_977 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_977()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86072867);
      }
   }
}

