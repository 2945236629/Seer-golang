package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_935 extends BaseMapProcess
   {
      
      public function MapProcess_935()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86059497);
      }
      
      override public function destroy() : void
      {
      }
   }
}

