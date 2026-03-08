package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_969 extends BaseMapProcess
   {
      
      public function MapProcess_969()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86072887);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.control.GoldenWarriorShilaimuController").initMap(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.control.GoldenWarriorShilaimuController").destroy();
      }
   }
}

