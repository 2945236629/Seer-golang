package com.robot.app.mapProcess
{
   import com.robot.app.control.GameStartController;
   import com.robot.app.games.GameStorageManager;
   import com.robot.app.task.taskscollection.Task1226;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.utils.CommonUI;
   import flash.events.MouseEvent;
   
   public class MapProcess_778 extends BaseMapProcess
   {
      
      public function MapProcess_778()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053236);
         SocketConnection.send(1022,86053240);
         this.initGame();
         Task1226.initTaskFor778(this);
      }
      
      private function initGame() : void
      {
         if(conLevel["gameMC"])
         {
            MapListenerManager.add(conLevel["gameMC"],this.startGame,"古墓历险");
         }
      }
      
      private function startGame(param1:MouseEvent) : void
      {
         if(!BufferRecordManager.getState(MainManager.actorInfo,409))
         {
            CommonUI.removeYellowArrow(conLevel["gameMC"]);
            BufferRecordManager.setState(MainManager.actorInfo,409,true);
         }
         SocketConnection.send(1022,86050144);
         MapManager.removeAppArrow();
         GameStorageManager.freshLastGame(41019);
         GameStartController.show("adventureStart","adventureGame");
      }
      
      override public function destroy() : void
      {
         Task1226.destroy();
      }
   }
}

