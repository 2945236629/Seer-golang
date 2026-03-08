package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.HigherFightController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10093 extends BaseMapProcess
   {
      
      public function MapProcess_10093()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.showOrHideAllUser(false);
         HigherFightController.init(this);
      }
      
      override public function destroy() : void
      {
         ToolBarController.showOrHideAllUser(ToolBarController.panel.panelIsShow);
      }
   }
}

