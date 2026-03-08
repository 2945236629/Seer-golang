package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_11761 extends BaseMapProcess
   {
      
      public function MapProcess_11761()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11761;
         depthLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         if(param1.target.name == "btn")
         {
            ModuleManager.showAppModule("EventCollectionPanel");
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         ToolBarController.panel.visible = true;
      }
   }
}

