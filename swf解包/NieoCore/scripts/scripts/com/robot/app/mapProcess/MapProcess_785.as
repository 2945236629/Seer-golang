package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_785 extends BaseMapProcess
   {
      
      private var _countArr:Array = [];
      
      public function MapProcess_785()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86061445);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

