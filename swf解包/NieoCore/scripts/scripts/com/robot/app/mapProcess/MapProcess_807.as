package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_807 extends BaseMapProcess
   {
      
      public function MapProcess_807()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053889);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         conLevel["broadcastBoard"].addEventListener(MouseEvent.CLICK,this.onBroadcastBoardClick);
         ToolTipManager.add(conLevel["broadcastBoard"],"公告牌");
      }
      
      private function onBroadcastBoardClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86053890);
         ModuleManager.showModule(ClientConfig.getAppModule("MonsterNian2014MainPanel"),"正在打开面板……");
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["broadcastBoard"]);
         conLevel["broadcastBoard"].removeEventListener(MouseEvent.CLICK,this.onBroadcastBoardClick);
      }
   }
}

