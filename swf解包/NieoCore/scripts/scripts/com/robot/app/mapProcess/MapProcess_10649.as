package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10649 extends BaseMapProcess
   {
      
      public function MapProcess_10649()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.WindtalkerIntelligenceCollectorsIntMapController").initMap(this);
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         getDefinitionByName("com.robot.app2.mapProcess.control.WindtalkerIntelligenceCollectorsIntMapController").destroy();
         super.destroy();
      }
   }
}

