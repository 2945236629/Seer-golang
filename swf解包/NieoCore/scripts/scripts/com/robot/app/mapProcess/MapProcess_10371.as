package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_10371 extends BaseMapProcess
   {
      
      public function MapProcess_10371()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86063651);
      }
      
      override public function destroy() : void
      {
      }
   }
}

