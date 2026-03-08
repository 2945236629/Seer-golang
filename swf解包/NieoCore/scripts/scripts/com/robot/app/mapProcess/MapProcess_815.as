package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_815 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_815()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86060336);
         SocketConnection.send(1022,86055833);
         MapListenerManager.add(conLevel["evBtn"],function():void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("ElectricShockRabbitEvolutionPanel"));
         },"电击兔超进化");
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController4");
         this.cls.initForMap(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
         super.destroy();
      }
   }
}

