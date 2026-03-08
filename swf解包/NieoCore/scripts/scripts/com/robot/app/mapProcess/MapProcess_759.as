package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.TheSleepingEliza;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_759 extends BaseMapProcess
   {
      
      public function MapProcess_759()
      {
         super();
         SocketConnection.send(1022,84807633);
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053229);
         TheSleepingEliza.init(this);
      }
      
      override public function destroy() : void
      {
         TheSleepingEliza.destroy();
      }
   }
}

