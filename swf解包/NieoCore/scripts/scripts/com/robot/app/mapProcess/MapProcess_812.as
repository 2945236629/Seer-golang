package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1370;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_812 extends BaseMapProcess
   {
      
      public function MapProcess_812()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86054147);
         Task1370.initForMap812(this);
      }
      
      override public function destroy() : void
      {
         Task1370.destroy();
      }
   }
}

