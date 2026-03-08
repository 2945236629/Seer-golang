package com.robot.app.mapProcess
{
   import com.robot.core.config.xml.WeeklyTasksController;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.Event;
   
   public class MapProcess_1044 extends BaseMapProcess
   {
      
      public function MapProcess_1044()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["shop"],function(param1:Event):void
         {
            WeeklyTasksController.go(18);
         },"淘米游戏节商店");
      }
      
      override public function destroy() : void
      {
      }
   }
}

