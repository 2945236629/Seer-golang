package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_955 extends BaseMapProcess
   {
      
      public function MapProcess_955()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["game_entrance"],this.onEntranceClick);
         MapListenerManager.add(conLevel["game_entrance2"],this.onEntrance2Click);
         MapListenerManager.add(conLevel["game_entrance3"],this.onEntrance3Click);
         SocketConnection.send(1022,86064110);
      }
      
      private function onEntrance3Click(param1:MouseEvent) : void
      {
         MapManager.changeLocalMap(10398);
      }
      
      private function onEntrance2Click(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("MuseDatingMainPanel"));
      }
      
      private function onEntranceClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86064111);
         if(BufferRecordManager.getMyState(879))
         {
            ModuleManager.showModule(ClientConfig.getAppModule("LongKuMainPanel"));
         }
         else
         {
            getDefinitionByName("com.robot.app2.control.longKu.LongKuPreTask").playPreTask();
         }
      }
      
      override public function destroy() : void
      {
      }
   }
}

