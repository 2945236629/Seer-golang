package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_766 extends BaseMapProcess
   {
      
      public function MapProcess_766()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86049270);
      }
      
      override public function destroy() : void
      {
      }
   }
}

