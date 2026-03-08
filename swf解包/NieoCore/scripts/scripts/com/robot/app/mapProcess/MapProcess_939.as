package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_939 extends BaseMapProcess
   {
      
      public function MapProcess_939()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86064740);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskmc"];
      }
      
      private function onStartTask(param1:MouseEvent = null) : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

