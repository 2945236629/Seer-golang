package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_949 extends BaseMapProcess
   {
      
      public function MapProcess_949()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86065322);
         super.init();
      }
      
      override public function setup() : void
      {
         super.setup();
         getDefinitionByName("com.robot.app2.control.UnionFightController").initFor949(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.UnionFightController").destroy();
         super.destroy();
      }
   }
}

