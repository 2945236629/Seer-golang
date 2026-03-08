package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_450 extends BaseMapProcess
   {
      
      public function MapProcess_450()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         MountGodController.setup(this);
         ToolBarController.showOrHideAllUser(false);
      }
      
      override public function destroy() : void
      {
         MountGodController.destroy();
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

