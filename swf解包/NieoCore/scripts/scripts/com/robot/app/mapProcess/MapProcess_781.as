package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_781 extends BaseMapProcess
   {
      
      public function MapProcess_781()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86052432);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
      }
   }
}

