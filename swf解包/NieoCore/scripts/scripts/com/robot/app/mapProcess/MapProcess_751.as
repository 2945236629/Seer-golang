package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_751 extends BaseMapProcess
   {
      
      public function MapProcess_751()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,84807336);
      }
      
      override public function destroy() : void
      {
      }
   }
}

