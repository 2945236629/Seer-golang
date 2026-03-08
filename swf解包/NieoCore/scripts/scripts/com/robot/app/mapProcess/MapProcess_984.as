package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_984 extends BaseMapProcess
   {
      
      public function MapProcess_984()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86070888);
         super.init();
         getDefinitionByName("com.robot.app2.control.LordOfWarController").initForMap984();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

