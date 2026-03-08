package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_787 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_787()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86064054);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

