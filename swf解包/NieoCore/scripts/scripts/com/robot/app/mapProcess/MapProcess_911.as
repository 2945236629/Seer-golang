package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_911 extends BaseMapProcess
   {
      
      public function MapProcess_911()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.showOrHideAllUser(false);
      }
      
      override public function destroy() : void
      {
         ToolBarController.showOrHideAllUser(ToolBarController.panel.panelIsShow);
      }
   }
}

