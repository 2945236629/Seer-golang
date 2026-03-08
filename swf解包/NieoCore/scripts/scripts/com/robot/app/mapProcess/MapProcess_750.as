package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.ShiHuaSummerActivity;
   import com.robot.app.task.taskscollection.Task1144;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_750 extends BaseMapProcess
   {
      
      public function MapProcess_750()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053226);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         conLevel["ancientItem"].visible = false;
         if(TasksManager.getTaskStatus(1144) == TasksManager.UN_ACCEPT)
         {
            conLevel["Stone"].gotoAndStop(1);
            conLevel["Machine"].gotoAndStop(1);
         }
         else if(TasksManager.getTaskStatus(1144) == TasksManager.COMPLETE)
         {
            conLevel["Stone"].gotoAndStop(2);
            conLevel["Machine"].gotoAndStop(2);
         }
         else
         {
            TasksManager.getProStatusList(1144,function(param1:Array):void
            {
               if(!param1[3])
               {
                  conLevel["Stone"].gotoAndStop(1);
               }
               else
               {
                  conLevel["Stone"].gotoAndStop(2);
               }
               if(!param1[2])
               {
                  conLevel["Machine"].gotoAndStop(1);
               }
               else
               {
                  conLevel["Machine"].gotoAndStop(2);
               }
            });
         }
         Task1144.initTaskFor750(this);
         ShiHuaSummerActivity.initForMap750(this);
      }
      
      private function get isInActive() : Boolean
      {
         var _loc1_:Date = SystemTimerManager.sysDate;
         if(_loc1_.monthUTC == 7 && _loc1_.dateUTC >= 10 && _loc1_.dateUTC <= 16 && _loc1_.hoursUTC >= 4 && _loc1_.hoursUTC <= 5)
         {
            return true;
         }
         return false;
      }
      
      override public function destroy() : void
      {
         Task1144.destroy();
         ShiHuaSummerActivity.destroy();
      }
   }
}

