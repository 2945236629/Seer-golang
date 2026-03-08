package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_716 extends BaseMapProcess
   {
      
      public function MapProcess_716()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,84806810);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

