package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.app.battleLab.BattleLabController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10050 extends BaseMapProcess
   {
      
      public function MapProcess_10050()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapManager.currentMap.spaceLevel.mouseEnabled = false;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         BattleLabController.getInstance().init(this);
      }
      
      override public function destroy() : void
      {
         MapManager.currentMap.spaceLevel.mouseEnabled = true;
         BattleLabController.getInstance().destory();
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

