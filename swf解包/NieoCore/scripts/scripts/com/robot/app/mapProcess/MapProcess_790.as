package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1805;
   import com.robot.app.task.taskscollection.Task1812;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_790 extends BaseMapProcess
   {
      
      private var currentTask:uint;
      
      public function MapProcess_790()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053600);
         if(TasksManager.getTaskStatus(1805) == TasksManager.COMPLETE)
         {
            this.currentTask = 1812;
            Task1812.initFor790(this);
         }
         else
         {
            this.currentTask = 1805;
            Task1805.initFor790(this);
         }
         SocketConnection.send(1022,86063404);
      }
      
      override public function destroy() : void
      {
         if(this.currentTask == 1805)
         {
            Task1805.destroy();
         }
         if(this.currentTask == 1812)
         {
            Task1812.destroy();
         }
      }
   }
}

