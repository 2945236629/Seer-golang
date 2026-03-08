package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1171;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   
   public class MapProcess_768 extends BaseMapProcess
   {
      
      public function MapProcess_768()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053233);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         MapListenerManager.add(conLevel["entryDoor"],this.onDoorClick,"前往冰雪领地");
         Task1171.initTaskFor768(this);
      }
      
      private function onDoorClick(param1:MouseEvent) : void
      {
         MapManager.changeMap(770);
      }
      
      override public function destroy() : void
      {
         Task1171.destroy();
      }
   }
}

