package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10914 extends BaseMapProcess
   {
      
      public function MapProcess_10914()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.XuanWuEvoFightController").init();
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster();
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         getDefinitionByName("com.robot.app2.mapProcess.control.XuanWuEvoFightController").destroy();
         super.destroy();
      }
   }
}

