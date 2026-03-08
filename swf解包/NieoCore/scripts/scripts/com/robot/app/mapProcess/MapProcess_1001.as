package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1001 extends BaseMapProcess
   {
      
      public function MapProcess_1001()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("奥斯卡超进化","进入魔界之域",StatManager.RUN_ACT);
         MapListenerManager.add(depthLevel["door"],function():void
         {
            MapManager.changeMap(997);
         },"魔界之门");
      }
      
      override public function destroy() : void
      {
      }
   }
}

