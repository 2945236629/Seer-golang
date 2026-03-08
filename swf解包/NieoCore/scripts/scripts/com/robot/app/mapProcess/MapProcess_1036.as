package com.robot.app.mapProcess
{
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.Event;
   
   public class MapProcess_1036 extends BaseMapProcess
   {
      
      public function MapProcess_1036()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapManager.addEventListener(MapEvent.MAP_OBJECT_INIT_FINISH,this.addYellowArrow);
      }
      
      private function addYellowArrow(param1:Event) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_OBJECT_INIT_FINISH,this.addYellowArrow);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

