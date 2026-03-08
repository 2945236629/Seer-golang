package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1160;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_756 extends BaseMapProcess
   {
      
      public function MapProcess_756()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053231);
         conLevel["task1234mc"].visible = false;
         Task1160.initTaskFor756(this);
      }
      
      override public function destroy() : void
      {
         Task1160.destroy();
      }
   }
}

