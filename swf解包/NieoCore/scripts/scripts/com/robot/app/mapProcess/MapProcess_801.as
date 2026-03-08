package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1297;
   import com.robot.app.task.taskscollection.Task1306;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_801 extends BaseMapProcess
   {
      
      public function MapProcess_801()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053247);
         SocketConnection.send(1022,86053252);
         Task1297.initForMap801(this);
         Task1306.initForMap801(this);
      }
      
      override public function destroy() : void
      {
         Task1297.destroy();
         Task1306.destroy();
      }
   }
}

