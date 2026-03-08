package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.CommonUI;
   
   public class MapProcess_1039 extends BaseMapProcess
   {
      
      public function MapProcess_1039()
      {
         super();
      }
      
      override protected function init() : void
      {
      }
      
      private function checkState() : void
      {
         switch(MapManager.SpecialState)
         {
            case 0:
               break;
            case 1:
               MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.addYellowArrowToA);
               break;
            case 2:
               MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.addYellowArrowToB);
               break;
            case 3:
               break;
            case 4:
               MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.addYellowArrowToC);
               break;
            case 5:
               break;
            case 6:
               Alarm.show("出入万圣节场景有机会遇到捣蛋的精灵。");
               break;
            case 7:
               MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.OpenView);
         }
      }
      
      private function OpenView(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.OpenView);
         ModuleManager.showModule(ClientConfig.getAppModule("WalloweenLightMainPanel"));
      }
      
      private function addYellowArrowToC(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.addYellowArrowToC);
         CommonUI.addYellowArrowForMapObject("walloween_night_king");
      }
      
      private function addYellowArrowToB(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.addYellowArrowToB);
         CommonUI.addYellowArrowForMapObject("walloween_part");
      }
      
      private function addYellowArrowToA(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,this.addYellowArrowToA);
         CommonUI.addYellowArrowForMapObject("walloween_box","btnLevel");
      }
      
      override public function destroy() : void
      {
      }
   }
}

