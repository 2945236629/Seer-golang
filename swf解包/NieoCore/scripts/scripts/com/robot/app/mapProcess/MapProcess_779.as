package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.IronCollectActivity;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_779 extends BaseMapProcess
   {
      
      public function MapProcess_779()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053236);
         SocketConnection.send(1022,86053241);
         IronCollectActivity.init(this);
      }
      
      override public function destroy() : void
      {
         IronCollectActivity.destroy();
      }
   }
}

