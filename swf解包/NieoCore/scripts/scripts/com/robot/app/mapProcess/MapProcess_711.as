package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.utils.CommonUI;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_711 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_711()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         SocketConnection.send(1022,86056562);
         topLevel["button"].visible = false;
         i = 0;
         while(i < 4)
         {
            topLevel["leitaiBtn" + i].visible = false;
            i++;
         }
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.TigerGuardsRace");
         this.cls.init(this);
         MapListenerManager.add(conLevel["bonus"],function():void
         {
            SocketConnection.send(1022,86056589);
            ModuleManager.showModule(ClientConfig.getAppModule("DragonGuardBonusPanel"),"正在载入...");
         },"白虎守卫争夺赛最终奖励");
      }
      
      override public function destroy() : void
      {
         CommonUI.removeYellowArrow(topLevel);
         this.cls.destroy();
         this.cls = null;
      }
   }
}

