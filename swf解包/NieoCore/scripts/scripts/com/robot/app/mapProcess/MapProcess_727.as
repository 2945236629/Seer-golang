package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Juemingya;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_727 extends BaseMapProcess
   {
      
      public function MapProcess_727()
      {
         super();
         SocketConnection.send(1022,86064375);
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         Juemingya.initTaskFor727(this);
      }
      
      override public function destroy() : void
      {
         Juemingya.destroy();
         super.destroy();
      }
   }
}

