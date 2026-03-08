package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.active.MushRoomActive;
   import com.robot.core.CommandID;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.SimpleAlarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_725 extends BaseMapProcess
   {
      
      public function MapProcess_725()
      {
         super();
      }
      
      override protected function init() : void
      {
         MushRoomActive.init(this);
         this.initRoad();
      }
      
      private function initRoad() : void
      {
         this.bridge.buttonMode = true;
         this.bridge.addEventListener(MouseEvent.CLICK,this.onShowRoad);
      }
      
      private function onShowRoad(param1:MouseEvent) : void
      {
         this.bridge.buttonMode = false;
         this.bridge.removeEventListener(MouseEvent.CLICK,this.onShowRoad);
         this.bridge.gotoAndStop(2);
         DisplayUtil.removeForParent(typeLevel["road"]);
         MapManager.currentMap.makeMapArray();
         SimpleAlarm.show("你破解了蘑菇洞的入口机关");
         if(MainManager.actorInfo.dailyResArr[89] < 5)
         {
            ++MainManager.actorInfo.dailyResArr[89];
            SocketConnection.send(CommandID.MUSH_ROOM_SHOW_ROAD);
         }
      }
      
      private function get bridge() : MovieClip
      {
         return conLevel["road"];
      }
      
      override public function destroy() : void
      {
         this.bridge.removeEventListener(MouseEvent.CLICK,this.onShowRoad);
         MushRoomActive.destroy();
         super.destroy();
      }
   }
}

