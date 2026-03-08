package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.AdventureInPirateCampsController;
   import com.robot.app.task.taskscollection.Task1067;
   import com.robot.app.task.taskscollection.Task1081;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.manager.map.config.MapProcessConfig;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_732 extends BaseMapProcess
   {
      
      public function MapProcess_732()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1081.initTaskForMap732(this);
         if(TasksManager.getTaskStatus(1081) == TasksManager.UN_ACCEPT || TasksManager.getTaskStatus(1081) == TasksManager.COMPLETE)
         {
            Task1067.initTaskForMap732(this);
         }
         else
         {
            TasksManager.getProStatusList(1081,function(param1:Array):void
            {
               if(!(Boolean(param1[1]) && !param1[2]))
               {
                  Task1067.initTaskForMap732(MapProcessConfig.currentProcessInstance);
               }
            });
         }
         if(TasksManager.getTaskStatus(1067) == TasksManager.UN_ACCEPT || TasksManager.getTaskStatus(1067) == TasksManager.COMPLETE)
         {
            DisplayUtil.removeForParent(conLevel["doorMC"]);
         }
         else
         {
            TasksManager.getProStatusList(1067,function(param1:Array):void
            {
               if(!param1[0])
               {
                  DisplayUtil.removeForParent(conLevel["doorMC"]);
               }
            });
         }
         AdventureInPirateCampsController.setup(this);
      }
      
      private function get task1067MC() : MovieClip
      {
         return conLevel["task1067MC"];
      }
      
      override public function destroy() : void
      {
         Task1081.destroy();
         AdventureInPirateCampsController.destroy();
      }
   }
}

