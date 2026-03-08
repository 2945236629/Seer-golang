package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_370;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_726 extends BaseMapProcess
   {
      
      public function MapProcess_726()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86068128);
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         TaskController_370.init(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

