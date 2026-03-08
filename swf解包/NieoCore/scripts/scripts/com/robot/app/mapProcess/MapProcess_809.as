package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1320;
   import com.robot.app.task.taskscollection.Task1330;
   import com.robot.app.task.taskscollection.Task1415;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_809 extends BaseMapProcess
   {
      
      public function MapProcess_809()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86069809);
         Task1415.initForMap809(this);
         Task1330.initForMap809(this);
         Task1320.initForMap809(this);
      }
      
      override public function destroy() : void
      {
         Task1415.destroy();
         Task1320.destroy();
         Task1330.destroy();
      }
   }
}

