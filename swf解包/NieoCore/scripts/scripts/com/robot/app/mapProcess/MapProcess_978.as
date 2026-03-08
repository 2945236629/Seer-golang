package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_978 extends BaseMapProcess
   {
      
      public function MapProcess_978()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86070055);
         super.init();
         getDefinitionByName("com.robot.app2.control.KaxiusiApotheosizeMysteryControl").initForMap978();
      }
   }
}

