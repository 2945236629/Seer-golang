package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.active.NakedPumpkinActivity;
   import com.robot.app.task.taskscollection.Task1254;
   import com.robot.app.task.taskscollection.Task1260;
   import com.robot.app.task.taskscollection.Task1278;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_786 extends BaseMapProcess
   {
      
      public function MapProcess_786()
      {
         super();
      }
      
      override protected function init() : void
      {
         MainManager.selfVisible = true;
         ToolBarController.showOrHideAllUser(true);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1254.initForMap786(this);
         Task1260.initForMap786(this);
         Task1278.initForMap786(this);
         NakedPumpkinActivity.initForMap786();
         SocketConnection.send(1022,86063908);
      }
      
      override public function destroy() : void
      {
         Task1254.destroy();
         Task1260.destroy();
         Task1278.destroy();
         super.destroy();
         NakedPumpkinActivity.destory();
      }
   }
}

