package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_966 extends BaseMapProcess
   {
      
      public function MapProcess_966()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86073388);
         getDefinitionByName("com.robot.app2.mapProcess.control.MoxiAwakeController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.MoxiAwakeController").destroy();
      }
   }
}

