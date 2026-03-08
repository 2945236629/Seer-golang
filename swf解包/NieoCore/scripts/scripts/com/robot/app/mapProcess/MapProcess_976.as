package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   
   public class MapProcess_976 extends BaseMapProcess
   {
      
      public function MapProcess_976()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86068389);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.checkTask();
      }
      
      private function checkTask() : void
      {
      }
      
      private function onClickKaisaHandler(param1:MouseEvent) : void
      {
      }
      
      private function completeTask() : void
      {
      }
      
      private function onClickMonsterHandler(param1:MouseEvent) : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

