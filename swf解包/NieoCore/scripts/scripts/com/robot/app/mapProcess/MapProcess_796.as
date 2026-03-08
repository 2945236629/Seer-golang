package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1281;
   import com.robot.app.task.taskscollection.Task1288;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_796 extends BaseMapProcess
   {
      
      public function MapProcess_796()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053247);
         SocketConnection.send(1022,86053249);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1281.initForMap796(this);
         Task1288.initForMap796(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.EclipseSptController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         Task1281.destroy();
         Task1288.destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.EclipseSptController").destroy();
      }
   }
}

