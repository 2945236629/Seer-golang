package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.FireFoxEnvolutionController;
   import com.robot.app.task.taskscollection.Task796;
   import com.robot.app.task.taskscollection.Task801;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10053 extends BaseMapProcess
   {
      
      public function MapProcess_10053()
      {
         var map:BaseMapProcess = null;
         super();
         FireFoxEnvolutionController.setup(this);
         map = this;
         animatorLevel["task_801_1"].visible = false;
         animatorLevel["task_796_3"].visible = false;
         Task801.initTaskForMap10053(this);
         TasksManager.getProStatusList(801,function(param1:Array):void
         {
            if(!param1[0] || param1[0] && !param1[1])
            {
               return;
            }
            Task796.initTaskForMap10053(map);
         });
      }
      
      override public function destroy() : void
      {
         Task801.destroy();
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

