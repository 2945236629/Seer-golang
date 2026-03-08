package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1202;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_773 extends BaseMapProcess
   {
      
      public function MapProcess_773()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053235);
         Task1202.initTaskFor773(this);
      }
      
      override public function destroy() : void
      {
         Task1202.destroy();
      }
   }
}

