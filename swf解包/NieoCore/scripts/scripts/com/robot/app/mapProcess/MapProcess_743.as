package com.robot.app.mapProcess
{
   import com.robot.app.control.GameStartController;
   import com.robot.app.games.GameStorageManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   
   public class MapProcess_743 extends BaseMapProcess
   {
      
      public function MapProcess_743()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["game"],this.onGameClick,"米咔站稳");
      }
      
      private function onGameClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86048966);
         MapManager.removeAppArrow();
         GameStorageManager.freshLastGame(41018);
         GameStartController.show("standingStart","StandingGame",true,2);
      }
      
      override public function destroy() : void
      {
      }
   }
}

