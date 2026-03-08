package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10474 extends BaseMapProcess
   {
      
      public function MapProcess_10474()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86070457);
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.control.EvilWakeUpController").initForMap10474(this);
      }
   }
}

