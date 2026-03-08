package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_10569 extends BaseMapProcess
   {
      
      public function MapProcess_10569()
      {
         StatManager.sendStat2014("炼狱魔神大形态","进入副本场景",StatManager.RUN_ACT);
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.visible = false;
         LevelManager.iconLevel.visible = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         super.init();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "trainBtn":
               StatManager.sendStat2014("炼狱魔神大形态","副本|点击炼狱小神NPC",StatManager.RUN_ACT);
               ModuleManager.showModule(ClientConfig.getAppModule("HellLordFightPanel"));
               break;
            case "getItemBtn":
               StatManager.sendStat2014("炼狱魔神大形态","副本|点击炼狱精华NPC",StatManager.RUN_ACT);
               ModuleManager.showModule(ClientConfig.getAppModule("HellLordEssenceMakePanel"));
               break;
            case "exitBtn":
               MapManager.changeMap(1010);
         }
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.visible = true;
         LevelManager.iconLevel.visible = true;
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

