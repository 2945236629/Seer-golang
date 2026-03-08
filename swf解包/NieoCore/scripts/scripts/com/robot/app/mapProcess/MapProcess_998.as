package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_998 extends BaseMapProcess
   {
      
      public function MapProcess_998()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86073388);
         StatManager.sendStat2014("勇闯魔界之门！不灭战魂！战神盖亚vs斗皇！","进入斗之殿场景",StatManager.RUN_ACT);
         MapListenerManager.add(depthLevel["door"],function():void
         {
            StatManager.sendStat2014("勇闯魔界之门！不灭战魂！战神盖亚vs斗皇！","离开斗之殿场景",StatManager.RUN_ACT);
            MapManager.changeMap(997);
         },"魔界之门");
         MapListenerManager.add(depthLevel["equ"],function():void
         {
            StatManager.sendStat2014("勇闯魔界之门！不灭战魂！战神盖亚vs斗皇！","点击获取盖亚装置",StatManager.RUN_ACT);
            ModuleManager.showModule(ClientConfig.getAppModule("GaiyaFreeToAllPanel"));
         },"盖亚免费获得");
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.control.GaiyaVsFightKingController").initForMap998(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.GaiyaVsFightKingController").destroy();
      }
   }
}

