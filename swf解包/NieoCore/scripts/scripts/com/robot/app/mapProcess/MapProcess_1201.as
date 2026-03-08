package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   
   public class MapProcess_1201 extends MapProcess_1200
   {
      
      public function MapProcess_1201()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         conLevel["go_1"].addEventListener(MouseEvent.CLICK,this.goappHandle);
         maxnum = 60;
      }
      
      private function goappHandle(param1:MouseEvent) : void
      {
         SocketConnection.sendByQueue(45674,[5,0]);
         StatManager.sendStat2014("0729夏令营框架","在VIP场景中点击游戏城","2016星际夏令营");
         ModuleManager.showAppModule("SummerGameCity0729Panel");
      }
      
      override public function destroy() : void
      {
         conLevel["go_1"].removeEventListener(MouseEvent.CLICK,this.goappHandle);
         super.destroy();
      }
   }
}

