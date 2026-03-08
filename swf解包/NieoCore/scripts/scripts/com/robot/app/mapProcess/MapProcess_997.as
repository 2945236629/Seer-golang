package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_997 extends BaseMapProcess
   {
      
      public function MapProcess_997()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86073388);
         StatManager.sendStat2014("勇闯魔界之门！不灭战魂！战神盖亚vs斗皇！","进入魔界之门场景",StatManager.RUN_ACT);
         MapListenerManager.add(conLevel["door"],function():void
         {
            MapManager.changeMap(1001);
         },"魔界之域");
         MapListenerManager.add(conLevel["door2"],function():void
         {
            MapManager.changeMap(966);
         },"创世广场");
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.control.GaiyaVsFightKingController").initForMap997(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.GaiyaVsFightKingController").destroy();
      }
   }
}

