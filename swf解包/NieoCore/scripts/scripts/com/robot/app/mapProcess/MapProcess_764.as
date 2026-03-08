package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_764 extends BaseMapProcess
   {
      
      public function MapProcess_764()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86049271);
      }
      
      override public function destroy() : void
      {
      }
   }
}

