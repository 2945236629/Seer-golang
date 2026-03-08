package com.robot.app.mapProcess
{
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_673 extends BaseMapProcess
   {
      
      public static var isHere:Boolean = false;
      
      public function MapProcess_673()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(isHere == false)
         {
            isHere = true;
            MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.onChangeMap);
         }
      }
      
      private function onChangeMap(param1:MapEvent) : void
      {
         if(param1.mapModel.id != 673)
         {
            isHere = false;
            MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.onChangeMap);
         }
      }
      
      override public function destroy() : void
      {
      }
   }
}

