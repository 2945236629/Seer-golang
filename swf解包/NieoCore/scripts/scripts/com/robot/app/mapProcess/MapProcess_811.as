package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1360;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_811 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_811()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86054000);
         Task1360.initForMap811(this);
         if(TasksManager.getTaskStatus(1360) != TasksManager.ALR_ACCEPT)
         {
            this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.DevilSoulContainerWaterController") as Class;
            this.cls.initForMap811(this);
         }
         MapListenerManager.add(conLevel["xuanwo"],function():void
         {
            MapManager.changeMap(722);
         },"前往星辰龙境");
      }
      
      override public function destroy() : void
      {
         Task1360.destroy();
         if(this.cls)
         {
            this.cls.destroy();
         }
      }
   }
}

