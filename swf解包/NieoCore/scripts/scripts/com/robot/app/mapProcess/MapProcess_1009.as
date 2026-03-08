package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1009 extends BaseMapProcess
   {
      
      private var posiY:int;
      
      public function MapProcess_1009()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.showOrHideAllUser(false);
         getDefinitionByName("com.robot.app2.mapProcess.control.GaiaMachineController").initMap(this);
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         this.posiY = ToolBarController.panel.y;
         ToolBarController.panel.y = 2000;
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.y = this.posiY;
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ToolBarController.showOrHideAllUser(true);
         getDefinitionByName("com.robot.app2.mapProcess.control.GaiaMachineController").destroy();
      }
   }
}

