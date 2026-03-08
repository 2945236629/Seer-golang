package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1070;
   import com.robot.app.task.taskscollection.Task1084;
   import com.robot.app.task.taskscollection.Task1109;
   import com.robot.app.task.taskscollection.Task1127;
   import com.robot.app.task.taskscollection.Task1170;
   import com.robot.app.task.taskscollection.Task1250;
   import com.robot.app.task.taskscollection.Task1295;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_733 extends BaseMapProcess
   {
      
      public function MapProcess_733()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053848);
         conLevel["mainMC"].gotoAndStop(1);
         Task1070.initForMap733(this);
         Task1084.initForMap733(this);
         Task1109.initForMap733(this);
         Task1127.initForMap733(this);
         Task1170.initForMap733(this);
         Task1250.initForMap733(this);
         Task1295.initForMap733(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

