package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_991 extends BaseMapProcess
   {
      
      public function MapProcess_991()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86073517);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

