package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alert;
   import flash.events.MouseEvent;
   
   public class MapProcess_10516 extends BaseMapProcess
   {
      
      public function MapProcess_10516()
      {
         super();
      }
      
      private static function onLeveBtnCLick(param1:*) : void
      {
         Alert.show("确定要离开吗？",leave);
      }
      
      private static function leave() : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         MapManager.changeMap(990);
      }
      
      private static function onPetBagHandler(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      override protected function init() : void
      {
         super.init();
         MapListenerManager.add(topLevel["leaveBtn"],onLeveBtnCLick,"离开");
         MapListenerManager.add(topLevel["bagBtn"],onPetBagHandler,"背包");
      }
   }
}

