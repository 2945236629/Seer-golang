package com.robot.app.mapProcess
{
   import com.robot.app.control.DarkSingerController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_713 extends BaseMapProcess
   {
      
      public function MapProcess_713()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86058283);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         DarkSingerController.initForMap713(this);
      }
      
      override public function destroy() : void
      {
         DarkSingerController.destroy();
         super.destroy();
      }
   }
}

