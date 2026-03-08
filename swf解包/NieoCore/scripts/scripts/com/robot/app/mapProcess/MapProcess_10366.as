package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1234;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_10366 extends BaseMapProcess
   {
      
      public function MapProcess_10366()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1234.initForMap782(this);
         SocketConnection.send(1022,86062837);
      }
      
      override public function destroy() : void
      {
         Task1234.destroy();
      }
   }
}

